unit uExtndComBroker;

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

interface

uses
  Winapi.Windows, Winapi.msxml, Winapi.ActiveX, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Trpcb, CPRSChart_TLB;

type
  TVistAUser = class(TObject)
  private
    FDUZ: string;
    FName: string;
  public
    property DUZ: string read FDUZ write FDUZ;
    property Name: string read FName write FName;
  end;

  TVistAPatient = class(TObject)
  private
    FPatientDFN: string;
    FPatientName: string;
    FPatientDOB: string;
    FPatientSSN: string;
    FLocationIEN: Integer;
    FLocationName: string;
  public
    property DFN: string read FPatientDFN;
    property Name: string read FPatientName;
    property DOB: string read FPatientDOB;
    property SSN: string read FPatientSSN;
    property LocationIEN: Integer read FLocationIEN;
    property LocationName: string read FLocationName;
  end;

  TVistANote = class(TObject)
  private
    FImport: WideString;
    FIEN: string;
    FAuthor: string;
    FAIEN: string;
    FLines: TStringList;
  protected
    procedure ParseTIUXML(const Value: WideString);
  public
    property Import: WideString read FImport write ParseTIUXML;
    property IEN: string read FIEN write FIEN;
    property Author: string read FAuthor write FAuthor;
    property AIEN: string read FAIEN write FAIEN;
  end;

  TCPRSComBroker = class(TObject)
  private
    FUser: TVistAUser;
    FPatient: TVistAPatient;
    FNote: TVistANote;
    FComBroker: ICPRSBroker;
    FRemoteProcedure: string;
    FCPRSSTate: ICPRSState;
    FCPRSHandle: HWND;
    FWindowList: TTaskWindowList;
    FControlObject: string;
    FDDCSInterface: string;
    FDDCSInterfacePages: TStringList;
  protected
    procedure SetClearParameters(Value: Boolean);
    procedure SetClearResults(Value: Boolean);
    procedure SetComBroker(const Value: ICPRSBroker);
    procedure SetCPRSState(const Value: ICPRSState);
    procedure SetParams(const RPCName: string; const AParam: array of const);
    procedure BrokerCall;
    procedure GetResults(var oText: TStringList);
    function GetConnected: Boolean;
  public
    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; iBroker: ICPRSBroker); overload;
    constructor Create(AOwner: TComponent; iBroker: ICPRSBroker; iCPRSState: ICPRSState); overload;
    destructor Destroy; override;
    property ClearParameters: Boolean write SetClearParameters;
    property ClearResults: Boolean write SetClearResults;
    property User: TVistAUser read FUser;
    property Patient: TVistAPatient read FPatient;
    property TIUNote: TVistANote read FNote;
    property COMBroker: ICPRSBroker read FComBroker write SetComBroker;
    property RemoteProcedure: string read FRemoteProcedure write FRemoteProcedure;
    property Connected: Boolean read GetConnected;
    property CPRSState: ICPRSState write SetCPRSSTate;
    property CPRSHandle: HWND read FCPRSHandle write FCPRSHandle;
    property DisabledWindow: TTaskWindowList read FWindowList write FWindowList;
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
  ORFn, ORNet, uCommon;

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
    RPCBrokerV.SetParams(RPCName, AParam);
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
    if RPCBrokerV.ComBroker <> nil then
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

  Result := True;
  try
    RPCBrokerV.ComBroker.SetContext(OptionName);
  except
    Result := False;
  end;
end;

function UpdateContext(NewContext: string): Boolean;
begin
  Result := AuthorizedOption(NewContext);
end;

{$ENDREGION}

{$REGION 'TVistANote'}

// Protected -------------------------------------------------------------------

procedure TVistANote.ParseTIUXML(const Value: WideString);
var
  XML: IXMLDOMDocument;
  Nlist: IXMLDOMNodeList;
  Node: IXMLDOMNode;
  I: Integer;
begin
  XML := CoDOMDocument.Create;
  XML.loadXML(Value);

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

procedure TCPRSComBroker.SetComBroker(const Value: ICPRSBroker);
begin
  FCOMBroker := Value;
  if FCOMBroker <> nil then
  begin
    ClearParameters := True;
    ClearResults := True;
  end;
end;

procedure TCPRSComBroker.SetCPRSState(const Value: ICPRSState);
begin
  FCPRSSTate := Value;
  if FCPRSSTate <> nil then
  begin
    FUser.FName            := FCPRSState.UserName;
    FUser.FDUZ             := FCPRSState.UserDUZ;
    FPatient.FPatientDFN   := FCPRSState.PatientDFN;
    FPatient.FPatientName  := FCPRSState.PatientName;
    FPatient.FPatientDOB   := FCPRSState.PatientDOB;
    FPatient.FPatientSSN   := FCPRSState.PatientSSN;
    FPatient.FLocationIEN  := FCPRSState.LocationIEN;
    FPatient.FLocationName := FCPRSState.LocationName;
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
  RemoteProcedure := RPCName;

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
      FComBroker.CallRPC(RemoteProcedure);
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

constructor TCPRSComBroker.Create(AOwner: TComponent);
begin
  RPCBrokerV := Self;

  FUser := TVistAUser.Create;
  FPatient := TVistAPatient.Create;
  FNote := TVistANote.Create;

  FDDCSInterfacePages := TStringList.Create;
end;

constructor TCPRSComBroker.Create(AOwner: TComponent; iBroker: ICPRSBroker);
begin
  RPCBrokerV := Self;

  FUser := TVistAUser.Create;
  FPatient := TVistAPatient.Create;
  FNote := TVistANote.Create;

  FDDCSInterfacePages := TStringList.Create;

  FComBroker := iBroker;
end;

constructor TCPRSComBroker.Create(AOwner: TComponent; iBroker: ICPRSBroker; iCPRSState: ICPRSState);
begin
  RPCBrokerV := Self;

  FUser := TVistAUser.Create;
  FPatient := TVistAPatient.Create;
  FNote := TVistANote.Create;

  FDDCSInterfacePages := TStringList.Create;

  FComBroker := iBroker;
  CPRSState := iCPRSState;
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

