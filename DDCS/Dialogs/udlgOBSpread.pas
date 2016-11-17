unit udlgOBSpread;

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
  System.Classes, System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.Samples.Spin, Vcl.ActnList, Vcl.Menus, JvStringGrid,
  JvExControls, JvExGrids, ORDtTm, ORFn, uDialog, uCommon, uExtndComBroker;

const
  WM_CELLSELECT  = WM_USER + 200;

type
  TdlgOBSpread = class(TDDCSDialog)
    cbPresentation: TComboBox;
    cbFetalAct: TComboBox;
    cbUrineProtein: TComboBox;
    cbUrineGlucose: TComboBox;
    cbEdema: TComboBox;
    sgStandard: TJvStringGrid;
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    spnFundalHt: TSpinEdit;
    spnWeight: TSpinEdit;
    btnAddRow: TBitBtn;
    spnAge: TSpinEdit;
    spnDilation: TSpinEdit;
    spnEffacement: TSpinEdit;
    spnLong: TSpinEdit;
    spnSystolic: TSpinEdit;
    spnDiastolic: TSpinEdit;
    spnPain: TSpinEdit;
    spnFetalHeart: TSpinEdit;
    btnDeleteRow: TBitBtn;
    dtExam: TORDateBox;
    cbPretermLabor: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure sgStandardColWidthsChanged(Sender: TObject);
    procedure sgStandardSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure sgStandardGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure btnAddRowClick(Sender: TObject);
    procedure btnDeleteRowClick(Sender: TObject);
    procedure InnerControlChange(Sender: TObject);
    procedure InnerControlExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure sgStandardHorizontalScroll(Sender: TObject);
    procedure sgStandardVerticalScroll(Sender: TObject);
  private
    FNavControl: TActionList;
    FObjectList: TStringList;
    FResizeOK: Boolean;
    FFMDates: array of Double;
    procedure BuildFMDateList;
    procedure WMCellSelect(var Message: TMessage); message WM_CELLSELECT;
    procedure InnerControlEnter; overload;
    procedure InnerControlEnter(Value: string); overload;
    procedure Tab(Sender: TObject);
    procedure ShiftTab(Sender: TObject);
    procedure HideControl;
    procedure UpdateAllCumlWts;
    function GetControl(iPos: Integer): TWinControl;
    function GetControlCol(wControl: TWinControl): Integer;
    function GetCumlWt(iRow: Integer): string;
  end;

var
  dlgOBSpread: TdlgOBSpread;

implementation

{$R *.dfm}

function ServerParseFMDate(const AString: string): TFMDateTime;
begin
  try
    Result := StrToFloat(sCallV('ORWU DT', [AString, 'TSX']));
  except
    on E: Exception do
    Result := 0;
  end;
end;

procedure TdlgOBSpread.FormCreate(Sender: TObject);
var
  nAct: TAction;
begin
  FNavControl := TActionList.Create(Self);
  nAct := TAction.Create(FNavControl);
  nAct.ActionList := FNavControl;
  nAct.ShortCut := ShortCut(VK_TAB, []);
  nAct.OnExecute := Tab;
  nAct := TAction.Create(FNavControl);
  nAct.ActionList := FNavControl;
  nAct.ShortCut := ShortCut(VK_TAB, [ssShift]);
  nAct.OnExecute := ShiftTab;

  dtExam.Format := 'MM/DD/YYYY@hh:nn';
  dtExam.Text := sgStandard.Cells[0, 1];

  FObjectList := TStringList.Create;
  FObjectList.AddObject( '0', dtExam);
  FObjectList.AddObject( '1', spnAge);
  FObjectList.AddObject( '2', spnFundalHt);
  FObjectList.AddObject( '3', spnWeight);
  // Cumulative Weight        4
  FObjectList.AddObject( '5', cbUrineProtein);
  FObjectList.AddObject( '6', cbUrineGlucose);
  FObjectList.AddObject( '7', cbEdema);
  // Fetal Weight             8
  FObjectList.AddObject( '9', spnFetalHeart);
  FObjectList.AddObject('10', cbPresentation);
  FObjectList.AddObject('11', cbFetalAct);
  FObjectList.AddObject('12', cbPretermLabor);
  FObjectList.AddObject('13', spnDilation);
  FObjectList.AddObject('14', spnEffacement);
  FObjectList.AddObject('15', spnLong);
  FObjectList.AddObject('16', spnSystolic);
  FObjectList.AddObject('17', spnDiastolic);
  FObjectList.AddObject('18', spnPain);
  // Cervical Exam            19

  sgStandard.Cells[0,0]  := 'Exam Date';
  sgStandard.Cells[1,0]  := 'Gestational Age (wks)';
  sgStandard.Cells[2,0]  := 'Fundal Height (cm)';
  sgStandard.Cells[3,0]  := 'Weight (lbs)';
  sgStandard.Cells[4,0]  := 'Cumulative Weight (lbs)';
  sgStandard.Cells[5,0]  := 'Albumin';
  sgStandard.Cells[6,0]  := 'Glucose';
  sgStandard.Cells[7,0]  := 'Edema';
  sgStandard.Cells[8,0]  := 'Fetal Weight (g)';
  sgStandard.Cells[9,0]  := 'Fetal Heart(s)';              // this will create additional columns of Fetal Heart Rate (min)
  sgStandard.Cells[10,0] := 'Fetal Presentation';
  sgStandard.Cells[11,0] := 'Fetal Movement';
  sgStandard.Cells[12,0] := 'Preterm Labor Symptoms';
  sgStandard.Cells[13,0] := 'Dilation (cm)';
  sgStandard.Cells[14,0] := 'Effacement (%)';
  sgStandard.Cells[15,0] := 'Long Axis (cm)';
  sgStandard.Cells[16,0] := 'Intravascular Systolic (mmHg)';
  sgStandard.Cells[17,0] := 'Intravascular Diastolic (mmHg)';
  sgStandard.Cells[18,0] := 'Pain Severity';
  sgStandard.Cells[19,0] := 'Cervical Exam';

  // 508
  SayOnFocus(        dtExam, 'Exam Date');
  SayOnFocus(        spnAge, 'Gestational Age in weeks');
  SayOnFocus(   spnFundalHt, 'Fundal Height in centimeters');
  SayOnFocus(     spnWeight, 'Weight in pounds');
  SayOnFocus(cbUrineProtein, 'Albumin');
  SayOnFocus(cbUrineGlucose, 'Glucose');
  SayOnFocus(       cbEdema, 'Edema');
  SayOnFocus( spnFetalHeart, 'Fetal Hearts');
  SayOnFocus(cbPresentation, 'Fetal Presentation');
  SayOnFocus(cbPretermLabor, 'Preterm Labor Symptoms');
  SayOnFocus(    cbFetalAct, 'Fetal Movement');
  SayOnFocus(   spnDilation, 'Dilation in centimeters');
  SayOnFocus( spnEffacement, 'Effacement in percentage');
  SayOnFocus(       spnLong, 'Long Axis in centimeters');
  SayOnFocus(   spnSystolic, 'Intravascular Systolic in millimeters of mercury');
  SayOnFocus(  spnDiastolic, 'Intravascular Diastolic in millimeters of mercury');
  SayOnFocus(       spnPain, 'Pain Severity as a range between zero and ten with' +
                             ' zero being not painful and ten being extremely painful.');
end;

procedure TdlgOBSpread.FormShow(Sender: TObject);
var
  I: Integer;
begin
  BuildFMDateList;

  if sgStandard.ColCount > 20 then
    for I := 20 to sgStandard.ColCount - 1 do
      sgStandard.Cells[I, 0] := 'Heart Rate #' + IntToStr(I - 19);

  FResizeOK := False;
  for I := 1 to sgStandard.ColCount - 1 do
    sgStandard.AutoSizeCol(I, 70, 10);
  FResizeOK := True;

  if Assigned(ScreenReader) then
    ScreenReader.SayString('Exam Date', False);
end;

procedure TdlgOBSpread.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FObjectList.Free;
  SetLength(FFMDates, 0);
end;

procedure TdlgOBSpread.FormResize(Sender: TObject);
begin
  HideControl;
end;

procedure TdlgOBSpread.sgStandardColWidthsChanged(Sender: TObject);
begin
  if FResizeOK then
    HideControl;
end;

procedure TdlgOBSpread.sgStandardGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: string);
var
  R: TRect;
  wControl: TWinControl;
begin
  if ARow = 0 then
    Exit;

  wControl := GetControl(ACol);
  if wControl <> nil then
  begin
    R := sgStandard.CellRect(ACol, ARow);
    R.Left := R.Left + sgStandard.Left;
    R.Right := R.Right + sgStandard.Left;
    R.Top := R.Top + sgStandard.Top;
    R.Bottom := R.Bottom + sgStandard.Top;

    wControl.Left := R.Left + 1;
    wControl.Top := R.Top + 1;
    wControl.Width := (R.Right + 1) - R.Left;
    wControl.Height := (R.Bottom + 1) - R.Top;
    wControl.BringToFront;
    wControl.Visible := True;
    wControl.SetFocus;
    InnerControlEnter(Value);
  end;
end;

procedure TdlgOBSpread.sgStandardVerticalScroll(Sender: TObject);
begin
  HideControl;
end;

procedure TdlgOBSpread.sgStandardHorizontalScroll(Sender: TObject);
begin
  HideControl;
end;

procedure TdlgOBSpread.sgStandardSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := True;

  HideControl;

  if ARow = 0 then
    Exit;

  if Assigned(ScreenReader) then
  begin
    if ACol = 4 then
      ScreenReader.SayString('Cumulative Weight in pounds Read Only', False)
    else if ACol = 8 then
      ScreenReader.SayString('Fetal Weight in grams', False)
    else if ACol = 19 then
      ScreenReader.SayString('Cervical Exam Type in Text', False)
    else if ACol > 19 then
      ScreenReader.SayString(sgStandard.Cells[ACol, 0] + ' Type in Text', False);
  end;

  PostMessage(Handle, WM_CELLSELECT, 0, 0);
end;

procedure TdlgOBSpread.btnAddRowClick(Sender: TObject);
var
  I: Integer;
begin
  sgStandard.RowCount := sgStandard.RowCount + 1;
  SetLength(FFMDates, sgStandard.RowCount);

  for I := 0 to sgStandard.ColCount - 1 do
    sgStandard.Cells[I, sgStandard.RowCount - 1] := '';

  UpdateAllCumlWts;
end;

procedure TdlgOBSpread.btnDeleteRowClick(Sender: TObject);
var
  I: Integer;

  function IsColumnEmpty(iCol: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := sgStandard.RowCount - 1 downto 1 do
      if sgStandard.Cells[iCol, I] <> '' then
      begin
        Result := False;
        Break;
      end;
  end;

begin
  if sgStandard.Row < 1 then
    Exit;

  if ShowMsg('Are you sure you want to delete the entire row?', smiWarning, smbYesNo) = smrYes then
  begin
    if sgStandard.Row <> 0 then
    begin
      if ((sgStandard.RowCount = 2) and (sgStandard.Row = 1)) then
      begin
        for I := 0 to sgStandard.ColCount - 1 do
          sgStandard.Cells[I, sgStandard.Row] := '';
      end else
      begin
        for I := 0 to sgStandard.ColCount - 1 do
          sgStandard.Cells[I, sgStandard.Row] := '';
        sgStandard.RemoveRow(sgStandard.Row);
      end;
    end;

    if sgStandard.ColCount > 20 then
      for I := sgStandard.ColCount - 1 downto 20 do
        if IsColumnEmpty(I) then
          sgStandard.RemoveCol(I);

    BuildFMDateList;
    UpdateAllCumlWts;
  end;
end;

procedure TdlgOBSpread.InnerControlChange(Sender: TObject);
var
  sp: TSpinEdit;
  dt: TORDateBox;
  iCol: Integer;

  procedure HeartCols(iValue: Integer);
  var
    I,iCols: Integer;
  begin
    if iValue < 0 then
      Exit;

    if sgStandard.ColCount = 20 then
    begin
      sgStandard.ColCount := sgStandard.ColCount + iValue;
      for I := 20 to sgStandard.ColCount - 1 do
        sgStandard.Cells[I, 0] := 'Heart Rate #' + IntToStr(I - 19);

      Exit;
    end else
    begin
      for I := 1 to sgStandard.RowCount - 1 do
      begin
        iCols := StrToIntDef(sgStandard.Cells[9, I], 0);
        if iCols > iValue then
          iValue := iCols;
      end;
      iValue := 19 + iValue;
      if iValue > (sgStandard.ColCount - 1) then
      begin
        for I := sgStandard.ColCount to iValue do
        begin
          sgStandard.ColCount := sgStandard.ColCount + 1;
          sgStandard.Cells[I, 0] := 'Heart Rate #' + IntToStr(I - 19);
        end;
      end else
        sgStandard.ColCount := (iValue + 1);

      FResizeOK := False;
      if sgStandard.ColCount > 20 then
        for I := 20 to sgStandard.ColCount - 1 do
          sgStandard.AutoSizeCol(I, 70, 10);
      FResizeOK := True;
    end;
  end;

begin
  iCol := GetControlCol(TWinControl(Sender));
  if iCol = -1 then
    Exit;

  if Sender is TComboBox then
    sgStandard.Cells[iCol, sgStandard.Row] := TComboBox(Sender).Text
  else if Sender is TSpinEdit then
  begin
    sp := TSpinEdit(Sender);
    if sp.Value < 0 then
      sp.Value := 0;

    if sp = spnPain then
      if sp.Value > 10 then
        sp.Value := 10;

    sgStandard.Cells[iCol, sgStandard.Row] := sp.Text;

    if sp = spnFetalHeart then
      HeartCols(sp.Value);

    if sp = spnWeight then
      UpdateAllCumlWts;

  end else if Sender is TORDateBox then
  begin
    dt := TORDateBox(Sender);
    sgStandard.Cells[iCol, sgStandard.Row] := dt.Text;
  end;
end;

procedure TdlgOBSpread.InnerControlExit(Sender: TObject);
var
  wControl: TWinControl;
  dt: TORDateBox;
  iOld,iRow: Integer;

  function DateUnique(iRow: Integer; sDate: string): Boolean;
  var
    I: Integer;
  begin
    Result := True;

    for I := 0 to sgStandard.RowCount - 1 do
      if ((I <> iRow) and (sgStandard.Cells[0, I] = sDate)) then
      begin
        Result := False;
        Break;
      end;
  end;

  function NewRowIndex(sFMDate: Double): Integer;
  var
    sl,rl: TStringList;
    I: Integer;
  begin
    Result := -1;

    sl := TStringList.Create;
    rl := TStringList.Create;
    try
      for I := 0 to Length(FFMDates) - 1 do
        sl.Add(FloatToStr(FFMDates[I]));
      sl.Sort;

      // Reverse the Sort
      for I := sl.Count - 1 downto 1 do
        rl.Add(sl[I]);
      rl.Insert(0, '0');

      FFMDates[0] := 0;
      for I := 0 to rl.Count - 1 do
      begin
        FFMDates[I] := StrToFloat(rl[I]);
        if FFMDates[I] = sFMDate then
          Result := I;
      end;
    finally
      rl.Free;
      sl.Free;
    end;
  end;

begin
  wControl := TWinControl(Sender);

  if wControl is TORDateBox then
  begin
    dt := TORDateBox(wControl);

    if not dt.IsValid then
      dt.Text := ''
    else if not DateUnique(sgStandard.Row, dt.Text) then
      dt.Text := ''
    else if dt.Text <> '' then
    begin
      iOld := sgStandard.Row;
      FFMDates[iOld] := dt.FMDateTime;
      iRow := NewRowIndex(FFMDates[iOld]);
      if ((iRow > 0) and (iRow <> iOld)) then
      begin
        sgStandard.MoveRow(iOld, iRow);
        BuildFMDateList;
      end;
      UpdateAllCumlWts;
    end;
  end;

  InnerControlChange(Sender);
  wControl.Visible := False;
end;

procedure TdlgOBSpread.btnOKClick(Sender: TObject);
var
  sl: TStringList;

  procedure GetNoteText(var NoteText: TStringList);
  var
    cntr: integer;
    row_ptr: integer;
    row_width: integer;
    header_width: integer;
    sVal: string;
    slTemp: TStringList;
    slHeader: TStringList;
  begin
    NoteText.Clear;

    slTemp := TStringList.Create;
    slHeader := TStringList.Create;
    try
      if sgStandard.Cols[0].Count > 1 then
      begin
        NoteText.Add('OB Flow Sheet:');

        for cntr := 0 to sgStandard.Rows[0].Count - 1 do
          slTemp.Add('| ');

        row_ptr := 0;
        row_width := 0;

        for cntr := 0 to sgStandard.Rows[0].Count - 1 do
         if (row_width < Length(Trim(sgStandard.Cells[cntr, row_ptr]))) then
           row_width := Length(Trim(sgStandard.Cells[cntr, row_ptr]));

        if (row_ptr = 0) then
          header_width := row_width + 3;

        for cntr := 0 to sgStandard.Rows[0].Count - 1 do
        begin
          sVal := Trim(sgStandard.Cells[cntr, row_ptr]);

          while Length(sVal) < row_width do
            sVal := sVal + ' ';

          slTemp[cntr] := slTemp[cntr] + sVal + ' | ';

          if row_ptr = 0 then
            slHeader.Add(sVal);
        end;

        for row_ptr := 1 to sgStandard.Cols[0].Count - 1 do
        begin
          row_width := 0;

          for cntr := 0 to sgStandard.Rows[0].Count - 1 do
            if (row_width < Length(Trim(sgStandard.Cells[cntr, row_ptr]))) then
              row_width := Length(Trim(sgStandard.Cells[cntr, row_ptr]));

          if (row_ptr = 0) then
            header_width := row_width + 3;

          if (Length(slTemp[0]) + row_width + 3 > 70) then
          begin
            // Row Lines
            sVal := '|-';

            while Length(sVal) < Length(slTemp[0]) do
              sVal := sVal + '-';

            for cntr := sgStandard.Rows[0].Count downto 1 do
              slTemp.Insert(cntr,sVal);

            NoteText.AddStrings(slTemp);
            NoteText.Add('');
            NoteText.Add('');
            NoteText.Add('OB FLOW SHEET (cont.):');
            slTemp.Clear;

            for cntr := 0 to sgStandard.Rows[0].Count - 1 do
              slTemp.Add('| ' +  slHeader[cntr] + ' | ');
          end;

          for cntr := 0 to sgStandard.Rows[0].Count - 1 do
          begin
            sVal := Trim(sgStandard.Cells[cntr, row_ptr]);

            while Length(sVal) < row_width do
              sVal := ' ' + sVal;

            slTemp[cntr] := slTemp[cntr] + sVal + ' | ';

            if row_ptr = 0 then
              slHeader.Add(sVal);
          end;
        end;

        // Row Lines
        sVal := '|-';

        while Length(sVal) < Length(slTemp[0]) do
          sVal := sVal + '-';

        for cntr := sgStandard.Rows[0].Count downto 1 do
          slTemp.Insert(cntr,sVal);

        if Length(slTemp[0]) > 2 + header_width then
          NoteText.AddStrings(slTemp)
        else begin
          NoteText.Delete(NoteText.Count - 1);
          NoteText.Delete(NoteText.Count - 1);
          NoteText.Delete(NoteText.Count - 1);
        end;
      end;
    finally
      slTemp.Free;
      slHeader.Free;
    end;
  end;

begin
  sl := TStringList.Create;
  try
    GetNoteText(sl);
    TmpStrList.AddStrings(sl);
    ModalResult := mrOk;
  finally
    sl.Free;
  end;
end;

// Private ---------------------------------------------------------------------

procedure TdlgOBSpread.BuildFMDateList;
var
  I: Integer;
begin
  SetLength(FFMDates, 0);
  SetLength(FFMDates, sgStandard.RowCount);
  for I := 0 to sgStandard.RowCount - 1 do
    if sgStandard.Cells[0, I] <> '' then
      FFMDates[I] := ServerParseFMDate(sgStandard.Cells[0, I]);
end;

procedure TdlgOBSpread.WMCellSelect(var Message: TMessage);
var
  wControl: TWinControl;
  R: TRect;
begin
  wControl := GetControl(sgStandard.Col);
  if wControl <> nil then
  begin
    R := sgStandard.CellRect(sgStandard.Col, sgStandard.Row);
    R.Left := R.Left + sgStandard.Left;
    R.Right := R.Right + sgStandard.Left;
    R.Top := R.Top + sgStandard.Top;
    R.Bottom := R.Bottom + sgStandard.Top;

    wControl.Left := R.Left + 1;
    wControl.Top := R.Top + 1;
    wControl.Width := (R.Right + 1) - R.Left;
    wControl.Height := (R.Bottom + 1) - R.Top;
    wControl.BringToFront;
    wControl.Visible := True;
    wControl.SetFocus;
  end;

  if sgStandard.Col = 4 then
    sgStandard.Cells[4, sgStandard.Row] := GetCumlWt(sgStandard.Row)
  else
    InnerControlEnter;
end;

procedure TdlgOBSpread.InnerControlEnter;
var
  wControl: TWinControl;
  iCol: Integer;
  cb: TComboBox;
  sp: TSpinEdit;
  dt: TORDateBox;
begin
  wControl := ActiveControl;
  if wControl = nil then
    Exit;

  iCol := GetControlCol(wControl);
  if iCol = -1 then
    Exit;

  if wControl is TComboBox then
  begin
    cb := TComboBox(wControl);
    cb.ItemIndex := cb.Items.IndexOf(sgStandard.Cells[iCol, sgStandard.Row]);
  end else if wControl is TSpinEdit then
  begin
    sp := TSpinEdit(wControl);
    sp.Value := StrToIntDef(sgStandard.Cells[iCol, sgStandard.Row], 0);
    sp.SelectAll;
  end else if wControl is TORDateBox then
  begin
    dt := TORDateBox(wControl);
    dt.Text := sgStandard.Cells[iCol, sgStandard.Row];
    if not dt.IsValid then
      dt.Text := '';
    dt.SelectAll;
    FFMDates[sgStandard.Row] := dt.FMDateTime;
  end;
end;

procedure TdlgOBSpread.InnerControlEnter(Value: string);
var
  wControl: TWinControl;
  cb: TComboBox;
  sp: TSpinEdit;
  dt: TORDateBox;
begin
  wControl := ActiveControl;
  if wControl = nil then
    Exit;

  if wControl is TComboBox then
  begin
    cb := TComboBox(wControl);
    cb.ItemIndex := cb.Items.IndexOf(Value);
  end else if wControl is TSpinEdit then
  begin
    sp := TSpinEdit(wControl);
    sp.Value := StrToIntDef(Value, 0);
    sp.SelectAll;
  end else if wControl is TORDateBox then
  begin
    dt := TORDateBox(wControl);
    dt.Text := Value;
    if not dt.IsValid then
      dt.Text := '';
    dt.SelectAll;
    FFMDates[sgStandard.Row] := dt.FMDateTime;
  end;
end;

procedure TdlgOBSpread.Tab(Sender: TObject);
begin
  if btnAddRow.Focused then
    btnDeleteRow.SetFocus
  else if btnDeleteRow.Focused then
    btnOK.SetFocus
  else if btnOK.Focused then
    btnCancel.SetFocus
  else if btnCancel.Focused then
  begin
    sgStandard.SetFocus;
    sgStandard.Col := 0;
    sgStandard.Row := 1;
  end else
  begin
    if sgStandard.Col = sgStandard.ColCount - 1 then
    begin
      if sgStandard.Row = sgStandard.RowCount - 1 then
      begin
        if btnAddRow.Focused then
          btnDeleteRow.SetFocus
        else if btnDeleteRow.Focused then
          btnOK.SetFocus
        else if btnOK.Focused then
          btnCancel.SetFocus
        else if btnCancel.Focused then
        begin
          sgStandard.SetFocus;
          sgStandard.Col := 0;
          sgStandard.Row := 1;
        end else
          btnAddRow.SetFocus;
      end else
      begin
        sgStandard.Col := 0;
        sgStandard.Row := sgStandard.Row + 1;
      end;
    end else
    begin
      if sgStandard.Col = 0 then
        InnerControlExit(dtExam);

      sgStandard.Col := sgStandard.Col + 1;
    end;
  end;
end;

procedure TdlgOBSpread.ShiftTab(Sender: TObject);
begin
  if btnCancel.Focused then
    btnOK.SetFocus
  else if btnOK.Focused then
    btnDeleteRow.SetFocus
  else if btnDeleteRow.Focused then
    btnAddRow.SetFocus
  else if btnAddRow.Focused then
  begin
    sgStandard.SetFocus;
    sgStandard.Col := sgStandard.ColCount - 1;
    sgStandard.Row := sgStandard.RowCount - 1;
  end else
  begin
    if sgStandard.Col > 0 then
      sgStandard.Col := sgStandard.Col - 1
    else
    begin
      InnerControlExit(dtExam);

      if sgStandard.Row > 1 then
      begin
        sgStandard.Col := sgStandard.ColCount - 1;
        sgStandard.Row := sgStandard.Row - 1;
      end else
      begin
        if btnCancel.Focused then
          btnOK.SetFocus
        else if btnOK.Focused then
          btnDeleteRow.SetFocus
        else if btnDeleteRow.Focused then
          btnAddRow.SetFocus
        else if btnAddRow.Focused then
        begin
          sgStandard.SetFocus;
          sgStandard.Col := sgStandard.ColCount - 1;
          sgStandard.Row := sgStandard.RowCount - 1;
        end else
          btnCancel.SetFocus;
      end;
    end;
  end;
end;

procedure TdlgOBSpread.HideControl;
var
  wControl: TWinControl;
begin
  wControl := GetControl(sgStandard.Col);
  if wControl <> nil then
  begin
    if wControl is TComboBox then
      TComboBox(wControl).OnExit := nil
    else if wControl is TSpinEdit then
      TSpinEdit(wControl).OnExit := nil
    else if wControl is TORDateBox then
    begin
      TORDateBox(wCOntrol).OnExit := nil;
      if not TORDateBox(wControl).IsValid then
        TORDateBox(wControl).Text := '';
    end;

    InnerControlChange(wControl);
    wControl.Visible := False;

    sgStandard.SetFocus;

    if wControl is TComboBox then
      TComboBox(wControl).OnExit := InnerControlExit
    else if wControl is TSpinEdit then
      TSpinEdit(wControl).OnExit := InnerControlExit
    else if wControl is TORDateBox then
      TORDateBox(wControl).OnExit := InnerControlExit;
  end;
end;

procedure TdlgOBSpread.UpdateAllCumlWts;
var
  iRow: Integer;
begin
  for iRow := 1 to sgStandard.RowCount - 1 do
    sgStandard.Cells[4, iRow] := GetCumlWt(iRow);
end;

function TdlgOBSpread.GetControl(iPos: Integer): TWinControl;
var
  I: Integer;
begin
  Result := nil;

  if not Assigned(FObjectList) then
    Exit;

  I := FObjectList.IndexOf(IntToStr(iPos));
  if I <> -1 then
    Result := TWinControl(FObjectList.Objects[I]);
end;

function TdlgOBSpread.GetControlCol(wControl: TWinControl): Integer;
var
  I: Integer;
begin
  Result := -1;

  if not Assigned(FObjectList) then
    Exit;

  for I := 0 to FObjectList.Count - 1 do
    if FObjectList.Objects[I] = wControl then
    begin
      Result := StrToIntDef(FObjectList[I], -1);
      Break;
    end;
end;

function TdlgOBSpread.GetCumlWt(iRow: Integer): string;
var
  I,iWt,iRwt: Integer;
begin
  Result := '0';

  if sgStandard.Cells[3, iRow] = ''  then
    Exit;
  iWt := StrToIntDef(sgStandard.Cells[3, iRow], 0);

  if iRow + 1 <= sgStandard.RowCount - 1 then
    for I := iRow + 1 to sgStandard.RowCount - 1 do
      if sgStandard.Cells[3, I] <> '' then
      begin
        iRwt := StrToIntDef(sgStandard.Cells[3, I], 0);
        Result := IntToStr(iWt - iRwt);
        Break;
      end;
end;

end.

