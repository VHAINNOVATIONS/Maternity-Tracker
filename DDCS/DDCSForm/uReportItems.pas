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
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.TypInfo, System.Classes, System.Character, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  Vcl.Grids, Vcl.CheckLst, ORCtrls, ORDtTm;

type
  TConfigItem = class(TCollectionItem)
  private
    FData: TStringList;
    FID1,FID2,FID3: string;
    procedure SetValue(Index: Integer; Value: string);
    procedure SetPiece(Index: Integer; Value: string);
    function GetValue(Index: Integer): string;
    function GetPiece(Index: Integer): string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property ID[Index: Integer]: string read GetValue write SetValue;
    property Piece[Index: Integer]: string read GetPiece write SetPiece;
    property Data: TStringList read FData write FData;
  end;

  TConfigCollection = class(TOwnedCollection)
  private
    FDelimiter: Char;
    FPieces1,FPieces2,FPieces3: Integer;
    procedure SetValue(Index: Integer; Value: Integer);
    procedure SetItem(Index: Integer; Value: TConfigItem);
    function GetValue(Index: Integer): Integer;
    function GetCount: Integer;
    function GetItem(Index: Integer): TConfigItem; overload;
  public
    procedure GetCollectiveText(var oText: TStringList);
    function Add: TConfigItem; overload;
    function Insert(Index: Integer): TConfigItem;
    function LookUp(p1,p2,p3: string): TConfigItem;
    function ValidPieces(p1,p2,p3: string): Boolean;
    property Pieces[Index: Integer]: Integer read GetValue write SetValue;
    property TotalIDPieces: Integer read GetCount;
    property Delimiter: Char read FDelimiter write FDelimiter default '^';
    property Items[Index: Integer]: TConfigItem read GetItem write SetItem;
  end;

  TDDCSNoteItem = class(TCollectionItem)
  private
    FConfig: TStringList;
    FAccess: string;
    FIDName: string;
    FTitle: string;
    FPrefix: string;
    FSuffix: string;
    FSpace: Boolean;
    FSave: Boolean;
    FRestore: Boolean;
    FHide: Boolean;
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
    procedure GetValueNote(var oText: TStringList);
    procedure GetValueSave(var oText: TStringList);
    function IsValid: Boolean;
    property Page: TTabSheet read GetPage;
    property Configuration: TStringList read FConfig write FConfig;
  published
    property SayOnFocus: string read FAccess write FAccess;
    property Order: Integer read GetOrder write SetIndex;
    property IdentifyingName: string read GetIDName write FIDName;
    property Title: string read FTitle write FTitle;
    property Prefix: string read FPrefix write FPrefix;
    property Suffix: string read FSuffix write FSuffix;
    property DoNotSpace: Boolean read FSpace write FSpace;
    property DoNotSave: Boolean read FSave write FSave;
    property DoNotRestoreV: Boolean read FRestore write FRestore;
    property HideFromNote: Boolean read FHide write FHide;
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
  uBase, frmVitals, uCommon, DDCSUtils, DDCSComBroker;


{$REGION 'TConfigItem'}

// Private ---------------------------------------------------------------------

procedure TConfigItem.SetValue(Index: Integer; Value: string);
begin
  if (Index < 1) or (Index > 3) then
    Exit;

  if Index = 1 then
    FID1 := Value
  else if Index = 2 then
    FID2 := Value
  else if Index = 3 then
    FID3 := Value;
end;

procedure TConfigItem.SetPiece(Index: Integer; Value: string);
var
  sl: TStringList;
begin
  if FData.Count < 1 then
    Exit;

  sl := TStringList.Create;
  try
    sl.Delimiter := TConfigCollection(Collection).Delimiter;
    sl.StrictDelimiter := True;
    sl.DelimitedText := FData[0];

    if ((Index >= 1) and (Index <= sl.Count)) then
    begin
      sl[Index - 1] := Value;
      FData[0] := sl.DelimitedText;
    end;
  finally
    sl.Free;
  end;
end;

function TConfigItem.GetValue(Index: Integer): string;
begin
  Result := '';

  if Index = 1 then
    Result :=  FID1
  else if Index = 2 then
    Result := FID2
  else if Index = 3 then
    Result := FID3;
end;

function TConfigItem.GetPiece(Index: Integer): string;
begin
  Result := '';

  if FData.Count > 0 then
    Result := DDCSUtils.Piece(FData[0], TConfigCollection(Collection).Delimiter, Index);
end;

// Public ----------------------------------------------------------------------

constructor TConfigItem.Create(Collection: TCollection);
begin
  inherited;

  FData := TStringList.Create;
end;

destructor TConfigItem.Destroy;
begin
  FData.Free;

  inherited;
end;

{$ENDREGION}

{$REGION 'TConfigCollection'}

// Private ---------------------------------------------------------------------

procedure TConfigCollection.SetValue(Index: Integer; Value: Integer);
begin
  if (Index < 1) or (Index > 3) then
    Exit;

  if Index = 1 then
    FPieces1 := Value
  else if Index = 2 then
    FPieces2 := Value
  else if Index = 3 then
    FPieces3 := Value;
end;

procedure TConfigCollection.SetItem(Index: Integer; Value: TConfigItem);
begin
  inherited SetItem(Index, Value);
end;

function TConfigCollection.GetValue(Index: Integer): Integer;
begin
  Result := 0;

  if Index = 1 then
    Result := FPieces1
  else if Index = 2 then
    Result := FPieces2
  else if Index = 3 then
    Result := FPieces3;
end;

function TConfigCollection.GetCount: Integer;
var
  I: Integer;
begin
  Result := 0;

  for I := 1 to 3 do
    if Pieces[I] <> 0 then
      Inc(Result);
end;

function TConfigCollection.GetItem(Index: Integer): TConfigItem;
begin
  Result := TConfigItem(inherited Items[Index]);
end;

// Public ----------------------------------------------------------------------

procedure TConfigCollection.GetCollectiveText(var oText: TStringList);
var
  I: Integer;
begin
  oText.Clear;

  for I := 0 to Count - 1 do
    oText.AddStrings(Items[I].Data);
end;

function TConfigCollection.Add: TConfigItem;
begin
  Result := TConfigItem(inherited Add);
end;

function TConfigCollection.Insert(Index: Integer): TConfigItem;
begin
  Result := TConfigItem(inherited Insert(Index));
end;

function TConfigCollection.LookUp(p1,p2,p3: string): TConfigItem;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if ((Items[I].ID[1] = p1) and (Items[I].ID[2] = p2) and (Items[I].ID[3] = p3)) then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TConfigCollection.ValidPieces(p1,p2,p3: string): Boolean;

  function CheckPiece(p: string): Boolean;
  var
    c: Char;
  begin
    Result := False;

    if p = '' then
      Exit;

    if StrToIntDef(p, 0) > 0 then
      Result := True
    else begin
      c := p[1];
      if c.IsLetter then
        Result := True;
    end;
  end;

begin
  Result := True;
  if GetCount < 1 then
    Exit;

  Result := CheckPiece(p1);
  if not Result then
    Exit;

  if GetCount < 2 then
    Exit;

  Result := CheckPiece(p2);
  if not Result then
    Exit;

  if GetCount < 3 then
    Exit;

  Result := CheckPiece(p3);
end;

{$ENDREGION}

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
  Result := FIDName;

  if Result = '' then
    if ((FObject <> nil) and (IsPublishedProp(FObject, 'Caption'))) then
      Result := GetPropValue(FObject, 'Caption');
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
    SayOnFocus         := nItem.SayOnFocus;
    IdentifyingName    := nItem.IdentifyingName;
    Order              := nItem.Order;
    Title              := nItem.Title;
    Prefix             := nItem.Prefix;
    Suffix             := nItem.Suffix;
    DoNotSpace         := nItem.DoNotSpace;
    DoNotSave          := nItem.DoNotSave;
    DoNotRestoreV      := nItem.DoNotRestoreV;
    HideFromNote       := nItem.HideFromNote;
    OwningObject       := nItem.OwningObject;
    Required           := nItem.Required;
    DialogReturn       := nItem.DialogReturn;
  end else inherited;
end;

procedure TDDCSNoteItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
end;

procedure TDDCSNoteItem.GetValueNote(var oText: TStringList);
var
  sl: TStringList;
  I,J: Integer;
  ck: TCheckBox;
  cko: TORCheckBox;
  rb: TRadioButton;
  lb: TCustomListBox;
  lbo: TORListBox;
  lv: TListView;
  lvo: TORListView;
  sg: TStringGrid;
  str: string;
begin
  oText.Clear;

  if FHide then
    Exit;

  if FTitle <> '' then
    oText.Add(FTitle);

  sl := TStringList.Create;
  try
    try
    // TOR ---------------------------------------------------------------------
      if FObject is TORDateBox then
      begin
        if TORDateBox(FObject).IsValid then
          oText.Add(FPrefix + TORDateBox(FObject).Text + FSuffix);
      end
      else if FObject is TORCheckBox then
      begin
        cko := TORCheckBox(FObject);
        if cko.Checked then
        begin
          if cko.Caption <> '' then
            oText.Add(FPrefix + cko.Caption + FSuffix)
          else
            oText.Add(FPrefix + cko.Hint + FSuffix)
        end;
      end
      else if FObject is TORComboBox then
      begin
        if TORComboBox(FObject).Text <> '' then
          oText.Add(FPrefix + TORComboBox(FObject).Text + FSuffix);
      end
      else if FObject is TORListBox then
      begin
        lbo := TORListBox(FObject);
        if lbo.CheckBoxes then
        begin
          for I := 0 to lbo.Count - 1 do
            if lbo.Checked[I] then
              oText.Add(FPrefix + lbo.Items[I] + FSuffix);
        end else
        begin
          for I := 0 to lbo.Count - 1 do
            if lbo.Selected[I] then
              oText.Add(FPrefix + lb.Items[I] + FSuffix);
        end;
      end
      else if FObject is TORListView then
      begin
        lvo := TORListView(FObject);
        // Need to space based on the the length of the values
        if lvo.ViewStyle = vsReport then
          for I := 0 to lvo.Columns.Count - 1 do
            if str <> '' then
              str := str + ' | ' + lvo.Column[I].Caption
            else
              str := lvo.Column[I].Caption;
        oText.Add(str);
        for I := 0 to lvo.Items.Count - 1 do
        begin
          str := lvo.Items.Item[I].Caption;
          for J := 0 to lvo.Items.Item[I].SubItems.Count - 1 do
            str := str + ' | ' + lvo.Items[I].SubItems[J];
          oText.Add(str);
        end;
      end;
    // -------------------------------------------------------------------------
    // Legacy ------------------------------------------------------------------
      // TStaticText is not normally part of the NoteItems but can be manually created
      // and if it is we want to use it but we wouldn't want to normally.
      if FObject is TStaticText then
        oText.Add(FPrefix + TStaticText(FObject).Caption + FSuffix)
      else if FObject.InheritsFrom(TDateTimePicker) then
      begin
        if TDateTimePicker(FObject).Format <> ' ' then
          oText.Add(FPrefix + DateToStr(TDateTimePicker(FObject).DateTime) + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomMemo) then                       // Must come before TCustomEdit
      begin
        for I := 0 to TCustomMemo(FObject).Lines.Count - 1 do
          oText.Add(FPrefix + TCustomMemo(FObject).Lines[I] + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomEdit) then
        oText.Add(FPrefix + TCustomEdit(FObject).Text + FSuffix)
      else if FObject.InheritsFrom(TCheckBox) then
      begin
        ck := TCheckBox(FObject);
        if ck.Checked then
        begin
          if ck.Caption <> '' then
            oText.Add(FPrefix + ck.Caption + FSuffix)
          else
            oText.Add(FPrefix + ck.Hint + FSuffix)
        end;
      end
      else if FObject.InheritsFrom(TRadioButton) then
      begin
        rb := TRadioButton(FObject);
        if rb.Checked then
        begin
          if rb.Caption <> '' then
            oText.Add(FPrefix + rb.Caption + FSuffix)
          else
            oText.Add(FPrefix + rb.Hint + FSuffix)
        end;
      end
      else if FObject.InheritsFrom(TRadioGroup) then
      begin
        if TRadioGroup(FObject).ItemIndex <> -1 then
          oText.Add(FPrefix + TRadioGroup(FObject).Items.Strings[TRadioGroup(FObject).ItemIndex] + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomComboBox) then
      begin
        if FObject.InheritsFrom(TComboBox) then
        begin
          if TComboBox(FObject).Text <> '' then
            oText.Add(FPrefix + TComboBox(FObject).Text + FSuffix);
        end else
        if TCustomComboBox(FObject).ItemIndex <> -1 then
          oText.Add(FPrefix + TCustomComboBox(FObject).Items[TCustomComboBox(FObject).ItemIndex] + FSuffix);
      end
      else if FObject.InheritsFrom(TCustomListBox) then
      begin
        lb := TCustomListBox(FObject);
        if FObject.InheritsFrom(TCheckListBox) then
        begin
          for I := 0 to TCheckListBox(FObject).Count - 1 do
            if TCheckListBox(FObject).Checked[I] then
              oText.Add(FPrefix + TCheckListBox(FObject).Items[I] + FSuffix);
        end else
        begin
          for I := 0 to lb.Count - 1 do
            if lb.Selected[I] then
              oText.Add(FPrefix + lb.Items[I] + FSuffix);
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
        oText.Add(str);
        for I := 0 to lv.Items.Count - 1 do
        begin
          str := lv.Items.Item[I].Caption;
          for J := 0 to lv.Items.Item[I].SubItems.Count - 1 do
            str := str + ' | ' + lv.Items[I].SubItems[J];
          oText.Add(str);
        end;
      end
      else if FObject.InheritsFrom(TStringGrid) then
      begin
        sg := TStringGrid(FObject);
        for I := 0 to sg.RowCount - 1 do
          for J := 0 to sg.ColCount - 1 do
            oText.Add(FPrefix + sg.Cells[J,I] + FSuffix)
      end
      else if FObject is TDDCSVitals then
      begin
        TDDCSVitals(FObject).GetCompleteNote(sl);
        if sl.Count > 0 then
          oText.AddStrings(sl);
      end;
    // -------------------------------------------------------------------------
    except
    end;
  finally
    sl.Free;

    if ((oText.Count > 0) and (not FSpace)) then
      oText.Add('');
  end;
end;

procedure TDDCSNoteItem.GetValueSave(var oText: TStringList);
var
  ck: TCheckBox;
  cko: TORCheckBox;
  rb: TRadioButton;
  rg: TRadioGroup;
  cb: TCustomComboBox;
  lb: TCustomListBox;
  lbo: TORListBox;
  clb: TCheckListBox;
  lv: TListView;
  lvo: TORListView;
  sg: TStringGrid;
  I,J: Integer;
  str: string;
begin
  oText.Clear;

  try
    try
    // TOR ---------------------------------------------------------------------
      if FObject is TORDateBox then
      begin
        if TORDateBox(FObject).IsValid then
          oText.Add(FObject.Name + '^^' + FloatToStr(TORDateBox(FObject).FMDateTime));
      end
      else if FObject is TORCheckBox then
      begin
        if cko.Caption <> '' then
        begin
          if cko.Checked then
            oText.Add(FObject.Name + '^TRUE^' + cko.Caption)
          else
            oText.Add(FObject.Name + '^^' + cko.Caption)
        end else if cko.Hint <> '' then
        begin
          if cko.Checked then
            oText.Add(FObject.Name + '^TRUE^' + cko.Hint)
          else
            oText.Add(FObject.Name + '^^' + cko.Hint);
        end;
      end
      else if FObject is TORComboBox then
      begin
        if TORComboBox(FObject).Text <> '' then
          oText.Add(FObject.Name + '^^' + TORComboBox(FObject).Text);
      end
      else if FObject is TORListBox then
      begin
        lbo := TORListBox(FObject);
        if lbo.CheckBoxes then
        begin
          for I := 0 to lbo.Count - 1 do
          begin
            if lbo.Checked[I] then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lbo.Items[I])
            else
              oText.Add(FObject.Name + '^^' + lbo.Items[I]);
          end;
        end else
        begin
          for I := 0 to lbo.Count - 1 do
          begin
            if lbo.Selected[I] then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lbo.Items[I])
            else
              oText.Add(FObject.Name + U + IntToStr(I) + U + lbo.Items[I]);
          end;
        end;
      end
      else if FObject is TORListView then
      begin
        lvo := TORListView(FObject);
        // Need to space based on the the length of the values
        if lvo.ViewStyle = vsReport then
          for I := 0 to lvo.Columns.Count - 1 do
            if str <> '' then
              str := str + U + lvo.Column[I].Caption
            else
              str := lvo.Column[I].Caption;
        oText.Add(FObject.Name + '^H^' + str);
        for I := 0 to lvo.Items.Count - 1 do
        begin
          str := lvo.Items.Item[I].Caption;
          for J := 0 to lvo.Items.Item[I].SubItems.Count - 1 do
            str := str + U + lvo.Items[I].SubItems[J];
          if lvo.Checkboxes then
          begin
            if lvo.Items.Item[I].Checked then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE' + U + str)
            else
              oText.Add(FObject.Name + U + IntToStr(I) + U + str);
          end else
          begin
            if lvo.Items.Item[I].Selected then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE' + U + str)
            else
              oText.Add(FObject.Name + U + IntToStr(I) + U + str);
          end;
        end;
      end;
    // -------------------------------------------------------------------------
    // Legacy ------------------------------------------------------------------
      // TStaticText is not normally part of the NoteItems but can be manually created
      // and if it is we want to use it but we wouldn't want to normally.
      if FObject is TStaticText then
        oText.Add(FObject.Name + '^^' + TStaticText(FObject).Caption)
      else if FObject.InheritsFrom(TDateTimePicker) then
      begin
        if TDateTimePicker(FObject).Format <> ' ' then
          oText.Add(FObject.Name + '^^' + DateToStr(TDateTimePicker(FObject).DateTime));
      end
      else if FObject.InheritsFrom(TCustomMemo) then                          // Must come before TCustomEdit
      begin
        for I := 0 to TCustomMemo(FObject).Lines.Count - 1 do
          oText.Add(FObject.Name + '^^' + TCustomMemo(FObject).Lines[I]);
      end
      else if FObject.InheritsFrom(TCustomEdit) then
        oText.Add(FObject.Name + '^^' + TCustomEdit(FObject).Text)
      else if FObject.InheritsFrom(TCheckBox) then
      begin
        ck := TCheckBox(FObject);
        if ck.Caption <> '' then
        begin
          if ck.Checked then
            oText.Add(FObject.Name + '^TRUE^' + ck.Caption)
          else
            oText.Add(FObject.Name + '^^' + ck.Caption)
        end else if ck.Hint <> '' then
        begin
          if ck.Checked then
            oText.Add(FObject.Name + '^TRUE^' + ck.Hint)
          else
            oText.Add(FObject.Name + '^^' + ck.Hint);
        end;
      end
      else if FObject.InheritsFrom(TRadioButton) then
      begin
        rb := TRadioButton(FObject);
        if rb.Caption <> '' then
        begin
          if rb.Checked then
            oText.Add(FObject.Name + '^TRUE^' + rb.Caption)
          else
            oText.Add(FObject.Name + '^^' + rb.Caption)
        end else if rb.Hint <> '' then
        begin
          if rb.Checked then
            oText.Add(FObject.Name + '^TRUE^' + rb.Hint)
          else
            oText.Add(FObject.Name + '^^' + rb.Hint);
        end;
      end
      else if FObject.InheritsFrom(TRadioGroup) then
      begin
        rg := TRadioGroup(FObject);
        if rg.ItemIndex <> -1 then
          oText.Add(FObject.Name + U + IntToStr(rg.ItemIndex) + U + rg.Items.Strings[rg.ItemIndex]);
      end
      else if FObject.InheritsFrom(TCustomComboBox) then
      begin
        if FObject.InheritsFrom(TComboBox) then
        begin
          if TComboBox(FObject).Text <> '' then
            oText.Add(FObject.Name + '^^' + TComboBox(FObject).Text);
        end else if TCustomComboBox(FObject).ItemIndex <> -1 then
        begin
          cb := TCustomComboBox(FObject);
          oText.Add(FObject.Name + U + IntToStr(cb.ItemIndex) + 'TRUE^' + cb.Items[cb.ItemIndex])
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
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + clb.Items[I])
            else
              oText.Add(FObject.Name + '^^' + clb.Items[I]);
          end;
        end else
        begin
          lb := TCustomListBox(FObject);
          for I := 0 to lb.Count - 1 do
          begin
            if lb.Selected[I] then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lb.Items[I])
            else
              oText.Add(FObject.Name + U + IntToStr(I) + U + lb.Items[I]);
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
              str := str + U + lv.Column[I].Caption
            else
              str := lv.Column[I].Caption;
        oText.Add(FObject.Name + '^H^' + str);
        for I := 0 to lv.Items.Count - 1 do
        begin
          str := lv.Items.Item[I].Caption;
          for J := 0 to lv.Items.Item[I].SubItems.Count - 1 do
            str := str + U + lv.Items[I].SubItems[J];
          if lv.Checkboxes then
          begin
            if lv.Items.Item[I].Checked then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE' + U + str)
            else
              oText.Add(FObject.Name + U + IntToStr(I) + U + str);
          end else
          begin
            if lv.Items.Item[I].Selected then
              oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE' + U + str)
            else
              oText.Add(FObject.Name + U + IntToStr(I) + U + str);
          end;
        end;
      end
      else if FObject.InheritsFrom(TStringGrid) then
      begin
        sg := TStringGrid(FObject);
        for I := 0 to sg.RowCount - 1 do
          if I > (sg.FixedRows - 1) then
            for J := 0 to sg.ColCount - 1 do
              oText.Add(FObject.Name + U + IntToStr(J) + ',' + IntToStr(I) + U + sg.Cells[J,I])
      end;
    // -------------------------------------------------------------------------
    except
    end;
  finally
  end;
end;

function TDDCSNoteItem.IsValid: Boolean;
var
  I: Integer;
  lb: TCustomListBox;
  lbo: TORListBox;
begin
  Result := True;

  if not FRequired then
    Exit;

  try
    // TOR ---------------------------------------------------------------------
      if FObject is TORDateBox then
        Result := TORDateBox(FObject).IsValid
      else if FObject is TORCheckBox then
        Result := TORCheckBox(FObject).Checked
      else if FObject is TORComboBox then
        Result := not (TORComboBox(FObject).Text = '')
      else if FObject is TORListBox then
      begin
        Result := False;
        lbo := TORListBox(FObject);
        if lbo.CheckBoxes then
        begin
          for I := 0 to lbo.Count - 1 do
          begin
            if lbo.Checked[I] then
            begin
              Result := True;
              Break;
            end;
          end;
        end else
        begin
          for I := 0 to lbo.Count - 1 do
          begin
            if lbo.Selected[I] then
            begin
              Result := True;
              Break;
            end;
          end;
        end;
      end;
    // -------------------------------------------------------------------------
    // Legacy ------------------------------------------------------------------
      // TStaticText is not normally part of the NoteItems but can be manually created
      // and if it is we want to use it but we wouldn't want to normally.
      if FObject is TStaticText then
        Result := not (TStaticText(FObject).Caption = '')
      else if FObject.InheritsFrom(TDateTimePicker) then
        Result := not (TDateTimePicker(FObject).Format = ' ')
      else if FObject.InheritsFrom(TCustomMemo) then          // Must come before TCustomEdit
        Result := not (TCustomMemo(FObject).Lines.Count < 1)
      else if FObject.InheritsFrom(TCustomEdit) then
        Result := not (TCustomEdit(FObject).Text = '')
      else if FObject.InheritsFrom(TCheckBox) then
        Result := TCheckBox(FObject).Checked
      else if FObject.InheritsFrom(TRadioButton) then
        Result := TRadioButton(FObject).Checked
      else if FObject.InheritsFrom(TRadioGroup) then
        Result := not (TRadioGroup(FObject).ItemIndex = -1)
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
    // -------------------------------------------------------------------------
    if FObject is TDDCSVitals then
      Result := (TDDCSVitals(FObject).ValidateMsg = '');
  except
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
