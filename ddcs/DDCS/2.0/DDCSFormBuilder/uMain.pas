unit uMain;

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
  Windows, ActiveX, Classes, ComObj, DDCSFormBuilder_TLB, CPRSChart_TLB,
  Forms, SysUtils, Vcl.Dialogs, Vcl.Controls, StrUtils, StdVcl, uBase, uCommon,
  uExtndComBroker;

type
  TDDCS = class(TAutoObject, IDDCS, ICPRSExtension)
  private
    procedure ShowForm;
  protected
    function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState; const Param1,
             Param2, Param3: WideString; var Data1, Data2: WideString): WordBool; safecall;
  end;

  TLaunch = function(Broker: PCPRSComBroker): Pointer; stdcall;

var
  DllHandle: THandle;
  Launch: TLaunch;
  DDCSFormP: ^TDDCSForm;
  MainFormP: ^TForm;
  State,Another: Integer;

implementation

uses
  ComServ, VAUtils;

// Legacy ----------------------------------------------------------------------

//Hold the active OCNT so you don't lose the windows Thread lock in CPRS
//If not done here the alternative is to ShowModal in LaunchCNT rather than Show

//This is a merger of Show and ShowModal. If we Show then CPRS releases the process
//and the Thread used by ICPRSBroker is released - Windows.CriticalSection
//However, if we use ShowModal we cannot access CPRS while the OCNT is up
procedure TDDCS.ShowForm;
begin
  State := 0;
  repeat
    Application.HandleMessage;
    if not Assigned(MainFormP) then
      State := 1
    else if MainFormP^ = nil then
      State := 1
    else if not MainFormP^.Showing then
      State := 1;
  until State <> 0;
end;

// New -------------------------------------------------------------------------

function TDDCS.Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
          const Param1, Param2, Param3: WideString; var Data1, Data2: WideString): WordBool;
var
  Controlled,vPropertyList,Config: string;
  IEN,I,J: Integer;

  function SubCount(str: string; d: Char): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to Length(str) - 1 do
      if str[I] = d then
        inc(Result);
  end;

  //   RETURN:
  //     INTERFACE: I^PROPERTY|VALUE
  //          PAGE: P^NUMBER^CAPTION
  //       CONTROL: C^NAME^CLASS^PAGE NUMBER^PROPERTY|VALUE
  //       CONTROL: CV^NAME^PROPERTY^CONFIG VALUE

begin
  Result := False;

  if Assigned(MainFormP) then
  begin
    //Since we cannot allow the Process to end if it spawns again because it would
    //kill our thread with CPRS with have to stay in here. So a better way to go about
    //it would be to wait until the other DLL has been closed and then carry through.
    try
      MainFormP^.BringToFront;
      ShowForm;
    except
    end;

  end else
  begin
    RPCBrokerV := TCPRSComBroker.Create(nil);
    RPCBrokerV.COMBroker  := CPRSBroker;
    RPCBrokerV.CPRSState  := CPRSState;
    RPCBrokerV.CPRSHandle := Cardinal(CPRSState.Handle);
    try
      try
        if Data2 <> '' then
        begin
          // Used as XML block from TIU for Note information
          RPCBrokerV.Source.Import := Data2;
          Controlled := 'N=' + RPCBrokerV.Source.IEN;
        end else
        begin
          RPCBrokerV.Source.IEN := Piece(Piece(Param2,'=',2),';',1);
          // Used as O=### as Order IEN could also be used as N=### as Note IEN
          Controlled := Param2;
        end;

        if UpdateContext(MENU_CONTEXT) then
          Controlled := sCallV('DSIO DDCS CONTROLLED', [Controlled]);

        // Don't want to annoy the user with a popup for every order not found a control object
        if not TryStrToInt(Piece(Controlled,U,1),IEN) or (IEN < 1) then
        begin
          Result := True;
          Exit;
        end;

        RPCBrokerV.ControlObject := Piece(Controlled,U,2);
        vPropertyList := Piece(Controlled,U,3);
        J := SubCount(vPropertyList,'|') + 1;

        for I := 1 to J do
        begin
          if AnsiContainsText(Piece(vPropertyList,'|',I),'*') then
            RPCBrokerV.DDCSInterface := StringReplace(Piece(vPropertyList,'|',I),'*','',[rfReplaceAll])
          else
            RPCBrokerV.DDCSInterfacePages.Add(Piece(vPropertyList,'|',I));
        end;

        if UpdateContext(MENU_CONTEXT) then
          Config := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'WARNING MESSAGE']);

        if Config <> '' then
          if ShowMsg(Config + ' Select YES to continue.', smiWarning, smbYesNo) <> smrYes then
            Exit;

        New(MainFormP);

        Config := '';
        if UpdateContext(MENU_CONTEXT) then
          Config := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'LOCATION']);

        if Config <> '' then
        begin
          DllHandle := SafeLoadLibrary(Config);
          if DllHandle <> 0 then
          begin
            Launch := GetProcAddress(DllHandle,'Launch');

            if Assigned(Launch) then
            begin
              DDCSFormP := Launch(@RPCBrokerV);
              MainFormP := @DDCSFormP^.Owner;

              RPCBrokerV.Owner := MainFormP^;

              Config := '';
              if UpdateContext(MENU_CONTEXT) then
                Config := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'HOLD ON SHOW']);

              if ((Config <> '') and (StrToBool(Config))) then
              begin
                MainFormP^.ShowModal;
                MainFormP^.Destroy;
              end else
              begin
                MainFormP^.Show;
                ShowForm;
              end;

              //Pass the Note to CPRS
              Data1 := RPCBrokerV.Source.Lines.Text;
              if Data1 <> '' then
                Result := True;
            end;
          end else
            raise Exception.Create('Unable to load library.');
        end else
          raise Exception.Create('Unable to build path.');
      except
        on E: Exception do
          raise Exception.Create(E.Message);
      end;
    finally
      DDCSFormP := nil;
      MainFormP := nil;

      RPCBrokerV.Free;

      if DllHandle <> 0 then
        FreeLibrary(DllHandle);
    end;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TDDCS, Class_DDCS, ciMultiInstance, tmApartment);

end.
