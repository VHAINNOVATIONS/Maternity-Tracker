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
  Vcl.Grids, Vcl.Samples.Spin, JvStringGrid, JvExControls,  JvExGrids,
  ORDtTm, ORFn, uDialog, uCommon, uExtndComBroker;

const
  WM_CELLSELECT = WM_USER + 290;

type
  TdlgOBSpread = class(TDDCSDialog)
    cbPresentation: TComboBox;
    cbFetalAct: TComboBox;
    cbUrineProtein: TComboBox;
    cbUrineGlucose: TComboBox;
    cbEdema: TComboBox;
    cbFetalHeart: TComboBox;
    sgStandard: TJvStringGrid;
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    spnFundalHt: TSpinEdit;
    spnWeight: TSpinEdit;
    pnlCol0: TPanel;
    dtExamDate: TORDateBox;
    btnDelete: TBitBtn;
    btnAddRow: TBitBtn;
    spnAge: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgStandardSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure GridSortColumn(Sender: TJvStringGrid; AColumn, ARow: Integer);
    procedure btnAddRowClick(Sender: TObject);
    procedure btnDeleteRowClick(Sender: TObject);
    procedure InnerControlChange(Sender: TObject);
    procedure InnerControlExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FObjectList: TStringList;
    Ascending: Boolean;
    procedure WMCellSelect(var Message: TMessage); message WM_CELLSELECT;
    procedure InnerControlEnter;
    function GetCumlWt: string;
  end;

var
  dlgOBSpread: TdlgOBSpread;

implementation

{$R *.dfm}

procedure TdlgOBSpread.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  dtExamDate.Format := 'MM/DD/YY@HH:MM';

  FObjectList := TStringList.Create;
  FObjectList.AddObject( '0', pnlCol0);
  FObjectList.AddObject( '1', spnAge);
  FObjectList.AddObject( '2', spnFundalHt);
  FObjectList.AddObject( '3', spnWeight);
  // Cumulative Weight    4
  // BP                   5
  FObjectList.AddObject( '6', cbFetalAct);
  FObjectList.AddObject( '7', cbUrineProtein);
  FObjectList.AddObject( '8', cbUrineGlucose);
  FObjectList.AddObject( '9', cbEdema);
  FObjectList.AddObject('10', cbFetalHeart);
  FObjectList.AddObject('11', cbPresentation);
  // Cervical Exam       12

  if sgStandard.Cells[0,1] = '' then
  begin
    sgStandard.Cells[0,0]  := 'Date';
    sgStandard.Cells[1,0]  := 'Age (wks)';
    sgStandard.Cells[2,0]  := 'Fundal Height';
    sgStandard.Cells[3,0]  := 'Weight';
    sgStandard.Cells[4,0]  := 'Cumulative Weight';
    sgStandard.Cells[5,0]  := 'BP';
    sgStandard.Cells[6,0]  := 'Fetal Activity';
    sgStandard.Cells[7,0]  := 'Urine Protein';
    sgStandard.Cells[8,0]  := 'Urine Glucose';
    sgStandard.Cells[9,0]  := 'Edema';
    sgStandard.Cells[10,0] := 'Fetal Heart';
    sgStandard.Cells[11,0] := 'Presentation';
    sgStandard.Cells[12,0] := 'Cervical Exam';
  end;

  for I := 1 to sgStandard.ColCount - 1 do
    sgStandard.AutoSizeCol(I, 70, 10);
end;

procedure TdlgOBSpread.FormShow(Sender: TObject);
var
  bool: Boolean;
begin
  sgStandardSelectCell(sgStandard, 0, 1, bool);
end;

procedure TdlgOBSpread.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FObjectList.Free;
end;

procedure TdlgOBSpread.sgStandardSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
  wControl: TWinControl;

  function GetControl(iPos: Integer): TWinControl;
  var
    I: Integer;
  begin
    Result := nil;

    I := FObjectList.IndexOf(IntToStr(iPos));
    if I <> -1 then
      Result := TWinControl(FObjectList.Objects[I]);
  end;

begin
  CanSelect := True;

  if ARow <> 0 then
  begin
    if ACol = 4 then
    begin
      sgStandard.Cells[4, ARow] := GetCumlWt;
      Exit;
    end;

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

      PostMessage(Handle, WM_CELLSELECT, 0, 0);
    end;
  end;
end;

procedure TdlgOBSpread.GridSortColumn(Sender: TJvStringGrid; AColumn,ARow: Integer);
begin
  if ARow <> 0 then
    Exit;

  Ascending := not Ascending;
  sgStandard.SortGrid(AColumn, Ascending, True, stAutomatic, True);
end;

procedure TdlgOBSpread.btnAddRowClick(Sender: TObject);
begin
  sgStandard.RowCount := sgStandard.RowCount + 1;
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
        Result := False;
  end;

begin
  if sgStandard.Row < 1 then
    Exit;

  if ShowMsg('Are you sure you want to delete the entire selected table row?',
              smiWarning, smbYesNo) = smrYes then
  begin
    if sgStandard.Row <> 0 then
    begin
      if ((sgStandard.RowCount = 2) and (sgStandard.Row = 1)) then
      begin
        for I := 0 to sgStandard.ColCount - 1 do
          sgStandard.Cells[I, sgStandard.Row] := '';
      end else
        sgStandard.RemoveRow(sgStandard.Row);
    end;

    if sgStandard.ColCount > 12 then
      for I := sgStandard.ColCount - 1 downto 13 do
        if IsColumnEmpty(I) then
          sgStandard.RemoveCol(I);
  end;
end;

procedure TdlgOBSpread.InnerControlChange(Sender: TObject);
var
  sp: TSpinEdit;
  dt: TORDateBox;
begin
  if Sender is TComboBox then
    sgStandard.Cells[sgStandard.Col, sgStandard.Row] := TComboBox(Sender).Text
  else if Sender is TSpinEdit then
  begin
    sp := TSpinEdit(Sender);
    sgStandard.Cells[sgStandard.Col, sgStandard.Row] := sp.Text;

    if sp = spnWeight then
      sgStandard.Cells[4, sgStandard.Row] := GetCumlWt;
  end else if Sender is TORDateBox then
  begin
    dt := TORDateBox(Sender);
    sgStandard.Cells[sgStandard.Col, sgStandard.Row] := dt.Text;
    GridSortColumn(sgStandard, 0, sgStandard.Row);
  end;
end;

procedure TdlgOBSpread.InnerControlExit(Sender: TObject);
var
  wControl: TWinControl;
begin
  InnerControlChange(Sender);

  wControl := TWinControl(Sender);
  if wControl = dtExamDate then
    pnlCol0.Visible := False
  else
    wControl.Visible := False;

//  sgStandard.SetFocus;
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
    if not Assigned(NoteText) then
      NoteText := TStringList.Create;

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
        begin
         if (row_width < Length(Trim(sgStandard.Cells[cntr, row_ptr]))) then
         row_width := Length(Trim(sgStandard.Cells[cntr, row_ptr]));
        end;
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
        for row_ptr := sgStandard.Cols[0].Count - 1 downto 1 do
        begin
          row_width := 0;
          for cntr := 0 to sgStandard.Rows[0].Count - 1 do
          begin
            if (row_width < Length(Trim(sgStandard.Cells[cntr, row_ptr]))) then
            row_width := Length(Trim(sgStandard.Cells[cntr, row_ptr]));
          end;
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
        begin
          NoteText.AddStrings(slTemp);
        end
        else
        begin
          NoteText.Delete(NoteText.Count-1);
          NoteText.Delete(NoteText.Count-1);
          NoteText.Delete(NoteText.Count-1);
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

procedure TdlgOBSpread.WMCellSelect(var Message: TMessage);
begin
  InnerControlEnter;
end;

procedure TdlgOBSpread.InnerControlEnter;
var
  wControl: TWinControl;
  cb: TComboBox;
  sp: TSpinEdit;
begin
  wControl := ActiveControl;
  if wControl = nil then
    Exit;

  if wControl is TComboBox then
  begin
    cb := TComboBox(wControl);
    cb.ItemIndex := cb.Items.IndexOf(sgStandard.Cells[sgStandard.Col, sgStandard.Row])
  end else if wControl is TSpinEdit then
  begin
    sp := TSpinEdit(wControl);
    sp.Value := StrToIntDef(sgStandard.Cells[sgStandard.Col, sgStandard.Row], 0);
  end else if ((wControl is TORDateBox) or (wControl is TPanel)) then
  begin
    dtExamDate.Text := sgStandard.Cells[sgStandard.Col, sgStandard.Row];
    if not dtExamDate.IsValid then
      dtExamDate.Text := '';
  end;
end;

function TdlgOBSpread.GetCumlWt: string;
var
  sdt,pdt,cdt: TORDateBox;
  I,wRow: Integer;
begin
  Result := '0';

  if sgStandard.Cells[0, sgStandard.Row] = '' then
    Exit;

  wRow := 0;
  sdt := TORDateBox.Create(nil);
  pdt := TORDateBox.Create(nil);
  cdt := TORDateBox.Create(nil);
  try
    sdt.Text := sgStandard.Cells[0, sgStandard.Row];
    if sdt.IsValid then
    begin
      for I := 1 to sgStandard.RowCount - 1 do
      begin
        cdt.Text := sgStandard.Cells[0, I];
        if cdt.IsValid then
          if ((cdt.FMDateTime < sdt.FMDateTime) and
              (cdt.FMDateTime > pdt.FMDateTime)) then
          begin
            pdt.Text := cdt.Text;
            wRow := I;
          end;
      end;
      if wRow <> 0 then
        Result := IntToStr(StrToIntDef(sgStandard.Cells[3, sgStandard.Row], 0) -
                           StrToIntDef(sgStandard.Cells[3, wRow], 0));
    end;
  finally
    cdt.Free;
    pdt.Free;
    sdt.Free;
  end;
end;

end.

