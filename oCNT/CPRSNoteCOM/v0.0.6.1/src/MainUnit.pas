unit MainUnit;

{
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

     Developer: Theodore Fontana
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464
}


{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Dialogs, Forms, SysUtils, ComObj, CPRSNoteCOM_TLB, CPRSChart_TLB,
  uExtndComBroker, StdVcl;

type
  TCPRSNoteObject = class(TAutoObject, ICPRSNoteObject, ICPRSExtension)
    protected
      function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
      const Param1, Param2, Param3: WideString; var Data1,
      Data2: WideString): WordBool; safecall;
  end;

  TLaunchCNT = function(Broker: PCPRSComBroker): Pointer; stdcall;

var
  CNTDLL: THandle;
  LaunchCNT: TLaunchCNT;
  CNTP: ^TForm;
  CNTF: TForm;
  State,Another: Integer;

implementation

uses ComServ;

function TCPRSNoteObject.Execute(const CPRSBroker: ICPRSBroker;
  const CPRSState: ICPRSState; const Param1, Param2, Param3: WideString;
  var Data1, Data2: WideString): WordBool;
var
  Path: string;
begin
  Result := False;

  //Only one OCNT at a time
  if CNTP <> nil then
  begin
    ShowMessage('A OCNT is already active.');

    //Since we cannot allow the Process to end if it spawns again because it would
    //kill our thread with CPRS with have to stay in here. So a better way to go about
    //it would be to wait until the other DLL has been closed and then carry through.
    CNTF.Show;
    State := 0;
    repeat
      Application.HandleMessage;
      if not CNTF.Showing then State := 1;
    until State <> 0;

    if CNTP <> nil then CNTF.Free;
    CNTP := nil;
  end else
  begin
    RPCBrokerV := nil;
    RPCBrokerV.EnsureBroker;
    RPCBrokerV.COMBroker := CPRSBroker;
    RPCBrokerV.CPRSState := CPRSState;
    RPCBrokerV.CPRSHandle := Cardinal(CPRSState.Handle);
    RPCBrokerV.TIUNote.Import := Data2;

    try
      RPCBrokerV.SetContext('DSIO OCNT CONTEXT');
      Path := RPCBrokerV.sCallV('DSIO OCNT GET LOCATION', []);

      if Path[Length(Path)] <> '\' then
      Path := Path + '\'+ Param3
      else Path := Path + Param3;

      CNTDLL := SafeLoadLibrary(Path);
      if CNTDLL <> 0 then
      begin
        LaunchCNT := GetProcAddress(CNTDLL,'LaunchCNT');
        if Assigned(LaunchCNT) then
        begin
          try
            CNTP := LaunchCNT(@RPCBrokerV);
            CNTF := CNTP^;

            //Hold the active OCNT so you don't lose the windows Thread lock in CPRS
            //If not done here the alternative is to ShowModal in LaunchCNT rather than Show

            //This is a merger of Show and ShowModal. If we Show then CPRS releases the process
            //and the Thread used by ICPRSBroker is released - Windows.CriticalSection
            //However, if we use ShowModal we cannot access CPRS while the OCNT is up

            CNTF.Show;
            State := 0;
            repeat
              Application.HandleMessage;
              if not CNTF.Showing then State := 1;
            until State <> 0;

            //Pass the Note to CPRS
            Data1 := RPCBrokerV.TIUNote.Lines.Text;
            if Data1 <> '' then
            Result := True;

            if CNTP <> nil then CNTF.Free;
            CNTP := nil;

            RPCBrokerV.Free;
          except
            On E : Exception do
            begin
              ShowMessage(E.Message);
              if CNTP <> nil then CNTF.Free;
              CNTP := nil;
              FreeLibrary(CNTDLL);
            end;
          end;
        end;
        if CNTDLL <> 0 then FreeLibrary(CNTDLL);
      end else
      ShowMessage('Unable to load library at' + #13#10 + Path);
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  end;
  if CNTDLL <> 0 then FreeLibrary(CNTDLL);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TCPRSNoteObject, Class_CPRSNoteObject,
    ciMultiInstance, tmApartment);
end.
