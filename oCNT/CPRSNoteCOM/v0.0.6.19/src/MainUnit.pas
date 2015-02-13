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
  uExtndComBroker, Messages, StdVcl, Classes;

type
  TCPRSNoteObject = class(TAutoObject, ICPRSNoteObject, ICPRSExtension)
    private
      fMsgHandlerHWND : HWND;
      procedure WNDMethod(var Msg: TMessage);
      procedure ShowoCNT;
    protected
      function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
      const Param1, Param2, Param3: WideString; var Data1,
      Data2: WideString): WordBool; safecall;
  end;

  TLaunchoCNT = function(Broker: PCPRSComBroker): Pointer; stdcall;

var
  oCNTDLL: THandle;
  LaunchoCNT: TLaunchoCNT;
  oCNTP: ^TForm;
  State,Another: Integer;
  WM_CPRS_TIMEOUT_COMOBJECT: Cardinal;

implementation

uses ComServ;

function TCPRSNoteObject.Execute(const CPRSBroker: ICPRSBroker;
  const CPRSState: ICPRSState; const Param1, Param2, Param3: WideString;
  var Data1, Data2: WideString): WordBool;
var
  Path: string;
begin
//  ReportMemoryLeaksOnShutdown := True;  //debug

  Result := False;

  if oCNTP <> nil then
  begin
    //Since we cannot allow the Process to end if it spawns again because it would
    //kill our thread with CPRS with have to stay in here. So a better way to go about
    //it would be to wait until the other DLL has been closed and then carry through.

    try
      oCNTP^.BringToFront;
      ShowoCNT;
    except
    end;
  end else
  begin
    //Create the oCNT for the first time
    New(oCNTP);

    RPCBrokerV := TCPRSComBroker.Create(nil);
    RPCBrokerV.COMBroker := CPRSBroker;
    RPCBrokerV.CPRSState := CPRSState;
    RPCBrokerV.CPRSHandle := Cardinal(CPRSState.Handle);
    RPCBrokerV.TIUNote.Import := Data2;

    fMsgHandlerHWND := AllocateHWnd(WNDMethod);
    WM_CPRS_TIMEOUT_COMOBJECT := RegisterWindowMessageA(PAnsiChar(Data2));
    try
      try
        RPCBrokerV.SetContext('DSIO OCNT CONTEXT');
        Path := RPCBrokerV.sCallV('DSIO OCNT GET LOCATION', []);

        if Path[Length(Path)] <> '\' then
        Path := Path + '\'+ Param3
        else Path := Path + Param3;

        oCNTDLL := SafeLoadLibrary(Path);
        if oCNTDLL <> 0 then
        begin
          LaunchoCNT := GetProcAddress(oCNTDLL,'LaunchoCNT');
          if Assigned(LaunchoCNT) then
          begin
            oCNTP := LaunchoCNT(@RPCBrokerV);

            oCNTP^.Show;
            ShowoCNT;

            //Pass the Note to CPRS
            Data1 := RPCBrokerV.TIUNote.Lines.Text;
            if Data1 <> '' then
            Result := True;
          end;
        end else
        ShowMessage('Unable to load library at' + #13#10 + Path);
      except
        On E : Exception do
        ShowMessage(E.Message);
      end;
    finally
      oCNTP := nil;
      if oCNTDLL <> 0 then FreeLibrary(oCNTDLL);
      RPCBrokerV.Clean;
      DeallocateHWnd(fMsgHandlerHWND);
    end;
  end;
end;

//Hold the active OCNT so you don't lose the windows Thread lock in CPRS
//If not done here the alternative is to ShowModal in LaunchCNT rather than Show

//This is a merger of Show and ShowModal. If we Show then CPRS releases the process
//and the Thread used by ICPRSBroker is released - Windows.CriticalSection
//However, if we use ShowModal we cannot access CPRS while the OCNT is up
procedure TCPRSNoteObject.ShowoCNT;
begin
  State := 0;
  repeat
    Application.HandleMessage;
    if oCNTP = nil then State := 1
    else if not oCNTP^.Showing then State := 1;
  until State <> 0;
end;

procedure TCPRSNoteObject.WNDMethod(var Msg: TMessage);
begin
  //Unfortunatly this process closes all OCNTs on the system but they do get saved
  if Msg.Msg = WM_CPRS_TIMEOUT_COMOBJECT then
  begin
    if oCNTP <> nil then
    begin
      oCNTP^.OnCloseQuery := nil;
      oCNTP^.Close;
      State := 1;
      Another := 1;
    end;
  end else
  Msg.Result := DefWindowProc(fMsgHandlerHWND, Msg.Msg, Msg.wParam, Msg.lParam);
end;

initialization
  TAutoObjectFactory.Create(ComServer, TCPRSNoteObject, Class_CPRSNoteObject,
    ciMultiInstance, tmApartment);

end.
