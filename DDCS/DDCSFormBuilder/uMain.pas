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
   VA Contract: TAC-13-06464
}

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.ActiveX, System.Classes, System.Win.ComObj,
  System.Win.StdVcl, System.SysUtils, System.StrUtils, Vcl.Forms,
  DDCSFormBuilder_TLB, CPRSChart_TLB, uBase, uExtndComBroker;

type
  TDDCS = class(TAutoObject, IDDCS, ICPRSExtension)
  protected
    function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
                     const Param1, Param2, Param3: WideString;
                     var Data1, Data2: WideString): WordBool; safecall;
  end;

  TLaunch = function(const CPRSBroker: PCPRSComBroker; var Return: WideString): WordBool; stdcall;

var
  DllHandle: THandle;
  Launch: TLaunch;

implementation

uses
  ComServ, uCommon;

function TDDCS.Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
                       const Param1, Param2, Param3: WideString;
                       var Data1, Data2: WideString): WordBool;
var
  Broker: TCPRSComBroker;
  sControlled,sObject,sPropertyList,sConfig: string;
  I,iSubCount: Integer;

  function CheckControlStatus(sControlled: string; var sObject: string): Boolean;
  var
    iReturn: Integer;
    sMsg: string;

    function CallCheck(sControlled: string; var sObject: string; var sMsg: string): Integer;
    begin
      if Piece(sObject,U,1) = '-1' then
        sObject := sCallV('DSIO DDCS CONTROLLED', [sControlled, '1'])
      else
        sObject := sCallV('DSIO DDCS CONTROLLED', [sControlled, '0']);
      Result := StrToIntDef(Piece(sObject,U,1), 0);
      if Result < 0 then
        sMsg := Piece(sObject,U,2);
    end;

  begin
    Result := False;

    if UpdateContext(MENU_CONTEXT) then
    begin
      // Don't want to annoy the user with a popup for every order not found a control object
      // -2 M Error (do not continue), -1 Error (retry), 0 No (Not Tracking), >0 Success
      repeat
        iReturn := CallCheck(sControlled, sObject, sMsg);
        if iReturn = -1 then
        begin
          if ShowMsg(sMsg, smiError, smbRetryCancel) <> smrRetry then
            iReturn := 0;
        end else
        if iReturn = -2 then
        begin
          ShowMsg(sMsg, smiError);
          iReturn := 0;
        end;
      until iReturn <> -1;
      if iReturn > 0 then
        Result := True;
    end;
  end;

begin
  Result := False;

  Broker := TCPRSComBroker.Create(nil, CPRSBroker, CPRSState);
  Broker.CPRSHandle := Cardinal(CPRSState.Handle);
  try
    try
      if Data2 <> '' then
      begin
        // Used as XML block from TIU for Note information
        Broker.TIUNote.ParseTIUXML(Data2);
        sControlled := 'N=' + Broker.TIUNote.IEN;
      end else
      begin
        Broker.TIUNote.IEN := Piece(Piece(Param2,'=',2),';',1);
        // Used as O=### as Order IEN could also be used as N=### as Note IEN
        sControlled := Param2;
      end;

      if not CheckControlStatus(sControlled, sObject) then
      begin
        Result := True;
        Exit;
      end;

      Broker.ControlObject := Piece(sObject,U,2);
      sPropertyList := Piece(sObject,U,3);

      iSubCount := SubCount(sPropertyList,'|') + 1;
      for I := 1 to iSubCount do
      begin
        if AnsiContainsText(Piece(sPropertyList,'|',I),'*') then
          Broker.DDCSInterface := StringReplace(Piece(sPropertyList,'|',I),'*','',[rfReplaceAll])
        else
          Broker.DDCSInterfacePages.Add(Piece(sPropertyList,'|',I));
      end;

      if UpdateContext(MENU_CONTEXT) then
        sConfig := sCallV('DSIO DDCS CONFIGURATION', [Broker.DDCSInterface, 'WARNING MESSAGE']);

      if sConfig <> '' then
        if ShowMsg(sConfig + ' Select YES to continue.', smiWarning, smbYesNo) <> smrYes then
          Exit;

      sConfig := '';
      if UpdateContext(MENU_CONTEXT) then
        sConfig := sCallV('DSIO DDCS CONFIGURATION', [Broker.DDCSInterface, 'LOCATION']);

      if sConfig <> '' then
      begin
        DllHandle := SafeLoadLibrary(sConfig);
        if DllHandle <> 0 then
        begin
          Launch := GetProcAddress(DllHandle, 'Launch');
          if Assigned(Launch) then
            Result := Launch(@Broker, Data1);
        end else
          raise Exception.Create('Unable to load library.');
      end else
        raise Exception.Create('Unable to build path.');
    except
      on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    Broker.Free;
    if DllHandle <> 0 then
      FreeLibrary(DllHandle);
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TDDCS, Class_DDCS, ciMultiInstance, tmApartment);

end.
