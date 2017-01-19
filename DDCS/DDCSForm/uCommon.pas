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
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  Vcl.CheckLst, Vcl.Grids, ORDtTm, ORCtrls;

const
  MENU_CONTEXT = 'DSIO DDCS CONTEXT';

  procedure Fill(wControl: TWinControl; iIndex,iValue: string);

implementation

uses
  DDCSUtils;

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
  lvItem: TListItem;
  lvcolumn: TListColumn;
  sl: TStringList;
  sg: TStringGrid;
  Ic,Ir: Integer;
begin
  if iValue = '' then
    Exit;

  try
    // TOR ---------------------------------------------------------------------
      if wControl is TORDateBox then
        TORDateBox(wControl).Text := iValue
      else if wControl is TORCheckBox then
      begin
        if AnsiContainsText(iIndex, 'TRUE') then
          TORCheckBox(wControl).Checked := True;
      end
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
          if iIndex = 'H' then
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
          lvItem := lvo.Items.Add;
          lvItem.Caption := sl[0];
          if sl.Count > 1 then
            for I := 1 to sl.Count - 1 do
              lvItem.SubItems.Add(sl[I]);
          if AnsiContainsText(iIndex, 'TRUE') then
            lvItem.Checked := True;
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
      begin
        if AnsiContainsText(iIndex, 'TRUE') then
          TCheckBox(wControl).Checked := True;
      end
      else if wControl.InheritsFrom(TRadioButton) then
      begin
        if AnsiContainsText(iIndex, 'TRUE') then
          TRadioButton(wControl).Checked := True;
      end
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
          if iIndex = 'H' then
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
          lvItem := lv.Items.Add;
          lvItem.Caption := sl[0];
          if sl.Count > 1 then
            for I := 1 to sl.Count - 1 do
              lvItem.SubItems.Add(sl[I]);
          if AnsiContainsText(iIndex, 'TRUE') then
            lvItem.Checked := True;
        finally
          sl.Free;
        end;
      end
      else if wControl.InheritsFrom(TStringGrid) then
      begin
        sg := TStringGrid(wControl);

        Ic := StrToIntDef(Piece(iIndex,',',1), -1);
        Ir := StrToIntDef(Piece(iIndex,',',2), -1);
        if (Ic < 0) or (Ir < 0) then
          Exit;
        if Ic <= (sg.FixedCols - 1) then
          Exit;
        if Ir <= (sg.FixedRows - 1) then
          Exit;

        if Ic > sg.ColCount - 1 then
          sg.ColCount := Ic + 1;
        if Ir > sg.RowCount - 1 then
          sg.RowCount := Ir + 1;

        sg.Cells[Ic,Ir] := iValue;
      end;
    // -------------------------------------------------------------------------
  except
  end;
end;

end.
