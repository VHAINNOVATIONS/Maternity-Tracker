unit DDCSGrid;

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

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, System.TypInfo, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.Samples.Spin, Vcl.ActnList, Vcl.Menus, Vcl.CheckLst, Vcl.Mask,
  JvStringGrid, JvExControls, JvExGrids, JvExMask, JvSpin, DDCSCommon;

type
  TQuestion = class(TCollectionItem)
  private
    FID: string;
    FName: string;
    FPossibleAnswers: TStringList;
    FDefaultAnswers: TStringList;
    FRow: Integer;
    FControl: TWinControl;
    FAssociated: TWinControl;
    procedure SetQuestion(Value: string);
    procedure SetAssociated(Value: TWinControl);
    procedure SetAnswer(Value: string);
    function GetQuestion: string;
    function GetAnswer: string;
    function GetIsAssociated: Boolean;
    function GetTotalPossible: Integer;
    function GetIsUnknown: Boolean;
    function GetIsAvailable: Boolean;
  protected
    procedure TComboBoxOnChange(Sender: TObject);
    procedure TORDateBoxOnChange(Sender: TObject);
    procedure TEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure TSpinEditOnChange(Sender: TObject);
    procedure TCheckListBoxOnClickCheck(Sender: TObject);
    function CreateCheckBoxforCell(AOwner: TComponent): TCheckBox;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure GetPossibleAnswers(var Value: TStringList);
    procedure AddPossibleAnswer(Value: string);
    procedure AddDefaultAnswer(Value: string);
    procedure CreateControl(sName,sClass,sValidate,sProperties: string);
    property ID: string read FID write FID;
    property Name: string read FName write FName;
    property Question: string read GetQuestion write SetQuestion;
    property Answer: string read GetAnswer write SetAnswer;
    property Row: Integer read FRow;
    property Control: TWinControl read FControl;
    property IsAssociatedControl: Boolean read GetIsAssociated;
    property AssociatedControl: TWinControl read FAssociated write SetAssociated;
    property TotalPossibleAnswers: Integer read GetTotalPossible;
    property IsUnknown: Boolean read GetIsUnknown;
    property IsAvailable: Boolean read GetIsAvailable;
  end;

  TDDCSQuestionGrid = class;

  TQuestionCollection = class(TOwnedCollection)
  private
    FGrid: TJvStringGrid;
    procedure SetItem(Index: Integer; Value: TQuestion);
    function GetItem(Index: Integer): TQuestion; overload;
  public
    procedure DeleteQuestion(sName: string);
    procedure UpdateQuestionControls;
    function GetQuestionAddifNil(sName: string): TQuestion;
    function GetQuestion(sName: string): TQuestion; overload;
    function GetQuestion(iRow: Integer): TQuestion; overload;
    function GetQuestion(wControl: TWinControl): TQuestion; overload;
    function Add: TQuestion; overload;
    function Insert(Index: Integer): TQuestion;
    property Grid: TJvStringGrid read FGrid;
    property Items[Index: Integer]: TQuestion read GetItem write SetItem;
  end;

  TDDCSQuestionGrid = class(TFrame)
    StringGrid: TJvStringGrid;
    pnlKey: TPanel;
    procedure FrameResize(Sender: TObject);
    procedure StringGridColWidthsChanged(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure StringGridGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure InnerControlChange(Sender: TObject);
    procedure InnerControlExit(Sender: TObject);
    procedure StringGridHorizontalScroll(Sender: TObject);
    procedure StringGridVerticalScroll(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FObjectList: TStringList;
    FQuestionCollection: TQuestionCollection;
    FFixedColWidth: Integer;
    FUKButtons: array of Boolean;
    FNAButtons: array of Boolean;
    FIgnoreRows: array of Boolean;
    FIgnoreCols: array of Boolean;
    procedure SetRowsIgnore(Index: Integer; Value: Boolean);
    procedure SetColsIgnore(Index: Integer; Value: Boolean);
    procedure SetQuestionCollection(const Value: TQuestionCollection);
    procedure WMCellSelect(var Message: TMessage); message WM_CELLSELECT;
    function GetRowsIgnore(Index: Integer): Boolean;
    function GetColsIgnore(Index: Integer): Boolean;
    function GetControl(iRow,iCol: Integer): TWinControl;
    function GetControlRow(wControl: TWinControl): Integer;
    function GetControlCol(wControl: TWinControl): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure HideControl;
    property QuestionCollection: TQuestionCollection read FQuestionCollection write SetQuestionCollection;
    property IgnoreRows[Index: Integer]: Boolean read GetRowsIgnore write SetRowsIgnore;
    property IgnoreCols[Index: Integer]: Boolean read GetColsIgnore write SetColsIgnore;
    property FixedColumnWidth: Integer read FFixedColWidth write FFixedColWidth;
  end;

  procedure Register;

implementation

{$R *.dfm}

uses
  ORFn, ORDtTm, DDCSForm, DDCSUtils;

procedure Register;
begin
  RegisterClass(TDDCSQuestionGrid);
end;

{$REGION 'TQuestion'}

procedure TQuestion.SetQuestion(Value: string);
var
  DDCS: TDDCSQuestionGrid;
  I: Integer;
begin
  if Value = '' then
    Exit;

  DDCS := TDDCSQuestionGrid(Collection.Owner);

  if DDCS.StringGrid.Cells[1, (DDCS.StringGrid.RowCount - 1)] <> '' then
  begin
    DDCS.StringGrid.RowCount := DDCS.StringGrid.RowCount + 1;
    for I := 0 to DDCS.StringGrid.ColCount - 1 do
      DDCS.StringGrid.Cells[I, DDCS.StringGrid.RowCount - 1] := '';
  end;
  FRow := DDCS.StringGrid.RowCount - 1;

  DDCS.StringGrid.Cells[1, FRow] := Value;
  DDCS.StringGrid.Cells[0, FRow] := IntToStr(FRow);

  DDCS.FObjectList.AddObject(IntToStr(FRow) + ',2', FControl);

  SetLength(DDCS.FIgnoreRows, DDCS.StringGrid.RowCount);
  SetLength(DDCS.FIgnoreCols, DDCS.StringGrid.ColCount);

  SetLength(DDCS.FUKButtons, DDCS.StringGrid.RowCount);
  SetLength(DDCS.FNAButtons, DDCS.StringGrid.RowCount);
end;

// Since SetQuestion only applies to questions which in turn controls the grid
// rows and Associated or Qualifiers should not have a question, they can be treated
// differently here, in which case, we need to add them to the list.
procedure TQuestion.SetAssociated(Value: TWinControl);
begin
  FAssociated := Value;

  if Value = nil then
    Exit;

  (Collection.Owner as TDDCSQuestionGrid).FObjectList.AddObject(IntToStr(FRow) + ',3', Value);
  TQuestionCollection(Collection).GetQuestion(AssociatedControl).FRow := FRow;
end;

procedure TQuestion.SetAnswer(Value: string);
begin
  if not IsAssociatedControl then
    (Collection as TQuestionCollection).FGrid.Cells[2, FRow] := Value
  else
    (Collection as TQuestionCollection).FGrid.Cells[3, FRow] := Value;
end;

function TQuestion.GetQuestion: string;
begin
  Result := (Collection as TQuestionCollection).FGrid.Cells[1, FRow];
end;

function TQuestion.GetAnswer: string;
begin
  if not IsAssociatedControl then
    Result := (Collection as TQuestionCollection).FGrid.Cells[2, FRow]
  else
    Result := (Collection as TQuestionCollection).FGrid.Cells[3, FRow]
end;

function TQuestion.GetIsAssociated: Boolean;
var
  cCollection: TQuestionCollection;
  I: Integer;
begin
  Result := False;

  cCollection := TQuestionCollection(Collection);
  for I := 0 to cCollection.Count - 1 do
    if cCollection.Items[I].AssociatedControl = FControl then
    begin
      Result := True;
      Break;
    end;
end;

function TQuestion.GetTotalPossible: Integer;
begin
  Result := FPossibleAnswers.Count;
end;

function TQuestion.GetIsUnknown: Boolean;
var
  DDCS: TDDCSQuestionGrid;
begin
  Result := True;
  try
    DDCS := TDDCSQuestionGrid(Collection.Owner);
    if ((FRow > -1) and (FRow <= High(DDCS.FUKButtons))) then
      Result := DDCS.FUKButtons[FRow];
  except
  end;
end;

function TQuestion.GetIsAvailable: Boolean;
var
  DDCS: TDDCSQuestionGrid;
begin
  Result := True;
  try
    DDCS := TDDCSQuestionGrid(Collection.Owner);
    if ((FRow > -1) and (FRow <= High(DDCS.FNAButtons))) then
      Result := (not DDCS.FNAButtons[FRow]);
  except
  end;
end;

procedure TQuestion.TComboBoxOnChange(Sender: TObject);
begin
  //
end;

procedure TQuestion.TORDateBoxOnChange(Sender: TObject);
var
  sValue: string;
begin
  if Sender is TORDateBox then
  begin
    sValue := (Sender as TORDateBox).Text;
    if ContainsText(sValue, '@00:00') then
      (Sender as TORDateBox).Text := Piece(sValue,'@',1);
  end;
end;

procedure TQuestion.TEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = U then
    Key := #0;
end;

procedure TQuestion.TSpinEditOnChange(Sender: TObject);
begin
  if Sender is TJvSpinEdit then
    if (Sender as TJvSpinEdit).Value < 0 then
      (Sender as TJvSpinEdit).Value := 0;
end;

procedure TQuestion.TCheckListBoxOnClickCheck(Sender: TObject);
begin
  //
end;

function TQuestion.CreateCheckBoxforCell(AOwner: TComponent): TCheckBox;
begin
  Result := TCheckBox.Create(AOwner);
  Result.Parent := (Collection as TQuestionCollection).FGrid;
  Result.Visible := False;
end;

constructor TQuestion.Create(Collection: TCollection);
begin
  inherited;

  FPossibleAnswers := TStringList.Create;
  FDefaultAnswers := TStringList.Create;
end;

destructor TQuestion.Destroy;
begin
  FPossibleAnswers.Free;
  FDefaultAnswers.Free;

  inherited;
end;

procedure TQuestion.GetPossibleAnswers(var Value: TStringList);
begin
  Value.Clear;
  Value.AddStrings(FPossibleAnswers);
end;

procedure TQuestion.AddPossibleAnswer(Value: string);
var
  I: Integer;
begin
  if Value <> '' then
  begin
    for I := 0 to FPossibleAnswers.Count - 1 do
      if FPossibleAnswers[I] = Value then
        Exit;

    FPossibleAnswers.Add(Value);
  end;
end;

procedure TQuestion.AddDefaultAnswer(Value: string);
var
  I: Integer;
begin
  if Value <> '' then
  begin
    for I := 0 to FDefaultAnswers.Count - 1 do
      if FDefaultAnswers[I] = Value then
        Exit;

    FDefaultAnswers.Add(Value);
  end;
end;

procedure TQuestion.CreateControl(sName,sClass,sValidate,sProperties: string);
var
  DDCS: TDDCSQuestionGrid;
  iCount,I: Integer;
  sProp,sPropValue: string;
begin
  if sClass = '' then
    Exit;

  DDCS := TDDCSQuestionGrid(Collection.Owner);

  if sClass = 'TCOMBOBOX' then
  begin
    FControl := TComboBox.Create(DDCS);
    (FControl as TComboBox).Style := csDropDownList;
    (FControl as TComboBox).OnDropDown := TComponentHelper.cbAutoWidth;
    if sValidate = '1' then
      (FControl as TComboBox).OnChange := TComboBoxOnChange;
  end
  else
  if sClass = 'TORDATEBOX' then
  begin
    FControl := TORDateBox.Create(DDCS);
    (FControl as TORDateBox).Format := DTIME_FORMAT;
    if sValidate = '1' then
      (FControl as TORDateBox).OnChange := TORDateBoxOnChange;
  end
  else
  if sClass = 'TEDIT' then
  begin
    FControl := TEdit.Create(DDCS);
    if sValidate = '1' then
      (FControl as TEdit).OnKeyPress := TEdit1KeyPress;
  end
  else
  if (sClass = 'TSPINEDIT') or (sClass = 'TJVSPINEDIT') then
  begin
    FControl := TJvSpinEdit.Create(DDCS);
    if sValidate = '1' then
      (FControl as TJvSpinEdit).OnChange := TSpinEditOnChange;
  end
  else
  if sClass = 'TCHECKLISTBOX' then
  begin
    FControl := TCheckListBox.Create(DDCS);
    (FControl as TCheckListBox).Style := lbOwnerDrawFixed;
    (FControl as TCheckListBox).ItemHeight := DDCS.StringGrid.DefaultRowHeight - 2;
    if sValidate = '1' then
      (FControl as TCheckListBox).OnClickCheck := TCheckListBoxOnClickCheck;
  end
  else
    Exit;

  FControl.Parent := (Collection as TQuestionCollection).FGrid;
  FControl.Name := sName;
  FControl.Visible := False;

  try
    if IsPublishedProp(FControl, 'CAPTION') then
      SetPropValue(FControl, 'CAPTION', '');
    if IsPublishedProp(FControl, 'TEXT') then
      SetPropValue(FControl, 'TEXT', '');

    if sProperties <> '' then
    begin
      iCount := SubCount(sProperties, U) + 1;
      for I := 1 to iCount do
      begin
        sProp := Piece(Piece(sProperties,U,I),'|',1);
        if IsPublishedProp(FControl, sProp) then
        begin
          sPropValue := Piece(Piece(sProperties,U,I),'|',2);
          if sPropValue <> '' then
            SetPropValue(FControl, sProp, sPropValue);
        end;
      end;
    end;
  except
  end;
end;

{$ENDREGION}

{$REGION 'TQuestionCollection'}

procedure TQuestionCollection.SetItem(Index: Integer; Value: TQuestion);
begin
  inherited SetItem(Index, Value);
end;

function TQuestionCollection.GetItem(Index: Integer): TQuestion;
begin
  Result := TQuestion(inherited Items[Index]);
end;

procedure TQuestionCollection.DeleteQuestion(sName: string);
var
  Question: TQuestion;
begin
  Question := GetQuestion(sName);
  if Question <> nil then
    Delete(Question.Index);
end;

procedure TQuestionCollection.UpdateQuestionControls;
var
  I,J,K: Integer;
  sValue: string;
  fValue: TFMDateTime;
  iRow,iCol: Integer;
  R: TRect;
begin
  for I := 0 to Count - 1 do
  begin
    if Items[I].FPossibleAnswers.Count > 0 then
      if Items[I].Control <> nil then
      begin
        if (Items[I].Control is TComboBox) then
        begin
          (Items[I].Control as TComboBox).Items.AddStrings(Items[I].FPossibleAnswers);
          if Items[I].FPossibleAnswers.Count = 1 then
          begin
            (Items[I].Control as TComboBox).ItemIndex := 0;
            Items[I].Answer := (Items[I].Control as TComboBox).Items[0];
          end
          else
          if Items[I].FDefaultAnswers.Count > 0 then
            for J := 0 to (Items[I].Control as TComboBox).Items.Count - 1 do
              if (Items[I].Control as TComboBox).Items[J] = Items[I].FDefaultAnswers[0] then
              begin
                (Items[I].Control as TComboBox).ItemIndex := J;
                Items[I].Answer := (Items[I].Control as TComboBox).Items[J];
                Break;
              end;
        end
        else
        if (Items[I].Control is TORDateBox) then
        begin
          if Items[I].FPossibleAnswers.Count > 0 then
          begin
            if ValidateDateTime(Items[I].FPossibleAnswers[0], fValue) then
            begin
              (Items[I].Control as TORDateBox).FMDateTime := fValue;
              Items[I].Answer := (Items[I].Control as TORDateBox).Text;
            end
            else
              Items[I].FPossibleAnswers.Clear;
          end
          else
            Items[I].FPossibleAnswers.Clear;
        end
        else
        if (Items[I].Control is TEdit) then
        begin
          (Items[I].Control as TEdit).Text := Items[I].FPossibleAnswers[0];
          Items[I].Answer := (Items[I].Control as TEdit).Text;
        end
        else
        if (Items[I].Control is TJvSpinEdit) then
        begin
          if (Items[I].Control as TJvSpinEdit).ValueType = vtFloat then
            (Items[I].Control as TJvSpinEdit).Value := StrToFloatDef(Items[I].FPossibleAnswers[0], 0)
          else
            (Items[I].Control as TJvSpinEdit).Value := StrToIntDef(Items[I].FPossibleAnswers[0], 0);
          Items[I].Answer := (Items[I].Control as TJvSpinEdit).Text;
        end
        else
        if (Items[I].Control is TCheckListBox) then
        begin
          (Items[I].Control as TCheckListBox).Items.AddStrings(Items[I].FPossibleAnswers);

          if Items[I].FDefaultAnswers.Count > 0 then
            for J := 0 to Items[I].FDefaultAnswers.Count - 1 do
               for K := 0 to (Items[I].Control as TCheckListBox).Items.Count - 1 do
                 if (Items[I].Control as TCheckListBox).Items[K] = Items[I].FDefaultAnswers[J] then
                 begin
                   (Items[I].Control as TCheckListBox).Checked[K] := True;
                   sValue := sValue + (Items[I].Control as TCheckListBox).Items[K] + ', ';
                 end;
          if Length(sValue) > 0 then
            System.Delete(sValue, (Length(sValue) - 1), 2);
          Items[I].Answer := sValue;
        end;
      end;
  end;
end;

function TQuestionCollection.GetQuestionAddifNil(sName: string): TQuestion;
begin
  Result := GetQuestion(sName);

  if ((Result = nil) and (sName <> '')) then
  begin
    Result := Add;
    Result.Name := sName;
  end;
end;

function TQuestionCollection.GetQuestion(sName: string): TQuestion;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].Name = sName then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TQuestionCollection.GetQuestion(iRow: Integer): TQuestion;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].Row = iRow then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TQuestionCollection.GetQuestion(wControl: TWinControl): TQuestion;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].Control = wControl then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TQuestionCollection.Add: TQuestion;
begin
  Result := TQuestion(inherited Add);
end;

function TQuestionCollection.Insert(Index: Integer): TQuestion;
begin
  Result := TQuestion(inherited Insert(Index));
end;

{$ENDREGION}

{$REGION 'TDDCSQuestionGrid'}

procedure TDDCSQuestionGrid.FrameResize(Sender: TObject);
begin
  HideControl;
end;

procedure TDDCSQuestionGrid.StringGridColWidthsChanged(Sender: TObject);
begin
  if StringGrid.ColWidths[4] <> FFixedColWidth then
    StringGrid.ColWidths[4] := FFixedColWidth;
  if StringGrid.ColWidths[5] <> FFixedColWidth then
    StringGrid.ColWidths[5] := FFixedColWidth;
  StringGrid.Invalidate;

  HideControl;
end;

procedure TDDCSQuestionGrid.StringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  R: TRect;
begin
  if (((ACol = 4) or (ACol = 5)) and (ARow > 0)) then
  begin
    R := Rect;
    R.Width := R.Width + 2;

    if ACol = 4 then
    begin
      if FUKButtons[ARow] then
        DrawFrameControl(StringGrid.Canvas.Handle, R, DFC_BUTTON, DFCS_CHECKED)
      else
        DrawFrameControl(StringGrid.Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK);
    end
    else
    begin
      if FNAButtons[ARow] then
        DrawFrameControl(StringGrid.Canvas.Handle, R, DFC_BUTTON, DFCS_CHECKED)
      else
        DrawFrameControl(StringGrid.Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK);
    end;
  end;

  if ARow = 0 then
  begin
    StringGrid.Canvas.FillRect(Rect);
    DrawText(StringGrid.Canvas.Handle, StringGrid.Cells[ACol, ARow], Length(StringGrid.Cells[ACol, ARow]),
             Rect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TDDCSQuestionGrid.StringGridGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: string);
var
  R: TRect;
  wControl: TWinControl;
begin
  if ARow <= (StringGrid.FixedRows - 1) then
    Exit;
  if IgnoreRows[ARow] then
    Exit;

  if FUKButtons[ARow] then
    Exit;
  if FNAButtons[ARow] then
    Exit;

  if ACol <= (StringGrid.FixedCols - 1) then
    Exit;
  if IgnoreCols[ACol] then
    Exit;

  wControl := GetControl(ARow, ACol);
  if wControl = nil then
    Exit;

  R := StringGrid.CellRect(ACol, ARow);
  R.Left := R.Left + StringGrid.Left;
  R.Right := R.Right + StringGrid.Left;
  R.Top := R.Top + StringGrid.Top;
  R.Bottom := R.Bottom + StringGrid.Top;

  wControl.Left := R.Left;
  wControl.Top := R.Top;
  wControl.Width := R.Right - R.Left;
  wControl.Height := R.Bottom - R.Top;
  wControl.BringToFront;
  wControl.Visible := True;
  wControl.SetFocus;
end;

procedure TDDCSQuestionGrid.StringGridVerticalScroll(Sender: TObject);
begin
  HideControl;
end;

procedure TDDCSQuestionGrid.StringGridHorizontalScroll(Sender: TObject);
begin
  HideControl;
end;

procedure TDDCSQuestionGrid.StringGridKeyPress(Sender: TObject; var Key: Char);
var
  iRow: Integer;

  procedure UpdateRow(iRow: Integer; sAnswer: string);
  var
    qQuestion: TQuestion;

    procedure ResetSubControl(wControl: TWinControl);
    var
      I: Integer;
    begin
      if wControl = nil then
        Exit;

      if wControl is TComboBox then
        (wControl as TComboBox).ItemIndex := -1
      else
      if wControl is TJvSpinEdit then
        (wControl as TJvSpinEdit).Value := 0
      else
      if wControl is TORDateBox then
        (wControl as TORDateBox).Text := ''
      else
      if wControl is TEdit then
        (wControl as TEdit).Text := ''
      else
      if wControl is TCheckListBox then
      begin
        for I := 0 to (wControl as TCheckListBox).Count - 1 do
          (wControl as TCheckListBox).Selected[I] := False;
      end;
    end;

  begin
    qQuestion := QuestionCollection.GetQuestion(iRow);
    if qQuestion <> nil then
    begin
      ResetSubControl(qQuestion.Control);
      qQuestion.Answer := sAnswer;

      if qQuestion.AssociatedControl <> nil then
      begin
        ResetSubControl(qQuestion.AssociatedControl);
        QuestionCollection.GetQuestion(qQuestion.AssociatedControl).Answer := '';
      end;
    end;
  end;

begin
  if (Key = #32) or (Key = #13) then
  begin
    iRow := StringGrid.Row;

    if StringGrid.Col = 4 then
    begin
      FUKButtons[iRow] := not FUKButtons[iRow];
      StringGrid.InvalidateCell(StringGrid.Col, iRow);

      if FUKButtons[iRow] then
      begin
        UpdateRow(iRow, 'Unknown');
        FNAButtons[iRow] := False;
        StringGrid.InvalidateCell(5, iRow);
      end
      else
        UpdateRow(iRow, '');
    end
    else
    if StringGrid.Col = 5 then
    begin
      FNAButtons[iRow] := not FNAButtons[iRow];
      StringGrid.InvalidateCell(StringGrid.Col, iRow);

      if FNAButtons[iRow] then
      begin
        UpdateRow(iRow, '');
        FUKButtons[iRow] := False;
        StringGrid.InvalidateCell(4, iRow);
      end;
    end;
  end;
end;

procedure TDDCSQuestionGrid.StringGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Key: Char;
begin
  // This happens before WM_CELLSELECT
  if (StringGrid.Col = 4) or (StringGrid.Col = 5) then
  begin
    Key := #32;
    StringGridKeyPress(Sender, Key);
  end;
end;

procedure TDDCSQuestionGrid.StringGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if ARow <= (StringGrid.FixedRows - 1) then
    CanSelect := False
  else
  if ACol <= (StringGrid.FixedCols - 1) then
    CanSelect := False
  else
    CanSelect := True;

  HideControl;
  PostMessage(Handle, WM_CELLSELECT, 0, 0);
end;

procedure TDDCSQuestionGrid.InnerControlChange(Sender: TObject);
var
  iRow,iCol: Integer;
  I: Integer;
  sValue: string;
begin
  iRow := GetControlRow(TWinControl(Sender));
  if iRow = -1 then
    Exit;
  if iRow <= (StringGrid.FixedRows - 1) then
    Exit;
  if IgnoreRows[iRow] then
    Exit;

  if FUKButtons[iRow] then
    Exit;
  if FNAButtons[iRow] then
    Exit;

  iCol := GetControlCol(TWinControl(Sender));
  if iCol = -1 then
    Exit;
  if iCol <= (StringGrid.FixedCols - 1) then
    Exit;
  if IgnoreCols[iCol] then
    Exit;

  if Sender is TComboBox then
    StringGrid.Cells[iCol, iRow] := (Sender as TComboBox).Text
  else
  if Sender is TJvSpinEdit then
    StringGrid.Cells[iCol, iRow] := (Sender as TJvSpinEdit).Text
  else
  if Sender is TORDateBox then
    StringGrid.Cells[iCol, iRow] := (Sender as TORDateBox).Text
  else
  if Sender is TEdit then
    StringGrid.Cells[iCol, iRow] := (Sender as TEdit).Text
  else
  if Sender is TCheckListBox then
  begin
    for I := 0 to (Sender as TCheckListBox).Count - 1 do
      if (Sender as TCheckListBox).Checked[I] then
        sValue := sValue + (Sender as TCheckListBox).Items[I] + ', ';
    if Length(sValue) > 0 then
      Delete(sValue, (Length(sValue) - 1), 2);
    StringGrid.Cells[iCol, iRow] := sValue;
  end;
end;

procedure TDDCSQuestionGrid.InnerControlExit(Sender: TObject);
var
  wControl: TWinControl;
  dt: TORDateBox;
  fValue: TFMDateTime;
begin
  wControl := TWinControl(Sender);

  if wControl is TORDateBox then
  begin
    dt := TORDateBox(wControl);
    if not ValidateDateTime(dt.Text, fValue) then
      dt.Text := '';
  end;

  InnerControlChange(Sender);
  wControl.Visible := False;
end;

procedure TDDCSQuestionGrid.SetRowsIgnore(Index: Integer; Value: Boolean);
begin
  if (Index = 0) or (Index < Length(FIgnoreRows)) then
    FIgnoreRows[Index] := Value;
end;

procedure TDDCSQuestionGrid.SetColsIgnore(Index: Integer; Value: Boolean);
begin
  if (Index = 0) or (Index < Length(FIgnoreCols)) then
    FIgnoreCols[Index] := Value;
end;

procedure TDDCSQuestionGrid.SetQuestionCollection(const Value: TQuestionCollection);
begin
  FQuestionCollection.Assign(Value);
end;

procedure TDDCSQuestionGrid.WMCellSelect(var Message: TMessage);
var
  wControl: TWinControl;
  R: TRect;
begin
  if StringGrid.Row <= (StringGrid.FixedRows - 1) then
    Exit;
  if IgnoreRows[StringGrid.Row] then
    Exit;

  if StringGrid.Col <= (StringGrid.FixedCols - 1) then
    Exit;
  if IgnoreCols[StringGrid.Col] then
    Exit;

  // CheckBox Columns
  if (StringGrid.Col = 4) or (StringGrid.Col = 5) then
  begin
    // Need to set focus to the StringGrid otherwise the KeyPress method won't be
    // called and we need it to interface with our checkboxes.
    StringGrid.SetFocus;
    Exit;
  end;

  // Do not access any controls if Unknown or N/A
  if FUKButtons[StringGrid.Row] or FNAButtons[StringGrid.Row] then
    Exit;

  wControl := GetControl(StringGrid.Row, StringGrid.Col);
  if wControl = nil then
    Exit;

  R := StringGrid.CellRect(StringGrid.Col, StringGrid.Row);
  R.Left := R.Left + StringGrid.Left;
  R.Right := R.Right + StringGrid.Left;
  R.Top := R.Top + StringGrid.Top;
  R.Bottom := R.Bottom + StringGrid.Top;

  wControl.Left := R.Left;
  wControl.Top := R.Top;
  wControl.Width := R.Right - R.Left;
  wControl.Height := R.Bottom - R.Top;
  wControl.BringToFront;
  wControl.Visible := True;
  wControl.SetFocus;
end;

procedure TDDCSQuestionGrid.HideControl;
var
  wControl: TWinControl;
  fValue: TFMDateTime;
begin
  wControl := GetControl(StringGrid.Row, StringGrid.Col);
  if wControl = nil then
    Exit;

  if wControl is TComboBox then
    (wControl as TComboBox).OnExit := nil
  else
  if wControl is TJvSpinEdit then
    (wControl as TJvSpinEdit).OnExit := nil
  else
  if wControl is TORDateBox then
  begin
    (wControl as TORDateBox).OnExit := nil;
    if not ValidateDateTime((wControl as TORDateBox).Text, fValue) then
      (wControl as TORDateBox).Text := '';
  end
  else
  if wControl is TEdit then
    (wControl as TEdit).OnExit := nil
  else
  if wControl is TCheckListBox then
    (wControl as TCheckListBox).OnExit := nil;

  InnerControlChange(wControl);
  wControl.Visible := False;

  if wControl is TComboBox then
    (wControl as TComboBox).OnExit := InnerControlExit
  else
  if wControl is TJvSpinEdit then
    (wControl as TJvSpinEdit).OnExit := InnerControlExit
  else
  if wControl is TORDateBox then
    (wControl as TORDateBox).OnExit := InnerControlExit
  else
  if wControl is TEdit then
    (wControl as TEdit).OnExit := InnerControlExit
  else
  if wControl is TCheckListBox then
    (wControl as TCheckListBox).OnExit := InnerControlExit;
end;

function TDDCSQuestionGrid.GetRowsIgnore(Index: Integer): Boolean;
begin
  if (Index = 0) or (Index < Length(FIgnoreRows)) then
    Result := FIgnoreRows[Index];
end;

function TDDCSQuestionGrid.GetColsIgnore(Index: Integer): Boolean;
begin
  if (Index = 0) or (Index < Length(FIgnoreCols)) then
    Result := FIgnoreCols[Index];
end;

function TDDCSQuestionGrid.GetControl(iRow,iCol: Integer): TWinControl;
var
  sIndex: string;
  I: Integer;
begin
  Result := nil;

  if not Assigned(FObjectList) then
    Exit;

  sIndex := IntToStr(iRow) + ',' + IntToStr(iCol);
  I := FObjectList.IndexOf(sIndex);
  if I <> -1 then
    Result := TWinControl(FObjectList.Objects[I]);
end;

function TDDCSQuestionGrid.GetControlRow(wControl: TWinControl): Integer;
var
  I: Integer;
begin
  Result := -1;

  if not Assigned(FObjectList) then
    Exit;

  for I := 0 to FObjectList.Count - 1 do
    if FObjectList.Objects[I] = wControl then
    begin
      Result := StrToIntDef(Piece(FObjectList[I],',',1), -1);
      Break;
    end;
end;

function TDDCSQuestionGrid.GetControlCol(wControl: TWinControl): Integer;
var
  I: Integer;
begin
  Result := -1;

  if not Assigned(FObjectList) then
    Exit;

  for I := 0 to FObjectList.Count - 1 do
    if FObjectList.Objects[I] = wControl then
    begin
      Result := StrToIntDef(Piece(FObjectList[I],',',2), -1);
      Break;
    end;
end;

constructor TDDCSQuestionGrid.Create(AOwner: TComponent);
begin
  inherited;

  FFixedColWidth := 24;

  if FQuestionCollection = nil then
  begin
    FQuestionCollection := TQuestionCollection.Create(Self, TQuestion);
    FQuestionCollection.FGrid := StringGrid;
  end;

  if FObjectList = nil then
    FObjectList := TStringList.Create;

  SetLength(FIgnoreRows, StringGrid.RowCount);
  SetLength(FUKButtons, StringGrid.RowCount);
  SetLength(FNAButtons, StringGrid.RowCount);
  SetLength(FIgnoreCols, StringGrid.ColCount);
  // Only have to Ignore Rows/Cols that are not set as Fixed
  IgnoreCols[0] := True;
  IgnoreCols[1] := True;

  StringGrid.Cells[0,0] := '#';
  StringGrid.Cells[1,0] := 'Question';
  StringGrid.Cells[2,0] := 'Response';
  StringGrid.Cells[3,0] := 'Qualifier';
  StringGrid.Cells[4,0] := 'UK';
  StringGrid.ColWidths[4] := FFixedColWidth;
  StringGrid.Cells[5,0] := 'NA';
  StringGrid.ColWidths[5] := FFixedColWidth;
end;

destructor TDDCSQuestionGrid.Destroy;
begin
  FreeAndNil(FQuestionCollection);
  FreeAndNil(FObjectList);

  SetLength(FIgnoreRows, 0);
  SetLength(FUKButtons, 0);
  SetLength(FNAButtons, 0);
  SetLength(FIgnoreCols, 0);

  inherited;
end;

{$ENDREGION}

end.

