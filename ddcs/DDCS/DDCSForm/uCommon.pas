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
  Windows, SysUtils, Classes, Controls, Dialogs, Extctrls, ComCtrls, StdCtrls,
  Spin, CheckLst, JvStringGrid, Jvspin, StrUtils, uExtndComBroker;

const
  U = '^';
  MENU_CONTEXT = 'DSIO DDCS CONTEXT';

type
  TDisplayDialog = function(Broker: PCPRSComBroker; dlgName: WideString; DebugMode: Boolean): WideString; stdcall;
  TRegisterDialogs = function: WideString; stdcall;
  TGetDialogComponents = function(dlgName: WideString): WideString; stdcall;

  function BuildDiscreetData(Sender: TWinControl; sVal: string): TStringList;
  function SubCount(str: string; d: Char): Integer;
  function LoadDialogs: THandle;

  procedure Fill(Sender: TObject; Indx,Val: string);

var
  RegisterDialogs: TRegisterDialogs;
  GetDialogComponents: TGetDialogComponents;
  DisplayDialog: TDisplayDialog;

implementation

function BuildDiscreetData(Sender: TWinControl; sVal: string): TStringList;
var
  I,ctI: Integer;
  tmpstr: string;

 // Data format ---------------------------------------------------------------
 //   CONTROL^(INDEXED^VALUE)

begin
  Result := TStringList.Create;
  Result.Clear;

  if Sender = nil then
    Exit;

  if (Sender.ClassType = TPanel) or (Sender.ClassType = TGroupBox) then
  begin
    for I := 0 to Sender.ControlCount - 1 do
      BuildDiscreetData(TWinControl(Sender.Controls[I]),'')
  end else if Sender.ClassType = TPageControl then
  begin
    for I := 0 to TPageControl(Sender).PageCount - 1 do
      for ctI := 0 to TPageControl(Sender).Pages[I].ControlCount - 1 do
        BuildDiscreetData(TWinControl(TPageControl(Sender).Pages[I].Controls[ctI]),'');
  end;

  if Sender.ClassType = TDateTimePicker then
  begin
    if TDateTimePicker(Sender).Format <> ' ' then
      Result.Add(TDateTimePicker(Sender).Name + '^^' + DateToStr(TDateTimePicker(Sender).DateTime) + sVal);
  end
  else if Sender.ClassType = TEdit then
    Result.Add(TEdit(Sender).Name + '^^' + TEdit(Sender).Text + sVal)
  else if Sender.ClassType = TLabeledEdit then
    Result.Add(TLabeledEdit(Sender).Name + '^^' + TLabeledEdit(Sender).Text + sVal)
  else if Sender.ClassType = TCheckBox then
  begin
    if TCheckBox(Sender).Checked then
    begin
      if TCheckBox(Sender).Caption <> '' then
        Result.Add(TCheckBox(Sender).Name + '^^' + TCheckBox(Sender).Caption + sVal)
      else
        Result.Add(TCheckBox(Sender).Name + '^^' + TCheckBox(Sender).Hint + sVal);
    end else if not TCheckBox(Sender).Checked then
      Result.Add(TCheckBox(Sender).Name + '^^');
  end
  else if Sender.ClassType = TRadioButton then
  begin
    if TRadioButton(Sender).Checked then
    begin
      if TRadioButton(Sender).Caption <> '' then
        Result.Add(TRadioButton(Sender).Name + '^^' + TRadioButton(Sender).Caption + sVal)
      else
        Result.Add(TRadioButton(Sender).Name + '^^' + TRadioButton(Sender).Hint + sVal);
    end else if not TRadioButton(Sender).Checked then
      Result.Add(TRadioButton(Sender).Name + '^^');
  end
  else if Sender.ClassType = TRadioGroup then
  begin
    if TRadioGroup(Sender).ItemIndex <> -1 then
      Result.Add(TRadioGroup(Sender).Name + U + IntToStr(TRadioGroup(Sender).ItemIndex) + U +
                 TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex] + sVal)
    else
      Result.Add(TRadioGroup(Sender).Name + '^^');
  end
  else if (Sender.ClassType = TSpinEdit) or (Sender.ClassType = TJVSpinEdit) then
    Result.Add(TSpinEdit(Sender).Name + '^^' + TSpinEdit(Sender).Text + sVal)
  else if Sender.ClassType = TComboBox then
  begin
    if TComboBox(Sender).ItemIndex <> -1 then
      Result.Add(TComboBox(Sender).Name + U + IntToStr(TComboBox(Sender).ItemIndex) + 'TRUE^' +
                 TComboBox(Sender).Items[TComboBox(Sender).ItemIndex] + sVal)
    else
    begin
      if TComboBox(Sender).Text <> '' then
        Result.Add(TComboBox(Sender).Name + '^^' + TComboBox(Sender).Text + sVal)
      else
        Result.Add(TComboBox(Sender).Name + '^^');
    end;
  end
  else if Sender.ClassType = TListBox then
  begin
    for I := 0 to TListBox(Sender).Count - 1 do
    begin
      if TListBox(Sender).Selected[I] then
        Result.Add(TListBox(Sender).Name + U + IntToStr(I) + 'TRUE^' + TListBox(Sender).Items[I])
      else
        Result.Add(TListBox(Sender).Name + U + IntToStr(I) + U + TListBox(Sender).Items[I]);
    end;
  end
  else if Sender.ClassType = TCheckListBox then
  begin
    for I := 0 to TCheckListBox(Sender).Count - 1 do
    begin
      if TCheckListBox(Sender).Checked[I] then
        Result.Add(TCheckListBox(Sender).Name + U + IntToStr(I) + 'TRUE^' + TCheckListBox(Sender).Items[I])
      else
        Result.Add(TCheckListBox(Sender).Name + U + IntToStr(I) + U + TCheckListBox(Sender).Items[I])
    end;
  end else if Sender.ClassType = TListView then
  begin
    tmpstr := '';
    for I := 0 to TListView(Sender).Columns.Count - 1 do
      if tmpstr <> '' then
        tmpstr := tmpstr + U + TListView(Sender).Column[I].Caption
      else
        tmpstr := TListView(Sender).Column[I].Caption;

    Result.Add(TListView(Sender).Name + '^0^' + tmpstr);

    for I := 0 to TListView(Sender).Items.Count - 1 do
    begin
      tmpstr := TListView(Sender).Items.Item[I].Caption;
      for ctI := 0 to TListView(Sender).Items.Item[I].SubItems.Count - 1 do
        tmpstr := tmpstr + U + TListView(Sender).Items[I].SubItems[ctI];

      if TListView(Sender).ViewStyle = vsReport then
        ctI := 1
      else ctI := 0;

      if TListView(Sender).Checkboxes then
      begin
        if TListView(Sender).Items[I].Checked then
          Result.Add(TListView(Sender).Name + U + IntToStr(I+ctI) + 'TRUE^' + tmpstr)
        else
          Result.Add(TListView(Sender).Name + U + IntToStr(I+ctI) + U + tmpstr);
      end else
        Result.Add(TListView(Sender).Name + U + IntToStr(I+ctI) + U + tmpstr);
    end;
  end else if Sender.ClassType = TMemo then
  begin
    for ctI := 0 to TMemo(Sender).Lines.Count - 1 do
      Result.Add(TMemo(Sender).Name + '^^' + TMemo(Sender).Lines.Strings[ctI]);
  end else if Sender.ClassType = TRichEdit then
  begin
    for ctI := 0 to TRichEdit(Sender).Lines.Count - 1 do
      Result.Add(TRichEdit(Sender).Name + '^^' + TRichEdit(Sender).Lines.Strings[ctI]);
  end else if Sender.ClassType = TJvStringGrid then
  begin
    for I := 0 to TJvStringGrid(Sender).RowCount - 1 do
      for ctI := 0 to TJvStringGrid(Sender).ColCount - 1 do
        Result.Add(TJvStringGrid(Sender).Name + U + IntToStr(ctI) + ',' + IntToStr(I) + U + TJvStringGrid(Sender).Cells[ctI,I]);
  end;
end;

function SubCount(str: string; d: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(str) - 1 do
    if str[I] = d then
      inc(Result);
end;

function LoadDialogs: THandle;
var
  DDCSConfig,Path: string;
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

    RPCBrokerV.SetContext(MENU_CONTEXT);
    DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'DIALOGS REQUIRED']);

    if ((Result = 0) and ((DDCSConfig <> '') and (StrToBool(DDCSConfig)))) then
      ShowDialog(RPCBrokerV.Owner, 'This interface requires DDCSDialogs.dll to be present.' + #10#13 +
                'This interface may not work correctly.', mtWarning);
  except
    on E: Exception do
    if ((DDCSConfig <> '') and (StrToBool(DDCSConfig))) then
      ShowDialog(RPCBrokerV.Owner, E.Message, mtError);
  end;
end;

procedure Fill(Sender: TObject; Indx,Val: string);
var
  I: Integer;
  ClassRef: string;
  sl: TStringList;
  lvitem: TListItem;
  lvcolumn: TListColumn;
  emControl: TWinControl;
begin
  if Val = '' then
    Exit;

  ClassRef := Sender.ClassName;
  try
    if ClassRef = 'TDateTimePicker' then
      TDateTimePicker(Sender).DateTime := StrToDate(Val)
    else if ClassRef = 'TEdit' then
      TEdit(Sender).Text := Val
    else if ClassRef = 'TLabeledEdit' then
      TLabeledEdit(Sender).Text := Val
    else if ClassRef = 'TLabel' then
      TLabel(Sender).Caption := Val
    else if ClassRef = 'TCheckBox' then
      TCheckBox(Sender).Checked := True
    else if ClassRef = 'TRadioButton' then
      TRadioButton(Sender).Checked := True
    else if ClassRef = 'TRadioGroup' then
      TRadioGroup(Sender).ItemIndex := StrToInt(Indx)
    else if ClassRef = 'TSpinEdit' then
      TSpinEdit(Sender).Text := Val
    else if ClassRef = 'TJvSpinEdit' then
      TJvSpinEdit(Sender).Text := Val
    else if ClassRef = 'TComboBox' then
    begin
      TComboBox(Sender).Items.Add(Val);

      if AnsiContainsText(Indx, 'TRUE') then
      begin
        for I := 0 to TComboBox(Sender).Items.Count do
          if TComboBox(Sender).Items[I] = Val then
          begin
            TComboBox(Sender).ItemIndex := I;
            Break;
          end;
      end;
    end else if ClassRef = 'TListBox' then
    begin
      TListBox(Sender).Items.Add(Val);

      if AnsiContainsText(Indx, 'TRUE') then
        TListBox(Sender).Selected[TListBox(Sender).Items.Count - 1] := True;
    end else if ClassRef = 'TCheckListBox' then
    begin
      if TCheckListBox(Sender).Items.IndexOf(Val) = -1 then
        TCheckListBox(Sender).Items.Add(Val);

      if AnsiContainsText(Indx, 'TRUE') then
        TCheckListBox(Sender).Checked[TCheckListBox(Sender).Items.IndexOf(Val)] := True;
    end else if ClassRef = 'TListView' then
    begin
      sl := TStringList.Create;
      try
        sl.Delimiter := '^';
        sl.StrictDelimiter := True;
        sl.DelimitedText := Val;

        if Indx = '0' then
        begin
          TListView(Sender).ViewStyle := vsReport;

          for I := 0 to sl.Count - 1 do
          begin
            lvcolumn := TListView(Sender).Columns.Add;
            lvcolumn.AutoSize := True;
            lvcolumn.Caption := sl[I];
          end;
          Exit;
        end;

        lvitem := TListView(Sender).Items.Add;
        lvitem.Caption := sl[0];

        if sl.Count > 1 then
          for I := 1 to sl.Count - 1 do
            lvitem.SubItems.Add(sl[I]);

        if AnsiContainsText(Indx, 'TRUE') then
          lvitem.Checked := True;

      finally
        sl.Free;
      end;
    end else if ClassRef = 'TMemo' then
      TMemo(Sender).Lines.Add(Val)
    else if ClassRef = 'TRichEdit' then
      TRichEdit(Sender).Lines.Add(Val)
    else if ClassRef = 'TJvStringGrid' then
    begin
      if StrToInt(Piece(Indx,',',1)) > TJvStringGrid(Sender).ColCount - 1 then
        TJvStringGrid(Sender).InsertCol(StrToInt(Piece(Indx,',',1)));
      if StrToInt(Piece(Indx,',',2)) > TJvStringGrid(Sender).RowCount - 1 then
        TJvStringGrid(Sender).InsertRow(StrToInt(Piece(Indx,',',2)));

      TJvStringGrid(Sender).Cells[StrToInt(Piece(Indx,',',1)), StrToInt(Piece(Indx,',',2))] := Val;
      TJvStringGrid(Sender).AutoSizeCol(StrToInt(Piece(Indx,',',1)), Length(Val), 10);
    end;
  except
  end;
end;

end.
