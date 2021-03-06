unit DDCSCommon;

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
  MENU_CONTEXT   = 'DSIO DDCS CONTEXT';
  DTIME_FORMAT   = 'MM/DD/YYYY@hh:nn';
  DT_DATETIME    = 'mm/dd/yyyy';
  WM_SHOW_SPLASH = WM_USER + 19641;        // DDCSFORM
  WM_SAVE        = WM_USER + 19642;        // DDCSFORM
  WM_CELLSELECT  = WM_USER + 19643;        // DDCSGRID

type
  TDDCSObjects = class(TComponent)
  private
    FControlObject: string;
    FDDCSInterface: string;
    FDDCSInterfacePages: TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ControlObject: string read FControlObject write FControlObject;
    property DDCSInterface: string read FDDCSInterface write FDDCSInterface;
    property DDCSInterfacePages: TStringList read FDDCSInterfacePages write FDDCSInterfacePages;
  end;

  TComponentHelper = class
    class procedure cbAutoWidth(Sender: TObject);
    class procedure RadioGroupEnter(Sender: TObject);
  end;

  procedure Fill(wControl: TWinControl; iIndex,iValue: string);

var
  DDCSObjects: TDDCSObjects;

implementation

uses
  DDCSUtils;

{$REGION 'TDDCSObjects'}

constructor TDDCSObjects.Create(AOwner: TComponent);
begin
  inherited;

  FDDCSInterfacePages := TStringList.Create;
end;

destructor TDDCSObjects.Destroy;
begin
  FDDCSInterfacePages.Free;

  inherited;
end;

{$ENDREGION}

class procedure TComponentHelper.cbAutoWidth(Sender: TObject);
var
  cb: TCustomComboBox;
  I,itemWidth,itemsFullWidth: Integer;
begin
  if not Sender.InheritsFrom(TCustomComboBox) then
    Exit;

  cb := TCustomComboBox(Sender);

  for I := 0 to cb.Items.Count - 1 do
  begin
    itemWidth := cb.Canvas.TextWidth(cb.Items[I]);
    Inc(itemWidth, 8);
    if itemWidth > itemsFullWidth then
      itemsFullWidth := itemWidth;
  end;
  if itemsFullWidth > cb.Width then
  begin
    itemsFullWidth := 14 + itemsFullWidth + GetSystemMetrics(SM_CXVSCROLL);
    SendMessage(cb.Handle, CB_SETDROPPEDWIDTH, itemsFullWidth, 0);
  end;
end;

class procedure TComponentHelper.RadioGroupEnter(Sender: TObject);
var
  rg: TRadioGroup;
  I: Integer;
begin
  if not Sender.InheritsFrom(TRadioGroup) then
    Exit;

  rg := TRadioGroup(Sender);
  if rg.ItemIndex = -1 then
    for I := 0 to rg.ControlCount - 1 do
      TWinControl(rg.Controls[0]).TabStop := True;
end;

// Used by both the DDCSForm Component and the DDCSDialog Class
procedure Fill(wControl: TWinControl; iIndex,iValue: string);
var
  I,Ic,Ir: Integer;
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
begin
  if iValue = '' then
    Exit;

  try
    // TOR ---------------------------------------------------------------------
    if wControl is TORDateBox then
    begin
      TORDateBox(wControl).Text := iValue;
      Exit;
    end
    else
    if wControl is TORCheckBox then
    begin
      if AnsiContainsText(iIndex, 'TRUE') then
        TORCheckBox(wControl).Checked := True;
      Exit;
    end
    else
    if wControl is TORComboBox then
    begin
      cbo := TORComboBox(wControl);
      cbo.Items.Add(iValue);
      if AnsiContainsText(iIndex, 'TRUE') then
        for I := 0 to cbo.Items.Count do
          if cbo.Items[I] = iValue then
          begin
            cbo.ItemIndex := I;
            Break;
          end;
      Exit;
    end
    else
    if wControl is TORListBox then
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
      Exit;
    end
    else
    if wControl is TORListView then
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
      Exit;
    end;
    // -------------------------------------------------------------------------
    // Legacy ------------------------------------------------------------------
    //   TStaticText is not normally part of the NoteItems but can be manually created
    //   and if it is we want to use it but we wouldn't want to normally.
    if wControl is TStaticText then
    begin
      TStaticText(wControl).Caption := iValue;
      Exit;
    end
    else
    if wControl.InheritsFrom(TDateTimePicker) then
    begin
      TDateTimePicker(wControl).DateTime := StrToDate(iValue);
      Exit;
    end
    else
    if wControl.InheritsFrom(TCustomMemo) then             // Must come before TCustomEdit
    begin
      TCustomMemo(wControl).Lines.Add(iValue);
      Exit;
    end
    else
    if wControl.InheritsFrom(TCustomEdit) then
    begin
      TCustomEdit(wControl).Text := iValue;
      Exit;
    end
    else
    if wControl.InheritsFrom(TCheckBox) then
    begin
      if AnsiContainsText(iIndex, 'TRUE') then
        TCheckBox(wControl).Checked := True;
      Exit;
    end
    else if wControl.InheritsFrom(TRadioButton) then
    begin
      if AnsiContainsText(iIndex, 'TRUE') then
        TRadioButton(wControl).Checked := True;
      Exit;
    end
    else
    if wControl.InheritsFrom(TRadioGroup) then
    begin
      TRadioGroup(wControl).ItemIndex := StrToInt(iIndex);
      Exit;
    end
    else
    if wControl.InheritsFrom(TCustomComboBox) then
    begin
      cb := TCustomComboBox(wControl);
      cb.Items.Add(iValue);
      if AnsiContainsText(iIndex, 'TRUE') then
        for I := 0 to cb.Items.Count do
          if cb.Items[I] = iValue then
          begin
            cb.ItemIndex := I;
            Break;
          end;
      Exit;
    end
    else
    if wControl.InheritsFrom(TCustomListBox) then
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
      Exit;
    end
    else
    if wControl.InheritsFrom(TListView) then
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
      Exit;
    end
    else
    if wControl.InheritsFrom(TStringGrid) then
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
      Exit;
    end;
  except
  end;
end;

end.
