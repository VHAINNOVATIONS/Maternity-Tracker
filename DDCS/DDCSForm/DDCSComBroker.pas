unit DDCSComBroker;

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

   version: XE10
}

interface

uses
  Winapi.Windows, Winapi.msxml, Winapi.ActiveX, System.SysUtils,
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Trpcb, DDCSFormBuilder_TLB;

type
  TVistAUser = class(TObject)
  private
    FComCPRSState: IDDCSCPRSState;
    function GetDUZ: Integer;
    function GetName: string;
    function GetStationID: string;
  public
    constructor Create(iICPRSState: IDDCSCPRSState); overload;
    destructor Destroy; override;
    property DUZ: Integer read GetDUZ;
    property Name: string read GetName;
    property StationID: string read GetStationID;
  end;

  TVistAPatient = class(TObject)
  private
    FComCPRSState: IDDCSCPRSState;
    function GetDFN: Integer;
    function GetName: string;
    function GetDOB: string;
    function GetSSN: string;
    function GetLocationIEN: Integer;
    function GetLocationName: string;
  public
    constructor Create(iICPRSState: IDDCSCPRSState); overload;
    destructor Destroy; override;
    property DFN: Integer read GetDFN;
    property Name: string read GetName;
    property DOB: string read GetDOB;
    property SSN: string read GetSSN;
    property LocationIEN: Integer read GetLocationIEN;
    property LocationName: string read GetLocationName;
  end;

  TVistANote = class(TObject)
  private
    FIEN: string;
    FAuthor: string;
    FAIEN: string;
  public
    procedure ParseTIUXML(wValue: WideString);
    property IEN: string read FIEN write FIEN;
    property Author: string read FAuthor write FAuthor;
    property AIEN: string read FAIEN write FAIEN;
  end;

  TCPRSComBroker = class(TComponent)
  private
    FUser: TVistAUser;
    FPatient: TVistAPatient;
    FCPRSHandle: HWND;
    FNote: TVistANote;
    FComBroker: IDDCSCPRSBroker;
    FRemoteProcedure: string;
    FHost: Pointer;
    FHostEnabled: Boolean;
    FControlObject: string;
    FDDCSInterface: string;
    FDDCSInterfacePages: TStringList;
  protected
    procedure SetClearParameters(Value: Boolean);
    procedure SetClearResults(Value: Boolean);
    procedure SetComBroker(const Value: IDDCSCPRSBroker);
    procedure SetParams(const RPCName: string; const AParam: array of const);
    procedure BrokerCall;
    procedure GetResults(var oText: TStringList);
    function GetConnected: Boolean;
  public
    constructor Create(AOwner: TComponent; iBroker: IDDCSCPRSBroker); overload;
    constructor Create(AOwner: TComponent; iBroker: IDDCSCPRSBroker; iCPRSState: IDDCSCPRSState); overload;
    destructor Destroy; override;
    property ClearParameters: Boolean write SetClearParameters;
    property ClearResults: Boolean write SetClearResults;
    property User: TVistAUser read FUser;
    property Patient: TVistAPatient read FPatient;
    property TIUNote: TVistANote read FNote;
    property Connected: Boolean read GetConnected;
    property CPRSHandle: HWND read FCPRSHandle write FCPRSHandle;
    property Host: Pointer read FHost write FHost;
    property HostEnabled: Boolean read FHostEnabled write FHostEnabled;
    property ControlObject: string read FControlObject write FControlObject;
    property DDCSInterface: string read FDDCSInterface write FDDCSInterface;
    property DDCSInterfacePages: TStringList read FDDCSInterfacePages write FDDCSInterfacePages;
  end;
  PCPRSComBroker = ^TCPRSComBroker;

  procedure CallV(const RPCName: string; const AParam: array of const);
  procedure tCallV(ReturnData: TStringList; const RPCName: string; const AParam: array of const);

  function sCallV(const RPCName: string; const AParam: array of const): string;
  function IsConnected: Boolean;
  function AuthorizedOption(const OptionName: string): Boolean;
  function UpdateContext(NewContext: string): Boolean;

var
  RPCBrokerV: TCPRSComBroker;

implementation

uses
  ORFn, ORNet;

{$REGION 'Exposed Methods'}

procedure CallV(const RPCName: string; const AParam: array of const);
var
  oldCursor: TCursor;
begin
  if not IsConnected then
    Exit;

  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    RPCBrokerV.SetParams(RPCName, AParam);
    RPCBrokerV.BrokerCall;
  finally
    Screen.Cursor := oldCursor;
  end;
end;

procedure tCallV(ReturnData: TStringList; const RPCName: string; const AParam: array of const);
var
  oldCursor: TCursor;
  sl: TStringList;

  function BrokerRepeat(s,d: TStringList): Boolean;
  begin
    Result := False;
    if s.Count > 0 then
    begin
      if s[0] = '##CONT##' then
      begin
        s.Delete(0);
        Result := True;
      end;
      if s.Count > 0 then
        d.AddStrings(s);
      s.Clear;
    end;
  end;

  procedure CallMe(s: TStringList);
  begin
    RPCBrokerV.SetParams(RPCName, AParam);
    RPCBrokerV.BrokerCall;
    RPCBrokerV.GetResults(s);
  end;

begin
  if not IsConnected then
    Exit;

  if ReturnData = nil then
    raise Exception.Create('TStrings not created');
  ReturnData.Clear;

  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  sl := TStringList.Create;
  try
    // if the first line is ##CONT## then we need to remove it and make the call
    // again and add to our return
    repeat
      CallMe(sl);
    until not BrokerRepeat(sl,ReturnData);
  finally
    sl.Free;
    Screen.Cursor := oldCursor;
  end;
end;

function sCallV(const RPCName: string; const AParam: array of const): string;
var
  oldCursor: TCursor;
  sl: TStringList;
begin
  Result := '';

  if not IsConnected then
    Exit;

  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  sl := TStringList.Create;
  try
    RPCBrokerV.SetParams(RPCName, AParam);
    RPCBrokerV.BrokerCall;

    RPCBrokerV.GetResults(sl);
    if sl.Count > 0 then
      Result := sl[0]
    else
      Result := '';
  finally
    sl.Free;
    Screen.Cursor := oldCursor;
  end;
end;

function IsConnected: Boolean;
begin
  Result := False;
  if RPCBrokerV <> nil then
    if RPCBrokerV.FComBroker <> nil then
      Result := True;
end;

// The Following function will set the RPC Context which replaces SetContext.
// UpdateContext calls out to AuthorizedOption but both are listed as to override
// ORNet when this unit is in the uses clause following ORNet.

// Cannot use the same context as the host application (CPRS)
// thus you cannot use "OR CPRS GUI CHART" for VA VistA

function AuthorizedOption(const OptionName: string): Boolean;
begin
  Result := False;

  if not IsConnected then
    Exit;

  try
    RPCBrokerV.FComBroker.SetContext(OptionName);
    Result := True;
  except
  end;
end;

function UpdateContext(NewContext: string): Boolean;
begin
  Result := AuthorizedOption(NewContext);
end;

{$ENDREGION}

{$REGION 'TVistAUser'}

constructor TVistAUser.Create(iICPRSState: IDDCSCPRSState);
begin
  inherited Create;

  FComCPRSState := iICPRSState;
end;

destructor TVistAUser.Destroy;
begin
  FComCPRSState := nil;

  inherited;
end;

function TVistAUser.GetDUZ: Integer;
begin
  Result := 0;
  if FComCPRSState <> nil then
    Result := StrToIntDef(FComCPRSState.UserDUZ, 0);
end;

function TVistAUser.GetName: string;
begin
  if FComCPRSState <> nil then
    Result := FComCPRSState.UserName;
end;

function TVistAUser.GetStationID: string;
begin
  if FComCPRSState <> nil then
    Result := FComCPRSState.StationID;
end;

{$ENDREGION}

{$REGION 'TVistAPatient'}

constructor TVistAPatient.Create(iICPRSState: IDDCSCPRSState);
begin
  inherited Create;

  FComCPRSState := iICPRSState;
end;

destructor TVistAPatient.Destroy;
begin
  FComCPRSState := nil;

  inherited;
end;

function TVistAPatient.GetDFN: Integer;
begin
  Result := 0;
  if FComCPRSState <> nil then
    Result := StrToIntDef(FComCPRSState.PatientDFN, 0);
end;

function TVistAPatient.GetName: string;
begin
  if FComCPRSState <> nil then
    Result := FComCPRSState.PatientName;
end;

function TVistAPatient.GetDOB: string;
begin
  if FComCPRSState <> nil then
    Result := FComCPRSState.PatientDOB;
end;

function TVistAPatient.GetSSN: string;
begin
  if FComCPRSState <> nil then
    Result := FComCPRSState.PatientSSN;
end;

function TVistAPatient.GetLocationIEN: Integer;
begin
  Result := 0;
  if FComCPRSState <> nil then
    Result := FComCPRSState.LocationIEN;
end;

function TVistAPatient.GetLocationName: string;
begin
  if FComCPRSState <> nil then
    Result := FComCPRSState.LocationName;
end;

{$ENDREGION}

{$REGION 'TVistANote'}

// Protected -------------------------------------------------------------------

procedure TVistANote.ParseTIUXML(wValue: WideString);
var
  XML: IXMLDOMDocument;
  Nlist: IXMLDOMNodeList;
  Node: IXMLDOMNode;
  I: Integer;
begin
  XML := CoDOMDocument.Create;
  XML.loadXML(wValue);

  Nlist := XML.getElementsByTagName('DOC_IEN');
  if Nlist <> nil then
    for I := 0 to Nlist.length - 1 do
    begin
      Node := Nlist[I];
      if Node.nodeName = 'DOC_IEN' then
        FIEN := Node.text;
    end;

  Nlist := XML.getElementsByTagName('AUTHOR_IEN');
  if Nlist <> nil then
    for I := 0 to Nlist.length - 1 do
    begin
      Node := Nlist[I];
      if Node.nodeName = 'AUTHOR_IEN' then
        FAIEN := Node.text;
    end;

  Nlist := XML.getElementsByTagName('AUTHOR_NAME');
  if Nlist <> nil then
    for I := 0 to Nlist.length - 1 do
    begin
      Node := Nlist[I];
      if Node.nodeName = 'AUTHOR_NAME' then
        FAuthor := Node.text;
    end;
end;

{$ENDREGION}

{$REGION 'TCPRSComBroker'}

// Protected -------------------------------------------------------------------

procedure TCPRSComBroker.SetClearParameters(Value: Boolean);
begin
  if (FComBroker <> nil) and Value then
    FComBroker.ClearParameters := True;
end;

procedure TCPRSComBroker.SetClearResults(Value: Boolean);
begin
  if (FComBroker <> nil) and Value then
    FComBroker.ClearResults := True;
end;

procedure TCPRSComBroker.SetComBroker(const Value: IDDCSCPRSBroker);
begin
  FCOMBroker := Value;
  if FCOMBroker <> nil then
  begin
    ClearParameters := True;
    ClearResults := True;
  end;
end;

{ Takes the params (array of const) passed to xCallV and sets them into FComBroker.Param[I] }
procedure TCPRSComBroker.SetParams(const RPCName: string; const AParam: array of const);

  procedure SetList(AStringList: TStrings; ParamIndex: Integer);
  var
    I: Integer;
  begin
    FComBroker.ParamType[ParamIndex] := bptList;

    // Not need to list the count of the MULT
    // FComBroker.ParamListCount(AStringList.Count);
    for I := 0 to AStringList.Count - 1 do
      FComBroker.ParamList[ParamIndex, IntToStr(I+1)] := AStringList.Strings[I];
  end;

const
  BoolChar: array[boolean] of char = ('0', '1');
var
  TmpExt: Extended;
  I: Integer;
  wValueStr: WideString;
begin
  ClearParameters := True;
  FRemoteProcedure := RPCName;

  if RPCName = '' then
    raise Exception.Create('No RPC Name');

  if FComBroker <> nil then
  try
    for I := Low(AParam) to High(AParam) do
      case TVarRec(AParam[I]).VType of
        vtInteger:    begin
                        FComBroker.Param[I] := IntToStr(AParam[I].VInteger);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtBoolean:    begin
                        FComBroker.Param[I] := BoolChar[AParam[I].VBoolean];
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtChar:       begin
                        if AParam[I].VChar = #0 then
                          FComBroker.Param[I] := ''
                        else
                          FComBroker.Param[I] := Char(AParam[I].VChar);

                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtExtended:   begin
                        TmpExt := AParam[I].VExtended^;

                        if(abs(TmpExt) < 0.0000000000001) then
                          TmpExt := 0;

                        FComBroker.Param[I] := FloatToStr(TmpExt);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtPointer:    begin
                        if AParam[I].VPointer = nil then
                          FComBroker.ClearParameters := True
                        else
                          raise Exception.Create('Pointer type must be nil.');
                      end;
        vtPChar:      begin
                        FComBroker.Param[I] := string(AParam[I].VPChar);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtObject:     if AParam[I].VObject is TStrings then
                        SetList(TStrings(AParam[I].VObject), I);
        vtWideChar:   begin
                        FComBroker.Param[I] := Char(AParam[I].VWideChar);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtPWideChar:  begin
                        FComBroker.Param[I] := string(AParam[I].VPWideChar);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtWideString: begin
                        FComBroker.Param[I] := string(AParam[I].VPWideChar);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtInt64:      begin
                        FComBroker.Param[I] := IntToStr(AParam[I].VInt64^);
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        // String pre-D2009 is ANSI, and in D2009 and later is Unicode
        vtString:     begin
                        wValueStr := string(AParam[I].VString);
                        FComBroker.Param[I] := wValueStr;
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
        vtAnsiString: begin
                        wValueStr := string(AParam[I].VAnsiString);
                        FComBroker.Param[I] := wValueStr;
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
     vtUnicodeString: begin
                        wValueStr := string(AParam[I].VUnicodeString);
                        FComBroker.Param[I] := wValueStr;
                        FComBroker.ParamType[I] := bptLiteral;
                      end;
    end;
  except
    on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TCPRSComBroker.BrokerCall;
var
  tmp: string;
const
  XWB_M_REJECT =  20000 + 2;  // M error
begin
  if FComBroker <> nil then
  begin
    try
      FComBroker.CallRPC(FRemoteProcedure);
    except
      on E: EBrokerError do
      begin
        if E.Code = XWB_M_REJECT then
        begin
          tmp := 'An error occurred on the server.' + CRLF + CRLF + E.Action;
          Application.MessageBox(PChar(tmp), 'Server Error', MB_OK);
        end
        else raise;
      end;
      on E: Exception do
        Application.MessageBox(PChar(E.Message), 'Broker Error', MB_OK);
    end;
  end;
end;

procedure TCPRSComBroker.GetResults(var oText: TStringList);
begin
  oText.Clear;
  oText.Text := FComBroker.Results;
end;

function TCPRSComBroker.GetConnected: Boolean;
begin
  Result := False;
  if FComBroker <> nil then
    Result := True;
end;

// Public ----------------------------------------------------------------------

constructor TCPRSComBroker.Create(AOwner: TComponent; iBroker: IDDCSCPRSBroker);
begin
  inherited Create(AOwner);

  RPCBrokerV := Self;
  FComBroker := iBroker;

  FUser := TVistAUser.Create;
  FPatient := TVistAPatient.Create;

  FNote := TVistANote.Create;
  FDDCSInterfacePages := TStringList.Create;
end;

constructor TCPRSComBroker.Create(AOwner: TComponent; iBroker: IDDCSCPRSBroker;
                                  iCPRSState: IDDCSCPRSState);
begin
  inherited Create(AOwner);

  RPCBrokerV := Self;
  FComBroker := iBroker;

  FUser := TVistAUser.Create(iCPRSState);
  FPatient := TVistAPatient.Create(iCPRSState);
  FCPRSHandle := Cardinal(iCPRSState.Handle);

  FNote := TVistANote.Create;
  FDDCSInterfacePages := TStringList.Create;
end;

destructor TCPRSComBroker.Destroy;
begin
  RPCBrokerV := nil;

  FUser.Free;
  FPatient.Free;
  FNote.Free;
  FDDCSInterfacePages.Free;

  inherited;
end;

{$ENDREGION}

end.

