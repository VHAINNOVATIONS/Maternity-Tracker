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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, System.Win.ComObj, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus, Vcl.CheckLst, Vcl.Grids, FSAPILib_TLB,
  ORDtTm, ORCtrls, uExtndComBroker;

const
  U = '^';
  MENU_CONTEXT    = 'DSIO DDCS CONTEXT';
  WM_SHOW_SPLASH  = WM_USER + 270;
  WM_SAVE         = WM_USER + 280;

type
  TScreenReader = class(TObject)
  private
    FActive: Boolean;
    ObjGUID: TGUID;
    ObjIntf: IUnknown;
    Obj: IJawsApi;
    function IsObjectRegistered: Boolean;
  public
    constructor Create;
    procedure Say(txt: string; stop: Boolean);
  end;

        TDisplayDialog = function(Broker: PCPRSComBroker; dlgName: WideString; DebugMode: Boolean): WideString; stdcall;
      TRegisterDialogs = function: WideString; stdcall;
  TGetDialogComponents = function(dlgName: WideString): WideString; stdcall;

  procedure Fill(wControl: TWinControl; iIndex,iValue: string);
  function LoadDialogs: THandle;

  // Using VAUtils will return up to LastNum of delimiter even if the pieces didn't exist in the string
  function Pieces(const S: string; Delim: char; FirstNum, LastNum: Integer): string;

var
  ScreenReader: TScreenReader;
  DLLDialogList: TStringList;
  DialogDLL: THandle;
  RegisterDialogs: TRegisterDialogs;
  GetDialogComponents: TGetDialogComponents;
  DisplayDialog: TDisplayDialog;

implementation

uses
  ORFn, VAUtils, uReportItems;

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
  I: Integer;
  cb: TCustomComboBox;
  cbo: TORComboBox;
  lb: TCustomListBox;
  lbo: TORListBox;
  lv: TListView;
  lvo: TORListView;
  lvitem: TListItem;
  lvcolumn: TListColumn;
  sl: TStringList;
  sg: TStringGrid;
begin
  if iValue = '' then
    Exit;

  try
    // TOR ---------------------------------------------------------------------
      if wControl is TORDateBox then
        TORDateBox(wControl).Text := iValue
      else if wControl is TORCheckBox then
        TORCheckBox(wControl).Checked := True
      else if wControl is TORComboBox then
      begin
        cbo := TORComboBox(wControl);
        cbo.Items.Add(iValue);
        if AnsiContainsText(iIndex, 'TRUE') then
        begin
          for I := 0 to cbo.Items.Count do
            if cbo.Items[I] = iValue then
            begin
              cbo.ItemIndex := I;
              Break;
            end;
        end;
      end
      else if wControl is TORListBox then
      begin
        lbo := TORListBox(wControl);
        lbo.Items.Add(iValue);
        if AnsiContainsText(iIndex, 'TRUE') then
        begin
          if lbo.CheckBoxes then
            lbo.Checked[lbo.Items.IndexOf(iValue)] := True
          else
            lb.Selected[lb.Items.Count - 1] := True;
        end;
      end
      else if wControl is TORListView then
      begin
        lvo := TORListView(wControl);
        sl := TStringList.Create;
        try
          sl.Delimiter := U;
          sl.StrictDelimiter := True;
          sl.DelimitedText := iValue;
          if iIndex = '0' then
          begin
            lvo.ViewStyle := vsReport;
            for I := 0 to sl.Count - 1 do
            begin
              lvcolumn := lvo.Columns.Add;
              lvcolumn.AutoSize := True;
              lvcolumn.Caption := sl[I];
            end;
            Exit;
          end;
          lvitem := lvo.Items.Add;
          lvitem.Caption := sl[0];
          if sl.Count > 1 then
            for I := 1 to sl.Count - 1 do
              lvitem.SubItems.Add(sl[I]);
          if AnsiContainsText(iIndex, 'TRUE') then
            lvitem.Checked := True;
        finally
          sl.Free;
        end;
      end;
    // -------------------------------------------------------------------------
    // Legacy ------------------------------------------------------------------
      // TStaticText is not normally part of the NoteItems but can be manually created
      // and if it is we want to use it but we wouldn't want to normally.
      if wControl is TStaticText then
        TStaticText(wControl).Caption := iValue
      else if wControl.InheritsFrom(TDateTimePicker) then
        TDateTimePicker(wControl).DateTime := StrToDate(iValue)
      else if wControl.InheritsFrom(TCustomMemo) then             // Must come before TCustomEdit
        TCustomMemo(wControl).Lines.Add(iValue)
      else if wControl.InheritsFrom(TCustomEdit) then
        TCustomEdit(wControl).Text := iValue
      else if wControl.InheritsFrom(TCheckBox) then
        TCheckBox(wControl).Checked := True
      else if wControl.InheritsFrom(TRadioButton) then
        TRadioButton(wControl).Checked := True
      else if wControl.InheritsFrom(TRadioGroup) then
        TRadioGroup(wControl).ItemIndex := StrToInt(iIndex)
      else if wControl.InheritsFrom(TCustomComboBox) then
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
      end
      else if wControl.InheritsFrom(TCustomListBox) then
      begin
        lb := TCustomListBox(wControl);
        lb.Items.Add(iValue);
        if AnsiContainsText(iIndex, 'TRUE') then
        begin
          if wControl.InheritsFrom(TCheckListBox) then
            TCheckListBox(wControl).Checked[TCheckListBox(wControl).Items.IndexOf(iValue)] := True
          else
            lb.Selected[lb.Items.Count - 1] := True;
        end;
      end
      else if wControl.InheritsFrom(TListView) then
      begin
        lv := TListView(wControl);
        sl := TStringList.Create;
        try
          sl.Delimiter := U;
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
      end
      else if wControl.InheritsFrom(TStringGrid) then
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
    // -------------------------------------------------------------------------
  except
  end;
end;

// Used by both the DDCSForm Component and directly from the configuration forms
function LoadDialogs: THandle;
var
  Path,tmp,messtxt: string;
  PathLen,I: Integer;
begin
  Result := 0;
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
    end else
    begin
      if RPCBrokerV <> nil then
      begin
        if UpdateContext(MENU_CONTEXT) then
        begin
          tmp := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'DIALOGS REQUIRED']);

          if ((tmp <> '') and (StrToBool(tmp))) then
            messtxt := 'This interface requires the DDCSDialogs.dll to be present but was not found.';
        end;
      end;

      ShowMsg(messtxt + 'Once the DDCSDialogs.dll is in place you can attempt to reload it via the "Load Dialogs" ' +
                        'open accessed from the commend menu.', smiWarning, smbOK);
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

function Pieces(const S: string; Delim: char; FirstNum, LastNum: Integer): string;
{ returns several contiguous pieces without extra delimiters}
var
  sl: TStringList;
  I: Integer;
begin
  Result := '';

  sl := TStringList.Create;
  try
    sl.Delimiter := Delim;
    sl.StrictDelimiter := True;
    sl.DelimitedText := S;

    if FirstNum > sl.Count then
      Exit;

    for I := FirstNum - 1 to sl.Count - 1 do
    begin
      Result := Result + U + sl[I];

      if I = LastNum - 1 then
        Break;
    end;

    if Length(Result) > 0 then
      Delete(Result, 1, 1);
  finally
    sl.Free;
  end;
end;

end.
