unit uMain;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.ActiveX, System.Classes, System.Win.ComObj,
  System.Win.StdVcl, System.SysUtils, System.StrUtils, Vcl.Forms,
  uBase, DDCSComBroker, DDCSFormBuilder_TLB, CPRSChart_TLB;

type
  TDDCSCPRSDefault = class(TAutoObject, ICPRSExtension)
  protected
    function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
                     const Param1, Param2, Param3: WideString;
                       var Data1, Data2: WideString): WordBool; safecall;
  end;

  TLaunch = function(const CPRSBroker: PCPRSComBroker; out Return: WideString): WordBool; stdcall;

var
  DllHandle: THandle;
  Launch: TLaunch;

implementation

uses
  ComServ, DDCSUtils;

const
  MENU_CONTEXT = 'DSIO DDCS CONTEXT';

function TDDCSCPRSDefault.Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
                                  const Param1, Param2, Param3: WideString;
                                    var Data1, Data2: WideString): WordBool;
var
  Broker: TCPRSComBroker;
  Controlled,vPropertyList,Config: string;
  I,J: Integer;
begin
  Result := False;

  Broker := TCPRSComBroker.Create(nil, IDDCSCPRSBroker(CPRSBroker), IDDCSCPRSState(CPRSState));
  Broker.CPRSHandle := Cardinal(CPRSState.Handle);
  try
    try
      if Data2 <> '' then
      begin
        // Used as XML block from TIU for Note information
        Broker.TIUNote.ParseTIUXML(Data2);
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
  TAutoObjectFactory.Create(ComServer, TDDCSCPRSDefault, Class_DDCSCPRSDefault,
    ciMultiInstance, tmApartment);
end.
