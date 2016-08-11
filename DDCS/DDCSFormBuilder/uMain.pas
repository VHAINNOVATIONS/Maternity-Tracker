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
  System.SysUtils, System.StrUtils, Vcl.Forms,
  DDCSFormBuilder_TLB, CPRSChart_TLB, uBase, uExtndComBroker, StdVcl;

type
  TDDCS = class(TAutoObject, IDDCS, ICPRSExtension)
  protected
    function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState; const Param1,
             Param2, Param3: WideString; var Data1, Data2: WideString): WordBool; safecall;
  end;

  TLaunch = function(Broker: PCPRSComBroker; out Return: WideString): WordBool; stdcall;

var
  DllHandle: THandle;
  Launch: TLaunch;

implementation

uses
  ComServ, uCommon;

function TDDCS.Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
         const Param1, Param2, Param3: WideString; var Data1, Data2: WideString): WordBool;
var
  Broker: TCPRSComBroker;
  Controlled,vPropertyList,Config: string;
  I,J: Integer;

  function SubCount(str: string; d: Char): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to Length(str) - 1 do
      if str[I] = d then
        inc(Result);
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
        Broker.TIUNote.Import := Data2;
        Controlled := 'N=' + Broker.TIUNote.IEN;
      end else
      begin
        Broker.TIUNote.IEN := Piece(Piece(Param2,'=',2),';',1);
        // Used as O=### as Order IEN could also be used as N=### as Note IEN
        Controlled := Param2;
      end;

      if UpdateContext(MENU_CONTEXT) then
        Controlled := sCallV('DSIO DDCS CONTROLLED', [Controlled]);
      // Don't want to annoy the user with a popup for every order not found a control object
      // -1 Error (Do not continue), 0 No (Not Tracking), >0 Success
      I := StrToIntDef(Piece(Controlled,U,1), 0);
      if I < 1 then
      begin
        if I = -1 then
          ShowMsg('There is an error occuring within DSIO DDCS, please report this error ' +
                  ' and discontinue from using this application until further notice.');
        Result := True;
        Exit;
      end;

      Broker.ControlObject := Piece(Controlled,U,2);
      vPropertyList := Piece(Controlled,U,3);

      J := SubCount(vPropertyList,'|') + 1;
      for I := 1 to J do
      begin
        if AnsiContainsText(Piece(vPropertyList,'|',I),'*') then
          Broker.DDCSInterface := StringReplace(Piece(vPropertyList,'|',I),'*','',[rfReplaceAll])
        else
          Broker.DDCSInterfacePages.Add(Piece(vPropertyList,'|',I));
      end;

      if UpdateContext(MENU_CONTEXT) then
        Config := sCallV('DSIO DDCS CONFIGURATION', [Broker.DDCSInterface, 'WARNING MESSAGE']);

      if Config <> '' then
        if ShowMsg(Config + ' Select YES to continue.', smiWarning, smbYesNo) <> smrYes then
          Exit;

      Config := '';
      if UpdateContext(MENU_CONTEXT) then
        Config := sCallV('DSIO DDCS CONFIGURATION', [Broker.DDCSInterface, 'LOCATION']);

      if Config <> '' then
      begin
        DllHandle := SafeLoadLibrary(Config);
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
