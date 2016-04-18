unit uCommon;

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

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.oleacc, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, TypInfo, Contnrs,
  CheckLst, StrUtils, Grids, ComObj, VAUtils, uExtndComBroker, FSAPILib_TLB;

const
  U = '^';
  MENU_CONTEXT    = 'DSIO DDCS CONTEXT';
  VALID_MESS      = 'Some required elements are incomplete and must be completed in order to generate the note.';
  WM_AFTER_CREATE = WM_USER + 260;
  WM_SHOW_SPLASH  = WM_USER + 270;
  WM_SAVE         = WM_USER + 280;

type
  // MSAA (Microsoft Active Accessibility)
  // IAccessible
  // http://stackoverflow.com/questions/16320914/creating-accessible-ui-components-in-delphi
  // https://support.smartbear.com/viewarticle/68910/

  TDDCSAccessibility = class(TInterfacedObject, IAccessible)
  private
//    fControl: TControl;
    fDefAcc: IAccessible;
  public
    constructor Create(aControl: TControl; aDefAcc: IAccessible);
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function Get_accParent(out ppdispParent: IDispatch): HResult; stdcall;
    function Get_accChildCount(out pcountChildren: Integer): HResult; stdcall;
    function Get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HResult; stdcall;
    function Get_accName(varChild: OleVariant; out pszName: WideString): HResult; stdcall;
    function Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult; stdcall;
    function Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult; stdcall;
    function Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult; stdcall;
    function Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult; stdcall;
    function Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult; stdcall;
    function Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant; out pidTopic: Integer): HResult; stdcall;
    function Get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: WideString): HResult; stdcall;
    function Get_accFocus(out pvarChild: OleVariant): HResult; stdcall;
    function Get_accSelection(out pvarChildren: OleVariant): HResult; stdcall;
    function Get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: WideString): HResult; stdcall;
    function accSelect(flagsSelect: Integer; varChild: OleVariant): HResult; stdcall;
    function accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer; out pcyHeight: Integer; varChild: OleVariant): HResult; stdcall;
    function accNavigate(navDir: Integer; varStart: OleVariant; out pvarEndUpAt: OleVariant): HResult; stdcall;
    function accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult; stdcall;
    function accDoDefaultAction(varChild: OleVariant): HResult; stdcall;
    function Set_accName(varChild: OleVariant; const pszName: WideString): HResult; stdcall;
    function Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult; stdcall;
  end;

  TScreenReader = class(TObject)
  private
    FActive: Boolean;
    ObjGUID: TGUID;
    ObjIntf: IUnknown;
    Obj: IJawsApi;
    function IsObjectRegistered: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Say(txt: string; stop: Boolean);
  end;

  TDisplayDialog = function(Broker: PCPRSComBroker; dlgName: WideString; DebugMode: Boolean): WideString; stdcall;
  TRegisterDialogs = function: WideString; stdcall;
  TGetDialogComponents = function(dlgName: WideString): WideString; stdcall;

  procedure Fill(wControl: TWinControl; iIndex,iValue: string);
  function LoadDialogs: THandle;

var
  ScreenReader: TScreenReader;
  DLLDialogList: TStringList;
  DialogDLL: THandle;
  RegisterDialogs: TRegisterDialogs;
  GetDialogComponents: TGetDialogComponents;
  DisplayDialog: TDisplayDialog;

implementation

constructor TDDCSAccessibility.Create(aControl: TControl; aDefAcc: IAccessible);
begin
  inherited Create;

//  fControl := aControl;
  fDefAcc := aDefAcc;
end;

function TDDCSAccessibility.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if IID = IID_IAccessible then
    Result := inherited QueryInterface(IID, Obj)
  else
    Result := fDefAcc.QueryInterface(IID, Obj);
end;

function TDDCSAccessibility.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := fDefAcc.GetTypeInfoCount(Count);
end;

function TDDCSAccessibility.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := fDefAcc.GetTypeInfo(Index, LocaleID, TypeInfo);
end;

function TDDCSAccessibility.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := fDefAcc.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
end;

function TDDCSAccessibility.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := fDefAcc.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
end;

function TDDCSAccessibility.Get_accParent(out ppdispParent: IDispatch): HResult;
begin
  Result := fDefAcc.Get_accParent(ppdispParent);
end;

function TDDCSAccessibility.Get_accChildCount(out pcountChildren: Integer): HResult;
begin
  Result := fDefAcc.Get_accChildCount(pcountChildren);
end;

function TDDCSAccessibility.Get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HResult;
begin
  Result := fDefAcc.Get_accChild(varChild, ppdispChild);
end;

function TDDCSAccessibility.Get_accName(varChild: OleVariant; out pszName: WideString): HResult;
begin
  Result := fDefAcc.Get_accName(varChild, pszName);
end;

function TDDCSAccessibility.Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult;
begin
  Result := fDefAcc.Get_accValue(varChild, pszValue);
end;

function TDDCSAccessibility.Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult;
begin
//  Result := fDefAcc.Get_accDescription(varChild, pszDescription);
  pszDescription := '';
//  Result := S_FALSE;
//  if varChild = CHILDID_SELF then
//  begin
      pszDescription := 'oh shit oh shit oh shit';
      Result := S_OK;
//  end;
end;

function TDDCSAccessibility.Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult;
begin
  Result := fDefAcc.Get_accRole(varChild, pvarRole);
end;

function TDDCSAccessibility.Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult;
begin
  Result := fDefAcc.Get_accState(varChild, pvarState);
end;

function TDDCSAccessibility.Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult;
begin
  Result := fDefAcc.Get_accHelp(varChild, pszHelp);
end;

function TDDCSAccessibility.Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant; out pidTopic: Integer): HResult;
begin
  Result := fDefAcc.Get_accHelpTopic(pszHelpFile, varChild, pidTopic);
end;

function TDDCSAccessibility.Get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: WideString): HResult;
begin
  Result := fDefAcc.Get_accKeyboardShortcut(varChild, pszKeyboardShortcut);
end;

function TDDCSAccessibility.Get_accFocus(out pvarChild: OleVariant): HResult;
begin
  Result := fDefAcc.Get_accFocus(pvarChild);
end;

function TDDCSAccessibility.Get_accSelection(out pvarChildren: OleVariant): HResult;
begin
  Result := fDefAcc.Get_accSelection(pvarChildren);
end;

function TDDCSAccessibility.Get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: WideString): HResult;
begin
  Result := fDefAcc.Get_accDefaultAction(varChild, pszDefaultAction);
end;

function TDDCSAccessibility.accSelect(flagsSelect: Integer; varChild: OleVariant): HResult;
begin
  Result := fDefAcc.accSelect(flagsSelect, varChild);
end;

function TDDCSAccessibility.accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer; out pcyHeight: Integer; varChild: OleVariant): HResult;
 begin
  Result := fDefAcc.accLocation(pxLeft, pyTop, pcxWidth, pcyHeight, varChild);
end;

function TDDCSAccessibility.accNavigate(navDir: Integer; varStart: OleVariant; out pvarEndUpAt: OleVariant): HResult;
begin
  Result := fDefAcc.accNavigate(navDir, varStart, pvarEndUpAt);
end;

function TDDCSAccessibility.accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult;
begin
  Result := fDefAcc.accHitTest(xLeft, yTop, pvarChild);
end;

function TDDCSAccessibility.accDoDefaultAction(varChild: OleVariant): HResult;
begin
  Result := fDefAcc.accDoDefaultAction(varChild);
end;

function TDDCSAccessibility.Set_accName(varChild: OleVariant; const pszName: WideString): HResult;
begin
  Result := fDefAcc.Set_accName(varChild, pszName);
end;

function TDDCSAccessibility.Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult;
begin
  Result := fDefAcc.Set_accValue(varChild, pszValue);
end;

{$REGION 'TScreenReader'}

// Private ---------------------------------------------------------------------

function TScreenReader.IsObjectRegistered;
begin
  Result := FActive;

  if not Result then
  try
    ObjIntf := CreateComObject(ObjGUID);
    if assigned(ObjIntf) then
    begin
      ObjIntf.QueryInterface(IID_IJawsApi, Obj);
      if assigned(Obj) then
      begin
        FActive := True;
        Result := True;
      end;
    end;
  except
  end;
end;

// Public ----------------------------------------------------------------------

constructor TScreenReader.Create;
begin
  inherited;

  ObjGUID := StringToGUID('{CCE5B1E5-B2ED-45D5-B09F-8EC54B75ABF4}');     // Change this to an entry in OE/RR?

  FActive := IsObjectRegistered;
end;

destructor TScreenReader.Destroy;
begin
  inherited;
end;

procedure TScreenReader.Say(txt: string; stop: Boolean);
begin
  if not FActive then
    Exit;

  if stop then
    Obj.StopSpeech;

  Obj.SayString(txt, stop);
end;

{$ENDREGION}

// Used by both the DDCSForm Component and the DDCSDialog Class
procedure Fill(wControl: TWinControl; iIndex,iValue: string);
var
  iClass: TClass;
  I: Integer;
  cb: TCustomComboBox;
  lb: TCustomListBox;
  lv: TListView;
  lvitem: TListItem;
  lvcolumn: TListColumn;
  sl: TStringList;
  sg: TStringGrid;
begin
  if iValue = '' then
    Exit;

  iClass := wControl.ClassType;
  try
    if iClass.InheritsFrom(TDateTimePicker) then
      TDateTimePicker(wControl).DateTime := StrToDate(iValue)
    else if iClass.InheritsFrom(TCustomEdit) then
      TCustomEdit(wControl).Text := iValue
    else if iClass.InheritsFrom(TCheckBox) then
      TCheckBox(wControl).Checked := True
    else if iClass.InheritsFrom(TRadioButton) then
      TRadioButton(wControl).Checked := True
    else if iClass.InheritsFrom(TRadioGroup) then
      TRadioGroup(wControl).ItemIndex := StrToInt(iIndex)
    else if iClass.InheritsFrom(TCustomComboBox) then
    begin
      cb := TCustomComboBox(wControl);

      cb.Items.Add(iValue);

      if AnsiContainsText(iIndex, 'TRUE') then
      begin
        for I := 0 to cb.Items.Count do
          if cb.Items[I] = iValue then
          begin
            cb.ItemIndex := I;
            Break;
          end;
      end;
    end else if iClass.InheritsFrom(TCustomListBox) then
    begin
      lb := TCustomListBox(wControl);

      lb.Items.Add(iValue);

      if AnsiContainsText(iIndex, 'TRUE') then
      begin
        if iClass.InheritsFrom(TCheckListBox) then
          TCheckListBox(wControl).Checked[TCheckListBox(wControl).Items.IndexOf(iValue)] := True
        else
          lb.Selected[lb.Items.Count - 1] := True;
      end;
    end else if iClass.InheritsFrom(TListView) then
    begin
      lv := TListView(wControl);

      sl := TStringList.Create;
      try
        sl.Delimiter := '^';
        sl.StrictDelimiter := True;
        sl.DelimitedText := iValue;

        if iIndex = '0' then
        begin
          lv.ViewStyle := vsReport;

          for I := 0 to sl.Count - 1 do
          begin
            lvcolumn := lv.Columns.Add;
            lvcolumn.AutoSize := True;
            lvcolumn.Caption := sl[I];
          end;
          Exit;
        end;

        lvitem := lv.Items.Add;
        lvitem.Caption := sl[0];

        if sl.Count > 1 then
          for I := 1 to sl.Count - 1 do
            lvitem.SubItems.Add(sl[I]);

        if AnsiContainsText(iIndex, 'TRUE') then
          lvitem.Checked := True;

      finally
        sl.Free;
      end;
    end else if iClass.InheritsFrom(TCustomMemo) then
      TCustomMemo(wControl).Lines.Add(iValue)
    else if iClass.InheritsFrom(TStringGrid) then
    begin
      sg := TStringGrid(wControl);

      // Columns
      if StrToInt(Piece(iIndex,',',1)) > sg.ColCount - 1 then
        sg.ColCount := (StrToInt(Piece(iIndex,',',1)) - (sg.ColCount - 1));

      // Rows
      if StrToInt(Piece(iIndex,',',2)) > sg.RowCount - 1 then
        sg.RowCount := (StrToInt(Piece(iIndex,',',2)) - (sg.RowCount - 1));

      sg.Cells[StrToInt(Piece(iIndex,',',1)), StrToInt(Piece(iIndex,',',2))] := iValue;
    end;
  except
  end;
end;

function LoadDialogs: THandle;
var
  Path,tmp: string;
  PathLen,I: Integer;
begin
  Path := ExtractFilePath(GetModuleName(HInstance));

  if FileExists(Path + 'DDCSDialogs.dll') then
    Path := Path + 'DDCSDialogs.dll'
  else if DirectoryExists(Path + 'Extensions\') then
    Path := Path + 'Extensions\DDCSDialogs.dll'
  else
  begin
    Path := ExtractFileDir(GetModuleName(HInstance));
    PathLen := Length(Path);
    for I := PathLen downto 1 do
    begin
      if ((Path[I] = ':') or (Path[I] = '\')) then
        Break
      else
        Delete(Path,I,Length(Path));
    end;
    Path := Path + 'Extensions\DDCSDialogs.dll';
  end;

  try
    Result := SafeLoadLibrary(Path);

    if Result <> 0 then
    begin
      RegisterDialogs := GetProcAddress(Result, 'RegisterDialogs');
      DisplayDialog := GetProcAddress(Result, 'DisplayDialog');
      GetDialogComponents := GetProcAddress(Result, 'GetDialogComponents');

      DLLDialogList.Text := RegisterDialogs;
    end else if RPCBrokerV <> nil then
    begin
      RPCBrokerV.SetContext(MENU_CONTEXT);
      tmp := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'DIALOGS REQUIRED']);

      if ((tmp <> '') and (StrToBool(tmp))) then
        raise Exception.Create('This interface requires DDCSDialogs.dll to be present.' + #10#13 +
                               'This interface may not work correctly.');
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

end.
