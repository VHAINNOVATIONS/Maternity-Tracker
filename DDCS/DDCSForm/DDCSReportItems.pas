unit DDCSReportItems;

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
  Vcl.Grids, Vcl.CheckLst, ORCtrls, ORDtTm, DDCSGrid;

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
    function GetIdentifyingName: string;
    function GetTitle: string;
    function GetSuffix: string;
    function GetObject: TWinControl;
    function GetDisplayName: string; override;
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
    function GetQuestion: TQuestion;
    property Page: TTabSheet read GetPage;
    property Configuration: TStringList read FConfig write FConfig;
  published
    property SayOnFocus: string read FAccess write FAccess;
    property Order: Integer read GetOrder write SetIndex;
    property IdentifyingName: string read GetIdentifyingName write FIDName;
    property Title: string read GetTitle write FTitle;
    property Prefix: string read FPrefix write FPrefix;
    property Suffix: string read GetSuffix write FSuffix;
    property DoNotSpace: Boolean read FSpace write FSpace;
    property DoNotSave: Boolean read FSave write FSave;
    property DoNotRestoreV: Boolean read FRestore write FRestore;
    property HideFromNote: Boolean read FHide write FHide;
    property OwningObject: TWinControl read GetObject write SetObject;
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
  DDCSForm, DDCSVitals, DDCSCommon, DDCSUtils, DDCSComBroker;

{$REGION 'TConfigItem'}

procedure TConfigItem.SetValue(Index: Integer; Value: string);
begin
  if (Index < 1) or (Index > 3) then
    Exit;

  if Index = 1 then
    FID1 := Value
  else
  if Index = 2 then
    FID2 := Value
  else
  if Index = 3 then
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
  else
  if Index = 2 then
    Result := FID2
  else
  if Index = 3 then
    Result := FID3;
end;

function TConfigItem.GetPiece(Index: Integer): string;
begin
  Result := '';

  if FData.Count > 0 then
    Result := DDCSUtils.Piece(FData[0], TConfigCollection(Collection).Delimiter, Index);
end;

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

procedure TConfigCollection.SetValue(Index: Integer; Value: Integer);
begin
  if (Index < 1) or (Index > 3) then
    Exit;

  if Index = 1 then
    FPieces1 := Value
  else
  if Index = 2 then
    FPieces2 := Value
  else
  if Index = 3 then
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
  else
  if Index = 2 then
    Result := FPieces2
  else
  if Index = 3 then
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
    else
    begin
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

function TDDCSNoteItem.GetIdentifyingName: string;
var
  qQuestion: TQuestion;
begin
  Result := FIDName;

  if Result <> '' then
    Exit;

  try
    qQuestion := GetQuestion;
    if qQuestion <> nil then
      Result := qQuestion.Question;

    if Result = '' then
      if ((FObject <> nil) and (IsPublishedProp(FObject, 'Caption'))) then
        Result := GetPropValue(FObject, 'Caption');
  except
  end;
end;

function TDDCSNoteItem.GetTitle: string;
var
  qQuestion: TQuestion;
begin
  Result := FTitle;

  if Result <> '' then
    Exit;

  try
    qQuestion := GetQuestion;
    if qQuestion <> nil then
      Result := qQuestion.Question;
  except
  end;
end;

function TDDCSNoteItem.GetSuffix: string;
var
  dForm: TDDCSForm;
  qQuestion: TQuestion;
begin
  Result := FSuffix;
  try
    if TDDCSNoteCollection(Collection).Owner is TDDCSForm then
    begin
      dForm := TDDCSForm(TDDCSNoteCollection(Collection).Owner);
      if dForm.IsGrided then
      begin
        qQuestion := dForm.GetQuestion(OwningObject);
        if qQuestion <> nil then
        begin
          if qQuestion.IsUnknown then
          begin
            Result := '';
            Exit;
          end;
          if (qQuestion.IsAvailable and (qQuestion.AssociatedControl <> nil)) then
            Result := ' ' + dForm.GetQuestion(qQuestion.AssociatedControl.Name).Answer;
        end;
      end;
    end;
  except
  end;
end;

function TDDCSNoteItem.GetObject: TWinControl;
begin
  Result := nil;
  try
    Result := FObject;
  except
  end;
end;

function TDDCSNoteItem.GetDisplayName: string;
begin
  Result := ClassName;

  if FObject <> nil then
    Result := FObject.Name;
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

  try
    if FObject = nil then
      Exit;

    wControl := OwningObject;
    if wControl.Parent = nil then
     Exit;

    repeat
      wControl := wControl.Parent;
    until ((wControl is TTabSheet) and (wControl.Parent is TDDCSForm)) or (wControl.Parent = nil);

    if ((wControl is TTabSheet) and (wControl.Parent is TDDCSForm)) then
      Result := TTabSheet(wControl);
  except
  end;
end;

constructor TDDCSNoteItem.Create(Collection: TCollection);
begin
  inherited;

  FConfig := TStringList.Create;
  FObject := nil;
  FReturn := nil;
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
    SayOnFocus := nItem.SayOnFocus;
    IdentifyingName := nItem.IdentifyingName;
    Order := nItem.Order;
    Title := nItem.Title;
    Prefix := nItem.Prefix;
    Suffix := nItem.Suffix;
    DoNotSpace := nItem.DoNotSpace;
    DoNotSave := nItem.DoNotSave;
    DoNotRestoreV := nItem.DoNotRestoreV;
    HideFromNote := nItem.HideFromNote;
    OwningObject := nItem.OwningObject;
    Required := nItem.Required;
    DialogReturn := nItem.DialogReturn;
  end
  else
    inherited;
end;

procedure TDDCSNoteItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
end;

procedure TDDCSNoteItem.GetValueNote(var oText: TStringList);
var
  qQuestion: TQuestion;
  sl: TStringList;
  I,J: Integer;
  str: string;
  ck: TCheckBox;
  cko: TORCheckBox;
  rb: TRadioButton;
  lb: TCustomListBox;
  lbo: TORListBox;
  lv: TListView;
  lvo: TORListView;
  sg: TStringGrid;
begin
  oText.Clear;

  if HideFromNote then
    Exit;

  qQuestion := GetQuestion;
  if qQuestion <> nil then
    if qQuestion.IsAssociatedControl then
      Exit;

  if Title <> '' then
    oText.Add(Title);

  sl := TStringList.Create;
  try
    try
      if qQuestion <> nil then
      begin
        if not qQuestion.IsAvailable then
        begin
          oText.Add(Prefix + 'N/A');
          Exit;
        end;
        if qQuestion.IsUnknown then
        begin
          oText.Add(Prefix + 'Unknown');
          Exit;
        end;
      end;

      // TOR -------------------------------------------------------------------
      if FObject is TORDateBox then
      begin
        if TORDateBox(FObject).IsValid then
          oText.Add(Prefix + TORDateBox(FObject).Text + Suffix);
        Exit;
      end
      else
      if FObject is TORCheckBox then
      begin
        cko := TORCheckBox(FObject);
        if cko.Checked then
        begin
          if cko.Caption <> '' then
            oText.Add(Prefix + cko.Caption + Suffix)
          else
            oText.Add(Prefix + cko.Hint + Suffix)
        end;
        Exit;
      end
      else
      if FObject is TORComboBox then
      begin
        if TORComboBox(FObject).Text <> '' then
          oText.Add(Prefix + TORComboBox(FObject).Text + Suffix);
        Exit;
      end
      else
      if FObject is TORListBox then
      begin
        lbo := TORListBox(FObject);
        if lbo.CheckBoxes then
        begin
          for I := 0 to lbo.Count - 1 do
            if lbo.Checked[I] then
              oText.Add(Prefix + lbo.Items[I] + Suffix);
        end
        else
        begin
          for I := 0 to lbo.Count - 1 do
            if lbo.Selected[I] then
              oText.Add(Prefix + lb.Items[I] + Suffix);
        end;
        Exit;
      end
      else
      if FObject is TORListView then
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
        Exit;
      end;
      // -----------------------------------------------------------------------
      // Legacy ----------------------------------------------------------------
      //   TStaticText is not normally part of the NoteItems but can be manually created
      //   and if it is we want to use it but we wouldn't want to normally.
      if FObject is TStaticText then
      begin
        oText.Add(Prefix + TStaticText(FObject).Caption + Suffix);
        Exit;
      end
      else
      if FObject.InheritsFrom(TDateTimePicker) then
      begin
        if TDateTimePicker(FObject).Format <> ' ' then
          oText.Add(Prefix + DateToStr(TDateTimePicker(FObject).DateTime) + Suffix);
        Exit;
      end
      else
      if FObject.InheritsFrom(TCustomMemo) then       // Must come before TCustomEdit
      begin
        for I := 0 to TCustomMemo(FObject).Lines.Count - 1 do
          oText.Add(Prefix + TCustomMemo(FObject).Lines[I] + Suffix);
        Exit;
      end
      else
      if FObject.InheritsFrom(TCustomEdit) then
      begin
        oText.Add(Prefix + TCustomEdit(FObject).Text + Suffix);
        Exit;
      end
      else
      if FObject.InheritsFrom(TCheckBox) then
      begin
        ck := TCheckBox(FObject);
        if ck.Checked then
        begin
          if ck.Caption <> '' then
            oText.Add(Prefix + ck.Caption + Suffix)
          else
            oText.Add(Prefix + ck.Hint + Suffix);
        end;
        Exit;
      end
      else
      if FObject.InheritsFrom(TRadioButton) then
      begin
        rb := TRadioButton(FObject);
        if rb.Checked then
        begin
          if rb.Caption <> '' then
            oText.Add(Prefix + rb.Caption + Suffix)
          else
            oText.Add(Prefix + rb.Hint + Suffix);
        end;
        Exit;
      end
      else
      if FObject.InheritsFrom(TRadioGroup) then
      begin
        if TRadioGroup(FObject).ItemIndex <> -1 then
          oText.Add(Prefix + TRadioGroup(FObject).Items.Strings[TRadioGroup(FObject).ItemIndex] + Suffix);
        Exit;
      end
      else
      if FObject.InheritsFrom(TCustomComboBox) then
      begin
        if FObject.InheritsFrom(TComboBox) then
        begin
          if TComboBox(FObject).Text <> '' then
            oText.Add(Prefix + TComboBox(FObject).Text + Suffix);
        end
        else
        if TCustomComboBox(FObject).ItemIndex <> -1 then
          oText.Add(Prefix + TCustomComboBox(FObject).Items[TCustomComboBox(FObject).ItemIndex] + Suffix);
        Exit;
      end
      else
      if FObject.InheritsFrom(TCustomListBox) then
      begin
        lb := TCustomListBox(FObject);
        if FObject.InheritsFrom(TCheckListBox) then
        begin
          for I := 0 to TCheckListBox(FObject).Count - 1 do
            if TCheckListBox(FObject).Checked[I] then
              oText.Add(Prefix + TCheckListBox(FObject).Items[I] + Suffix);
        end
        else
        begin
          for I := 0 to lb.Count - 1 do
            if lb.Selected[I] then
              oText.Add(Prefix + lb.Items[I] + Suffix);
        end;
        Exit;
      end
      else
      if FObject.InheritsFrom(TListView) then
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
        Exit;
      end
      else
      if FObject.InheritsFrom(TStringGrid) then
      begin
        sg := TStringGrid(FObject);
        for I := 0 to sg.RowCount - 1 do
          for J := 0 to sg.ColCount - 1 do
            oText.Add(Prefix + sg.Cells[J,I] + Suffix);
        Exit;
      end
      else
      if FObject is TDDCSVitalsForm then
      begin
        TDDCSVitalsForm(FObject).GetCompleteNote(sl);
        if sl.Count > 0 then
          oText.AddStrings(sl);
        Exit;
      end;
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
  qQuestion: TQuestion;
  I,J: Integer;
  str: string;
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
begin
  oText.Clear;

  try
    qQuestion := GetQuestion;
    if qQuestion <> nil then
    begin
      if not qQuestion.IsAvailable then
      begin
        oText.Add(FObject.Name + '^^');
        Exit;
      end;
      if qQuestion.IsUnknown then
      begin
        oText.Add(FObject.Name + '^^Unknown');
        Exit;
      end;
    end;

    // TOR -------------------------------------------------------------------
    if FObject is TORDateBox then
    begin
      if TORDateBox(FObject).IsValid then
        oText.Add(FObject.Name + '^^' + FloatToStr(TORDateBox(FObject).FMDateTime));
      Exit;
    end
    else
    if FObject is TORCheckBox then
    begin
      if cko.Caption <> '' then
      begin
        if cko.Checked then
          oText.Add(FObject.Name + '^TRUE^' + cko.Caption)
        else
          oText.Add(FObject.Name + '^^' + cko.Caption)
      end
      else
      if cko.Hint <> '' then
      begin
        if cko.Checked then
          oText.Add(FObject.Name + '^TRUE^' + cko.Hint)
        else
          oText.Add(FObject.Name + '^^' + cko.Hint);
      end;
      Exit;
    end
    else
    if FObject is TORComboBox then
    begin
      if TORComboBox(FObject).Text <> '' then
        oText.Add(FObject.Name + '^^' + TORComboBox(FObject).Text);
      Exit;
    end
    else
    if FObject is TORListBox then
    begin
      lbo := TORListBox(FObject);
      if lbo.CheckBoxes then
      begin
        for I := 0 to lbo.Count - 1 do
        begin
          if lbo.Checked[I] then
            oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lbo.Items[I]);
//            else
//              oText.Add(FObject.Name + '^^' + lbo.Items[I]);
        end;
      end
      else
      begin
        for I := 0 to lbo.Count - 1 do
        begin
          if lbo.Selected[I] then
            oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lbo.Items[I]);
//            else
//              oText.Add(FObject.Name + U + IntToStr(I) + U + lbo.Items[I]);
        end;
      end;
      Exit;
    end
    else
    if FObject is TORListView then
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
        end
        else
        begin
          if lvo.Items.Item[I].Selected then
            oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE' + U + str)
          else
            oText.Add(FObject.Name + U + IntToStr(I) + U + str);
        end;
      end;
      Exit;
    end;
    // -----------------------------------------------------------------------
    // Legacy ----------------------------------------------------------------
    //   TStaticText is not normally part of the NoteItems but can be manually created
    //   and if it is we want to use it but we wouldn't want to normally.
    if FObject is TStaticText then
    begin
      oText.Add(FObject.Name + '^^' + TStaticText(FObject).Caption);
      Exit;
    end
    else
    if FObject.InheritsFrom(TDateTimePicker) then
    begin
      if TDateTimePicker(FObject).Format <> ' ' then
        oText.Add(FObject.Name + '^^' + DateToStr(TDateTimePicker(FObject).DateTime));
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomMemo) then    // Must come before TCustomEdit
    begin
      for I := 0 to TCustomMemo(FObject).Lines.Count - 1 do
        oText.Add(FObject.Name + '^^' + TCustomMemo(FObject).Lines[I]);
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomEdit) then
    begin
      oText.Add(FObject.Name + '^^' + TCustomEdit(FObject).Text);
      Exit;
    end
    else
    if FObject.InheritsFrom(TCheckBox) then
    begin
      ck := TCheckBox(FObject);
      if ck.Caption <> '' then
      begin
        if ck.Checked then
          oText.Add(FObject.Name + '^TRUE^' + ck.Caption)
        else
          oText.Add(FObject.Name + '^^' + ck.Caption);
      end
      else
      if ck.Hint <> '' then
      begin
        if ck.Checked then
          oText.Add(FObject.Name + '^TRUE^' + ck.Hint)
        else
          oText.Add(FObject.Name + '^^' + ck.Hint);
      end;
      Exit;
    end
    else
    if FObject.InheritsFrom(TRadioButton) then
    begin
      rb := TRadioButton(FObject);
      if rb.Caption <> '' then
      begin
        if rb.Checked then
          oText.Add(FObject.Name + '^TRUE^' + rb.Caption)
        else
          oText.Add(FObject.Name + '^^' + rb.Caption);
      end
      else
      if rb.Hint <> '' then
      begin
        if rb.Checked then
          oText.Add(FObject.Name + '^TRUE^' + rb.Hint)
        else
          oText.Add(FObject.Name + '^^' + rb.Hint);
      end;
      Exit;
    end
    else
    if FObject.InheritsFrom(TRadioGroup) then
    begin
      rg := TRadioGroup(FObject);
      if rg.ItemIndex <> -1 then
        oText.Add(FObject.Name + U + IntToStr(rg.ItemIndex) + U + rg.Items.Strings[rg.ItemIndex]);
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomComboBox) then
    begin
      if FObject.InheritsFrom(TComboBox) then
      begin
        if TComboBox(FObject).Text <> '' then
          oText.Add(FObject.Name + '^^' + TComboBox(FObject).Text);
      end
      else
      if TCustomComboBox(FObject).ItemIndex <> -1 then
      begin
        cb := TCustomComboBox(FObject);
        oText.Add(FObject.Name + U + IntToStr(cb.ItemIndex) + 'TRUE^' + cb.Items[cb.ItemIndex]);
      end;
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomListBox) then
    begin
      if FObject.InheritsFrom(TCheckListBox) then
      begin
        clb := TCheckListBox(FObject);
        for I := 0 to clb.Count - 1 do
        begin
          if clb.Checked[I] then
            oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + clb.Items[I]);
//            else
//              oText.Add(FObject.Name + '^^' + clb.Items[I]);
        end;
      end
      else
      begin
        lb := TCustomListBox(FObject);
        for I := 0 to lb.Count - 1 do
        begin
          if lb.Selected[I] then
            oText.Add(FObject.Name + U + IntToStr(I) + 'TRUE^' + lb.Items[I]);
//            else
//              oText.Add(FObject.Name + U + IntToStr(I) + U + lb.Items[I]);
        end;
      end;
      Exit;
    end
    else
    if FObject.InheritsFrom(TListView) then
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
      Exit;
    end
    else
    if FObject.InheritsFrom(TStringGrid) then
    begin
      sg := TStringGrid(FObject);
      for I := 0 to sg.RowCount - 1 do
        if I > (sg.FixedRows - 1) then
          for J := 0 to sg.ColCount - 1 do
            oText.Add(FObject.Name + U + IntToStr(J) + ',' + IntToStr(I) + U + sg.Cells[J,I]);
      Exit;
    end;
  except
  end;
end;

function TDDCSNoteItem.IsValid: Boolean;
var
  qQuestion: TQuestion;
  I: Integer;
  lb: TCustomListBox;
  lbo: TORListBox;
begin
  Result := True;

  try
    qQuestion := GetQuestion;
    if qQuestion <> nil then
    begin
      // If the question is available meaning that the NA has not been checked and
      // the answer is null then we failed.
      if ((Length(qQuestion.Answer) = 0) and (qQuestion.IsAvailable)) then
        Result := False;
      Exit;
    end;

    if not FRequired then
      Exit;

    // TOR ---------------------------------------------------------------------
    if FObject is TORDateBox then
    begin
      Result := TORDateBox(FObject).IsValid;
      Exit;
    end
    else
    if FObject is TORCheckBox then
    begin
      Result := TORCheckBox(FObject).Checked;
      Exit;
    end
    else
    if FObject is TORComboBox then
    begin
      Result := not (TORComboBox(FObject).Text = '');
      Exit;
    end
    else
    if FObject is TORListBox then
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
      Exit;
    end;
    // -------------------------------------------------------------------------
    // Legacy ------------------------------------------------------------------
    //   TStaticText is not normally part of the NoteItems but can be manually created
    //   and if it is we want to use it but we wouldn't want to normally.
    if FObject is TStaticText then
    begin
      Result := not (TStaticText(FObject).Caption = '');
      Exit;
    end
    else
    if FObject.InheritsFrom(TDateTimePicker) then
    begin
      Result := not (TDateTimePicker(FObject).Format = ' ');
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomMemo) then        // Must come before TCustomEdit
    begin
      Result := not (TCustomMemo(FObject).Lines.Count < 1);
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomEdit) then
    begin
      Result := not (TCustomEdit(FObject).Text = '');
      Exit;
    end
    else
    if FObject.InheritsFrom(TCheckBox) then
    begin
      Result := TCheckBox(FObject).Checked;
      Exit;
    end
    else
    if FObject.InheritsFrom(TRadioButton) then
    begin
      Result := TRadioButton(FObject).Checked;
      Exit;
    end
    else
    if FObject.InheritsFrom(TRadioGroup) then
    begin
      Result := not (TRadioGroup(FObject).ItemIndex = -1);
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomComboBox) then
    begin
      if TCustomComboBox(FObject).ItemIndex = -1 then
      begin
        if FObject.InheritsFrom(TComboBox) then
        begin
          Result := False;
          if ((TComboBox(FObject).Style = csDropDown) and (TComboBox(FObject).Text <> '')) then
            Result := True;
        end
        else
          Result := False;
      end;
      Exit;
    end
    else
    if FObject.InheritsFrom(TCustomListBox) then
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
      end
      else
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
      Exit;
    end;
    if FObject is TDDCSVitalsForm then
    begin
      Result := (TDDCSVitalsForm(FObject).ValidateMsg = '');
      Exit;
    end;
  except
  end;
end;

function TDDCSNoteItem.GetQuestion: TQuestion;
var
  dForm: TDDCSForm;
  qQuestion: TQuestion;
begin
  Result := nil;
  try
    if TDDCSNoteCollection(Collection).Owner is TDDCSForm then
    begin
      dForm := TDDCSForm(TDDCSNoteCollection(Collection).Owner);
      if dForm.IsGrided then
      begin
        qQuestion := dForm.GetQuestion(OwningObject);
        if qQuestion <> nil then
          Result := qQuestion;
      end;
    end;
  except
  end;
end;

{$ENDREGION}

{$REGION 'TDDCSNoteCollection'}

procedure TDDCSNoteCollection.SetItem(Index: Integer; Value: TDDCSNoteItem);
begin
  inherited SetItem(Index, Value);
end;

function TDDCSNoteCollection.GetItem(Index: Integer): TDDCSNoteItem;
begin
  Result := TDDCSNoteItem(inherited Items[Index]);
end;

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
      Break;
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
        Break;
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
