unit uReportItems;

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
  System.TypInfo, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, Vcl.Grids,
  Vcl.CheckLst, ORCtrls, ORDtTm, uCommon;

type
  TDDCSNoteItem = class(TCollectionItem)
    private
      FConfig: TStringList;
      FIDName: string;
      FTitle: string;
      FPrefix: string;
      FSuffix: string;
      FSpace: Boolean;
      FHide: Boolean;
      FSave: Boolean;
      FObject: TWinControl;
      FRequired: Boolean;
      FReturn: TWinControl;
    protected
      procedure SetObject(Value: TWinControl);
      procedure SetDialogReturn(Value: TWinControl);
      function GetDisplayName: string; override;
      function GetIDName: string;
      function GetOrder: Integer;
      function GetPage: TTabSheet;
    public
      constructor Create(Collection: TCollection); override;
      destructor Destroy; override;
      procedure Assign(Source: TPersistent); override;
      procedure SetIndex(Value: Integer); override;
      function IsValid: Boolean;
      function GetValueNote: TStringList;
      function GetValueSave: TStringList;
      property Page: TTabSheet read GetPage;
      property Configuration: TStringList read FConfig write FConfig;
    published
      property Order: Integer read GetOrder write SetIndex;
      property IdentifyingName: string read GetIDName write FIDName;
      property Title: string read FTitle write FTitle;
      property Prefix: string read FPrefix write FPrefix;
      property Suffix: string read FSuffix write FSuffix;
      property DoNotSpace: Boolean read FSpace write FSpace;
      property HideFromNote: Boolean read FHide write FHide;
      property DoNotSave: Boolean read FSave write FSave;
      property OwningObject: TWinControl read  FObject write SetObject;
      property Required: Boolean read FRequired write FRequired;
      property DialogReturn: TWinControl read FReturn write SetDialogReturn;
  end;

  TDDCSNoteCollection = class(TOwnedCollection)
  private
    procedure SetItem(Index: Integer; Value: TDDCSNoteItem);
    function GetItem(Index: Integer): TDDCSNoteItem; overload;
  public
    procedure DeleteNoteItem(Value: TWinControl);
    function GetNoteItemAddifNil(Value: TWinControl): TDDCSNoteItem;
    function GetNoteItem(Value: TWinControl): TDDCSNoteItem;
    function GetAControl(Value: string): TWinControl;
    function Add: TDDCSNoteItem; overload;
    function Insert(Index: Integer): TDDCSNoteItem;
    property Items[Index: Integer]: TDDCSNoteItem read GetItem write SetItem;
  end;

implementation

uses
  uBase, frmVitals, uExtndComBroker;

{$REGION 'TDDCSNoteItem'}

// Protected -------------------------------------------------------------------

procedure TDDCSNoteItem.SetObject(Value: TWinControl);
var
  iNote: TDDCSNoteItem;
begin
  iNote := TDDCSNoteCollection(Collection).GetNoteItem(Value);

  if (iNote = nil) or (iNote = Self) then
    FObject := Value
  else
    raise Exception.Create('Object cannot be assigned to multiple note elements.');
end;

procedure TDDCSNoteItem.SetDialogReturn(Value: TWinControl);
begin
  if Value.InheritsFrom(TCustomMemo) then
    FReturn := Value
  else
    FReturn := nil;
end;

function TDDCSNoteItem.GetDisplayName: string;
begin
  Result := ClassName;

  if FObject <> nil then
    Result := FObject.Name;
end;

function TDDCSNoteItem.GetIDName: string;
begin
  if ((FObject <> nil) and (IsPublishedProp(FObject, 'Caption'))) then
    FIDName := GetPropValue(FObject, 'Caption');
  Result := FIDName;
end;

function TDDCSNoteItem.GetOrder;
begin
  Result := Index;
end;

function TDDCSNoteItem.GetPage: TTabSheet;
var
  wControl: TWinControl;
begin
  Result := nil;

  if FObject = nil then
    Exit;

  wControl := FObject;
  Repeat
    wControl := wControl.Parent;
  Until ((wControl is TTabSheet) and (wControl.Parent is TDDCSForm)) or (wControl.Parent = nil);

  if ((wControl is TTabSheet) and (wControl.Parent is TDDCSForm)) then
    Result := TTabSheet(wControl);
end;

// Public ----------------------------------------------------------------------

constructor TDDCSNoteItem.Create(Collection: TCollection);
begin
  inherited;

  FConfig := TStringList.Create;
end;

destructor TDDCSNoteItem.Destroy;
begin
  FConfig.Free;

  inherited;
end;

procedure TDDCSNoteItem.Assign(Source: TPersistent);
var
  nItem: TDDCSNoteItem;
begin
  if Source is TDDCSNoteItem then
  begin
    nItem := TDDCSNoteItem(Source);
    IdentifyingName    := nItem.IdentifyingName;
    Order              := nItem.Order;
    Title              := nItem.Title;
    Prefix             := nItem.Prefix;
    Suffix             := nItem.Suffix;
    DoNotSpace         := nItem.DoNotSpace;
    HideFromNote       := nItem.HideFromNote;
    DoNotSave          := nItem.DoNotSave;
    OwningObject       := nItem.OwningObject;
    Required           := nItem.Required;
    DialogReturn       := nItem.DialogReturn;
  end else inherited;
end;

procedure TDDCSNoteItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
end;

function TDDCSNoteItem.IsValid: Boolean;
var
  I: Integer;
  lb: TCustomListBox;
begin
  Result := True;

  if not FRequired then
    Exit;

  try
    // TStaticText is not normally part of the NoteItems but can be manually created
    // and if it is we want to use it but we wouldn't want to normally.
    if FObject is TStaticText then
    begin
      if TStaticText(FObject).Caption = '' then
        Result := False;
    end
    else if FObject.InheritsFrom(TORDateBox) then
      Result := TORDateBox(FObject).IsValid
    else if FObject.InheritsFrom(TCustomLabel) then
    begin
      if TCustomLabel(FObject).Caption = '' then
        Result := False;
    end
    else if FObject is TORDateBox then
      Result := TORDateBox(FObject).IsValid
    else if FObject.InheritsFrom(TDateTimePicker) then
    begin
      if TDateTimePicker(FObject).Format = ' ' then
        Result := False;
    end
    else if FObject.InheritsFrom(TCustomMemo) then          // Must come before TCustomEdit
    begin
      if TCustomMemo(FObject).Lines.Count < 1 then
        Result := False;
    end
    else if FObject.InheritsFrom(TCustomEdit) then
    begin
      if TCustomEdit(FObject).Text = '' then
        Result := False;
    end
    else if FObject.InheritsFrom(TCheckBox) then
    begin
      if not TCheckBox(FObject).Checked then
        Result := False;
    end
    else if FObject.InheritsFrom(TRadioButton) then
    begin
      if not TRadioButton(FObject).Checked then
        Result := False;
    end
    else if FObject.InheritsFrom(TRadioGroup) then
    begin
      if TRadioGroup(FObject).ItemIndex = -1 then
        Result := False;
    end
    else if FObject.InheritsFrom(TCustomComboBox) then
    begin
      if TCustomComboBox(FObject).ItemIndex = -1 then
      begin
        if FObject.InheritsFrom(TComboBox) then
        begin
          if ((TComboBox(FObject).Style = csDropDown) and (TComboBox(FObject).Text = '')) then
            Result := False
        end else
          Result := False;
      end;
    end
    else if FObject.InheritsFrom(TCustomListBox) then
    begin
      Result := False;

      lb := TCustomListBox(FObject);

      if FObject.InheritsFrom(TCheckListBox) then
      begin
        for I := 0 to TCheckListBox(FObject).Count - 1 do
        begin
          if TCheckListBox(FObject).Checked[I] then
          begin
            Result := True;
            Break;
          end;
        end;
      end else
      begin
        for I := 0 to lb.Count - 1 do
        begin
          if lb.Selected[I] then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  except
  end;
end;

function TDDCSNoteItem.GetValueNote: TStringList;
var
  I,J: Integer;
  ck: TCheckBox;
  rb: TRadioButton;
  lb: TCustomListBox;
  lv: TListView;
  sg: TStringGrid;
  str: string;
begin
  Result := TStringList.Create;

  if FHide then
    Exit;

  if FTitle <> '' then
    Result.Add(FTitle);

  try
    try
      // TStaticText is not normally part of the NoteItems but can be manually created
      // and if it is we want to use it but we wouldn't want to normally.
      if FObject is TStaticText then
        Result.Add(FPrefix + TStaticText(FObject).Caption + FSuffix)
      else if FObject.InheritsFrom(TORDateBox) then
        Result.Add(FPrefix + TORDateBox(FObject).Text + FSuffix)
      else if FObject.InheritsFrom(TCustomLabel) then
        Result.Add(FPrefix + TCustomLabel(FObject).Caption + FSuffix)
      else if FObject is TORDateBox then
      begin
        if TORDateBox(FObject).IsValid then
          Result.Add(FPrefix + TORDateBox(FObject).Text + FSuffix);
      end
      else if FObject.InheritsFrom(TDateTimePicker) then
      begin
        if TDateTimePicker(FObject).Format <> ' ' then
          Result.Add(FPrefix + DateToStr(TDateTimePicker(FObject).DateTime) + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomMemo) then                       // Must come before TCustomEdit
      begin
        for I := 0 to TCustomMemo(FObject).Lines.Count - 1 do
          Result.Add(FPrefix + TCustomMemo(FObject).Lines[I] + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomEdit) then
        Result.Add(FPrefix + TCustomEdit(FObject).Text + FSuffix)
      else if FObject.InheritsFrom(TCheckBox) then
      begin
        ck := TCheckBox(FObject);

        if ck.Checked then
        begin
          if ck.Caption <> '' then
            Result.Add(FPrefix + ck.Caption + FSuffix)
          else
            Result.Add(FPrefix + ck.Hint + FSuffix)
        end;
      end
      else if FObject.InheritsFrom(TRadioButton) then
      begin
        rb := TRadioButton(FObject);

        if rb.Checked then
        begin
          if rb.Caption <> '' then
            Result.Add(FPrefix + rb.Caption + FSuffix)
          else
            Result.Add(FPrefix + rb.Hint + FSuffix)
        end;
      end
      else if FObject.InheritsFrom(TRadioGroup) then
      begin
        if TRadioGroup(FObject).ItemIndex <> -1 then
          Result.Add(FPrefix + TRadioGroup(FObject).Items.Strings[TRadioGroup(FObject).ItemIndex] + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomComboBox) then
      begin
        if FObject.InheritsFrom(TComboBox) then
        begin
          if TComboBox(FObject).Text <> '' then
            Result.Add(FPrefix + TComboBox(FObject).Text + FSuffix);
        end else
        if TCustomComboBox(FObject).ItemIndex <> -1 then
          Result.Add(FPrefix + TCustomComboBox(FObject).Items[TCustomComboBox(FObject).ItemIndex] + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomListBox) then
      begin
        lb := TCustomListBox(FObject);

        if FObject.InheritsFrom(TCheckListBox) then
        begin
          for I := 0 to TCheckListBox(FObject).Count - 1 do
          begin
            if TCheckListBox(FObject).Checked[I] then
              Result.Add(FPrefix + TCheckListBox(FObject).Items[I] + FSuffix);
          end;
        end else
        begin
          for I := 0 to lb.Count - 1 do
          begin
            if lb.Selected[I] then
              Result.Add(FPrefix + lb.Items[I] + FSuffix);
          end;
        end;
      end
      else if FObject.InheritsFrom(TListView) then
      begin
        lv := TListView(FObject);

        // Need to space based on the the length of the values
        if lv.ViewStyle = vsReport then
          for I := 0 to lv.Columns.Count - 1 do
            if str <> '' then
              str := str + ' | ' + lv.Column[I].Caption
            else
              str := lv.Column[I].Caption;

        Result.Add(str);

        for I := 0 to lv.Items.Count - 1 do
        begin
          str := lv.Items.Item[I].Caption;

          for J := 0 to lv.Items.Item[I].SubItems.Count - 1 do
            str := str + ' | ' + lv.Items[I].SubItems[J];

          Result.Add(str);
        end;
      end
      else if FObject.InheritsFrom(TStringGrid) then
      begin
        sg := TStringGrid(FObject);

        for I := 0 to sg.RowCount - 1 do
          for J := 0 to sg.ColCount - 1 do
            Result.Add(FPrefix + sg.Cells[J,I] + FSuffix)
      end
      else if FObject is TDDCSVitals then
        Result.AddStrings(TDDCSVitals(FObject).GetCompleteNote);
    except
    end;
  finally
    if ((Result.Count > 0) and (not FSpace)) then
      Result.Add('');
  end;
end;

function TDDCSNoteItem.GetValueSave: TStringList;
var
  ck: TCheckBox;
  rb: TRadioButton;
  rg: TRadioGroup;
  cb: TCustomComboBox;
  lb: TCustomListBox;
  clb: TCheckListBox;
  lv: TListView;
  sg: TStringGrid;
  I,J: Integer;
  str: string;
begin
  Result := TStringList.Create;

  try
    try
      // TStaticText is not normally part of the NoteItems but can be manually created
      // and if it is we want to use it but we wouldn't want to normally.
      if FObject is TStaticText then
        Result.Add(FObject.Name + '^^' + TStaticText(FObject).Caption)
      else if FObject is TORDateBox then
      begin
        if TORDateBox(FObject).IsValid then
          Result.Add(FObject.Name + '^^' + FloatToStr(TORDateBox(FObject).FMDateTime));
      end
      else if FObject.InheritsFrom(TDateTimePicker) then
      begin
        if TDateTimePicker(FObject).Format <> ' ' then
          Result.Add(FObject.Name + '^^' + DateToStr(TDateTimePicker(FObject).DateTime));
      end
      else if FObject.InheritsFrom(TCustomMemo) then                          // Must come before TCustomEdit
      begin
        for I := 0 to TCustomMemo(FObject).Lines.Count - 1 do
          Result.Add(FObject.Name + '^^' + TCustomMemo(FObject).Lines[I]);
      end
      else if FObject.InheritsFrom(TCustomEdit) then
        Result.Add(FObject.Name + '^^' + TCustomEdit(FObject).Text)
      else if FObject.InheritsFrom(TCheckBox) then
      begin
        ck := TCheckBox(FObject);

        if ck.Checked then
        begin
          if ck.Caption <> '' then
            Result.Add(FObject.Name + '^TRUE^' + ck.Caption)
          else
            Result.Add(FObject.Name + '^TRUE^' + ck.Hint)
        end;
      end
      else if FObject.InheritsFrom(TRadioButton) then
      begin
        rb := TRadioButton(FObject);

        if rb.Checked then
        begin
          if rb.Caption <> '' then
            Result.Add(FObject.Name + '^TRUE^' + rb.Caption)
          else
            Result.Add(FObject.Name + '^TRUE^' + rb.Hint)
        end;
      end
      else if FObject.InheritsFrom(TRadioGroup) then
      begin
        rg := TRadioGroup(FObject);

        if rg.ItemIndex <> -1 then
          Result.Add(FObject.Name + U + IntToStr(rg.ItemIndex) + U + rg.Items.Strings[rg.ItemIndex]);
      end
      else if FObject.InheritsFrom(TCustomComboBox) then
      begin
        cb := TCustomComboBox(FObject);

        if cb.ItemIndex <> -1 then
          Result.Add(FObject.Name + U + IntToStr(cb.ItemIndex) + 'TRUE^' + cb.Items[cb.ItemIndex])
        else
        begin
          if FObject.InheritsFrom(TComboBox) then
            if TComboBox(FObject).Text <> '' then
              Result.Add(FObject.Name + '^^' + TComboBox(FObject).Text);
        end;
      end
      else if FObject.InheritsFrom(TCustomListBox) then
      begin
        if FObject.InheritsFrom(TCheckListBox) then
        begin
          clb := TCheckListBox(FObject);

          for I := 0 to clb.Count - 1 do
          begin
            if clb.Checked[I] then
              Result.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + clb.Items[I])
            else
              Result.Add(FObject.Name + '^^' + clb.Items[I]);
          end;
        end else
        begin
          lb := TCustomListBox(FObject);

          for I := 0 to lb.Count - 1 do
          begin
            if lb.Selected[I] then
              Result.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lb.Items[I])
            else
              Result.Add(FObject.Name + U + IntToStr(I) + U + lb.Items[I]);
          end;
        end;
      end
      else if FObject.InheritsFrom(TListView) then
      begin
        lv := TListView(FObject);

        // Need to space based on the the length of the values
        if lv.ViewStyle = vsReport then
          for I := 0 to lv.Columns.Count - 1 do
            if str <> '' then
              str := str + ' | ' + lv.Column[I].Caption
            else
              str := lv.Column[I].Caption;

        Result.Add(FObject.Name + '^0^' + str);

        for I := 0 to lv.Items.Count - 1 do
        begin
          str := lv.Items.Item[I].Caption;

          for J := 0 to lv.Items.Item[I].SubItems.Count - 1 do
            str := str + ' | ' + lv.Items[I].SubItems[J];

          Result.Add(FObject.Name + U + IntToStr(I) + U + str);
        end;
      end
      else if FObject.InheritsFrom(TStringGrid) then
      begin
        sg := TStringGrid(FObject);

        for I := 0 to sg.RowCount - 1 do
          for J := 0 to sg.ColCount - 1 do
            Result.Add(FObject.Name + U + IntToStr(J) + ',' + IntToStr(I) + U + sg.Cells[J,I])
      end;
    except
    end;
  finally
  end;
end;

{$ENDREGION}

{$REGION 'TDDCSNoteCollection'}

// Private ---------------------------------------------------------------------

procedure TDDCSNoteCollection.SetItem(Index: Integer; Value: TDDCSNoteItem);
begin
  inherited SetItem(Index, Value);
end;

function TDDCSNoteCollection.GetItem(Index: Integer): TDDCSNoteItem;
begin
  Result := TDDCSNoteItem(inherited Items[Index]);
end;

// Public ----------------------------------------------------------------------

procedure TDDCSNoteCollection.DeleteNoteItem(Value: TWinControl);
var
  Note: TDDCSNoteItem;
begin
  Note := GetNoteItem(Value);
  if Note <> nil then
    Delete(Note.Index);
end;

function TDDCSNoteCollection.GetNoteItemAddifNil(Value: TWinControl): TDDCSNoteItem;
begin
  Result := GetNoteItem(Value);

  if ((Result = nil) and (Value <> nil)) then
  begin
    Result := Add;
    Result.OwningObject := Value;
  end;
end;

function TDDCSNoteCollection.GetNoteItem(Value: TWinControl): TDDCSNoteItem;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].OwningObject = Value then
    begin
      Result := Items[I];
      Exit;
    end;
end;

function TDDCSNoteCollection.GetAControl(Value: string): TWinControl;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].OwningObject <> nil then
      if AnsiCompareText(Items[I].OwningObject.Name, Value) = 0 then
      begin
        Result := Items[I].OwningObject;
        Exit;
      end;
end;

function TDDCSNoteCollection.Add: TDDCSNoteItem;
begin
  Result := TDDCSNoteItem(inherited Add);
end;

function TDDCSNoteCollection.Insert(Index: Integer): TDDCSNoteItem;
begin
  Result := TDDCSNoteItem(inherited Insert(Index));
end;

{$ENDREGION}

end.
