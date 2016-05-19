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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, strutils, JvSpin,
  JvStringGrid, JvExControls, Vcl.Grids, JvExGrids, uDialog, uExtndComBroker;

type
  TdlgOBSpread = class(TDDCSDialog)
    lblFetalActivity: TLabel;
    lblUrineProtien: TLabel;
    lblUrineSugar: TLabel;
    lblEdema: TLabel;
    lblFetalHeart: TLabel;
    pgcOBFlow: TPageControl;
    tsStandard: TTabSheet;
    lblPresentation: TLabel;
    lbledtAge: TLabeledEdit;
    lbledtFndHt: TLabeledEdit;
    udFundalHt: TUpDown;
    lblWt: TLabeledEdit;
    lblBP: TLabeledEdit;
    cmbPres: TComboBox;
    cmbFetAct: TComboBox;
    cmbProtein: TComboBox;
    cmbSugar: TComboBox;
    cmbEdema: TComboBox;
    cmbHeart: TComboBox;
    leRate: TLabeledEdit;
    leRate2: TLabeledEdit;
    leRate3: TLabeledEdit;
    tsDiabetic: TTabSheet;
    gbxMeds: TGroupBox;
    leAvgFBS: TLabeledEdit;
    leAvgPostPrandial: TLabeledEdit;
    lblDiet: TLabel;
    cbxDiet: TComboBox;
    lblControl: TLabel;
    cbxControl: TComboBox;
    lblAvgNumReadPerDay: TLabel;
    cbxAvgNumReadPerDay: TEdit;
    rdgrbxStandardExamDate: TRadioGroup;
    rdgrbxDiabeticExamDate: TRadioGroup;
    lblDrug: TLabel;
    cbxDrug: TComboBox;
    lbledtDosage: TLabeledEdit;
    jvspnbtnDosage: TJvSpinButton;
    cbxUnits: TComboBox;
    lblUnits: TLabel;
    lblDispenceTime: TLabel;
    btnAddDrug: TBitBtn;
    btnDeleteDrug: TBitBtn;
    sgDiabetic: TJvStringGrid;
    sgStandard: TJvStringGrid;
    sgDrug: TJvStringGrid;
    grbxExamDate: TGroupBox;
    btnDelete: TBitBtn;
    btnCustAdd: TButton;
    custCol1: TLabeledEdit;
    custVal1: TEdit;
    custCol2: TLabeledEdit;
    custVal2: TEdit;
    custCol3: TLabeledEdit;
    custVal3: TEdit;
    custCol4: TLabeledEdit;
    custVal4: TEdit;
    custCol5: TLabeledEdit;
    custVal5: TEdit;
    cbxDispenceTime: TDateTimePicker;
    cbCervical: TLabeledEdit;
    dtpicrExamDate: TDateTimePicker;
    dtpicrExamTime: TDateTimePicker;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    btnEditMode: TBitBtn;
    btnAddRow: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmbHeartChange(Sender: TObject);
    procedure jvspnbtnDosageBottomClick(Sender: TObject);
    procedure jvspnbtnDosageTopClick(Sender: TObject);
    procedure btnAddDrugClick(Sender: TObject);
    procedure btnDeleteDrugClick(Sender: TObject);
    procedure rdgrbxStandardExamDateClick(Sender: TObject);
    procedure rdgrbxDiabeticExamDateClick(Sender: TObject);
    procedure sgDrugCustomCompare(Sender: TObject; str1, str2: string; var Res: Integer);
    procedure btnEditModeClick(Sender: TObject);
    procedure pgcOBFlowChange(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteRowClick(Sender: TObject);
    procedure btnCustAddClick(Sender: TObject);
    procedure sgStandardSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDiabeticSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDrugSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridSortColumn(Sender: TJvStringGrid; AColumn, ARow: Integer);
    procedure FormShow(Sender: TObject);
    procedure btnAddRowClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure DialogClose(Sender: TObject; var Action: TCloseAction);
  private
    AscendingS,AscendingD: Boolean;
    procedure SetValuesForDate(Date: string);
    procedure ClearDrugs;
    procedure ClearInputValues;
    procedure HideCustom;
    procedure GetNoteText(var NoteText: TStringList);
    procedure SaveRow;
    function CustomColumn(cText,cVal: string): Boolean;
    function ValidateSave: boolean;
    function IsColumnEmpty(Grid: TJvStringGrid; Ic: Integer): Boolean;
    function GetExamDateTime: string;
  public
  end;

var
  dlgOBSpread: TdlgOBSpread;

implementation

{$R *.dfm}

uses
  uCommon;

procedure TdlgOBSpread.FormCreate(Sender: TObject);
var
  I: Integer;
begin
//  onDialogClose := DialogClose;

  rdgrbxStandardExamDate.ItemIndex := 0;
  rdgrbxDiabeticExamDate.ItemIndex := 0;

  if sgDiabetic.Cells[0,1] = '' then
  begin
    sgDiabetic.Cells[0,0] := 'Date';
    sgDiabetic.Cells[1,0] := 'Avg. FBS';
    sgDiabetic.Cells[2,0] := 'Avg. # Read/Day';
    sgDiabetic.Cells[3,0] := 'Avg. Post Prandial';
    sgDiabetic.Cells[4,0] := 'Diet (kcal)';
    sgDiabetic.Cells[5,0] := 'Control';
  end;

  for I := 0 to sgDiabetic.ColCount - 1 do
    sgDiabetic.AutoSizeCol(I,70,10);

  if sgDrug.Cells[0,1] = '' then
  begin
    sgDrug.Cells[0,0] := 'Drug';
    sgDrug.Cells[1,0] := 'Dosage';
    sgDrug.Cells[2,0] := 'Units';
    sgDrug.Cells[3,0] := 'Dispense Time';
  end;

  for I := 0 to sgDrug.ColCount - 1 do
    sgDrug.AutoSizeCol(I,70,10);

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

  for I := 0 to sgStandard.ColCount - 1 do
    sgStandard.AutoSizeCol(I,70,10);

  dtpicrExamDate.Date := Now;
  dtpicrExamTime.Time := Now;
  dtpicrExamDate.MaxDate := Now;

  pgcOBFlow.ActivePageIndex := 0;
end;

procedure TdlgOBSpread.FormShow(Sender: TObject);
begin
  ClearInputValues;
end;

function TdlgOBSpread.ValidateSave;
begin
  Result := true;
  if pgcOBFlow.ActivePageIndex = 0 then
  begin
    if (lbledtAge.Text = '') or (lbledtAge.Text = '0') then
    begin
      MessageDlg('You did not enter Age(weeks)', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      lbledtAge.SetFocus;
      Result := false;
      Exit;
    end;
    if (lbledtFndHt.Text = '') or (lbledtFndHt.Text = '0') then
    begin
      MessageDlg('You did not enter Fundal Height', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      lbledtFndHt.SetFocus;
      Result := false;
      Exit;
    end;
//    if (cbCervical.Text = '') or (cbCervical.Text = '0') then
//    begin
//      MessageDlg('You did not enter anything for Cervical Exam', mtInformation, [mbOK], 0);
//      ModalResult := mrNone;
//      cbCervical.SetFocus;
//      Result := false;
//      Exit;
//    end;
    if cmbPres.Text = '' then
    begin
      MessageDlg('You did not select anything for Presentation', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cmbPres.SetFocus;
      Result := false;
      Exit;
    end;
    if cmbFetAct.Text = '' then
    begin
      MessageDlg('You did not select Yes or No for Fetal Activity', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cmbFetAct.SetFocus;
      Result := false;
      Exit;
    end;
    if cmbProtein.Text = '' then
    begin
      MessageDlg('You did not select anything for Urine Protein', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cmbProtein.SetFocus;
      Result := false;
      Exit;
    end;
    if cmbSugar.Text = '' then
    begin
      MessageDlg('You did not select anything for Urine Glucose', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cmbSugar.SetFocus;
      Result := false;
      Exit;
    end;
    if cmbEdema.Text = '' then
    begin
      MessageDlg('You did not select anything for Edema', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cmbEdema.SetFocus;
      Result := false;
      Exit;
    end;
    if cmbHeart.Text = '' then
    begin
      MessageDlg('You did not select Yes or No for Fetal Heart', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cmbHeart.SetFocus;
      Result := false;
      Exit;
    end;
    if (leRate.Text = '') and  (cmbHeart.Text = 'Yes') then
    begin
      MessageDlg('You did not enter anything for Fetal Heart RATE', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      leRate.SetFocus;
      Result := false;
      Exit;
    end;
  end else
  if pgcOBFlow.ActivePageIndex = 1 then
  begin
    if (leAvgFBS.Text = '') or (leAvgFBS.Text = '0') then
    begin
      MessageDlg('You did not enter Avg. FBS', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      leAvgFBS.SetFocus;
      Result := False;
      Exit;
    end;
    if (cbxAvgNumReadPerDay.Text = '') or (cbxAvgNumReadPerDay.Text = '0') then
    begin
      MessageDlg('You did not enter Avg. number Read/Day', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cbxAvgNumReadPerDay.SetFocus;
      Result := False;
      Exit;
    end;
    if (leAvgPostPrandial.Text = '') or (leAvgPostPrandial.Text = '0') then
    begin
      MessageDlg('You did not enter Avg. Post Prandial', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      leAvgPostPrandial.SetFocus;
      Result := False;
      Exit;
    end;
    if (cbxDiet.Text = '') or (cbxDiet.Text = '0') then
    begin
      MessageDlg('You did not enter Diet (kcal)', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cbxDiet.SetFocus;
      Result := False;
      Exit;
    end;
    if (cbxControl.Text = '') or (cbxControl.Text = '0') then
    begin
      MessageDlg('You did not enter Control', mtInformation, [mbOK], 0);
      ModalResult := mrNone;
      cbxControl.SetFocus;
      Result := False;
      Exit;
    end;
  end;
end;

procedure TdlgOBSpread.SaveRow;
var
  NewRow,NewCol,I,Ic,ct,cCol,rCol: Integer;
  sDate: string;
  drug,drugheader: string;
  leftlength,drugct: Integer;
  customCol: TLabeledEdit;
  customVal: TEdit;
  Select: Boolean;

  function getCol(Grid: TJvStringGrid; header: string; colDefault: Integer): Integer;
  begin
    Result := Grid.Rows[0].IndexOf(header);
    if Result = -1 then
    begin
      Result := colDefault;
      Grid.InsertCol(Result);
      Grid.Cells[Result, 0] := header;
    end;
  end;

  function getCumlWt(NewWt: Integer): string;
  var
   I,beforeRow,val: Integer;
   before: TDateTime;
  begin
    Result := '0';
    before := StrToDateTime(sDate);
    for I := 1 to sgStandard.RowCount do
    begin
      if I <> NewRow then
      begin
        try
          if sgStandard.Cells[0, I] <> '' then
          begin
            if StrToDateTime(sgStandard.Cells[0, I]) < before then
            begin
              before := StrToDateTime(sgStandard.Cells[0, I]);
              beforeRow := I;
            end;
          end;
        except
        end;
      end;
    end;
    if TryStrToInt(sgStandard.Cells[getCol(sgStandard,'Weight',3), beforeRow], val) then
    Result := IntToStr(NewWt - StrToIntDef(sgStandard.Cells[getCol(sgStandard,'Weight',3), beforeRow],0));
  end;

begin
  Select := True;
  NewRow := -1;

  if pgcOBFlow.ActivePageIndex = 0 then
  begin
    // OB Exam
    sDate := GetExamDateTime;

    for I := 0 to sgStandard.RowCount - 1 do
      if sgStandard.Cells[0, I] = sDate then
      begin
        NewRow := I;
        Break;
      end;

    if NewRow = -1 then
    begin
      if ((sgStandard.RowCount = 2) and (sgStandard.Cells[0,1] = '')) then
        NewRow := 1
      else
      begin
        NewRow := sgStandard.RowCount;
        sgStandard.InsertRow(NewRow);
      end;
    end;
    sgStandard.Cells[getCol(sgStandard,'Date',0), NewRow] := sDate;

    if (Trim(lbledtAge.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Age (wks)',1), NewRow] := lbledtAge.Text;
    if (Trim(lbledtFndHt.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Fundal Height',2), NewRow] := lbledtFndHt.Text;
    if (Trim(lblWt.Text) <> '') then
    begin
      sgStandard.Cells[getCol(sgStandard,'Weight',3), NewRow] := lblWt.Text;
      sgStandard.Cells[getCol(sgStandard,'Cumulative Weight',4), NewRow] := getCumlWt(StrToIntDef(lblWt.Text,0));
    end;
    if (Trim(lblBP.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'BP',5), NewRow] := lblBP.Text;
    if (Trim(cmbFetAct.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Fetal Activity',6), NewRow] := cmbFetAct.Text;
    if (Trim(cmbProtein.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Urine Protein',7), NewRow] := cmbProtein.Text;
    if (Trim(cmbSugar.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Urine Glucose',8), NewRow] := cmbSugar.Text;
    if (Trim(cmbEdema.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Edema',9), NewRow] := cmbEdema.Text;
    if (Trim(cmbHeart.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Fetal Heart',10), NewRow] := cmbHeart.Text;
    if (Trim(cmbPres.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Presentation',11), NewRow] := cmbPres.Text;
    if (Trim(cbCervical.Text) <> '') then
      sgStandard.Cells[getCol(sgStandard,'Cervical Exam',12), NewRow] := cbCervical.Text;

    if (leRate.Visible) then
    begin
      rCol := getCol(sgStandard,'Rate 1',getCol(sgStandard,'Fetal Heart',10) + 1);
      if Trim(leRate.Text) <> '' then
        sgStandard.Cells[rCol, NewRow] := leRate.Text;
    end;
    if (leRate2.Visible) then
    begin
      rCol := getCol(sgStandard,'Rate 2',getCol(sgStandard,'Fetal Heart',10) + 2);
      if Trim(leRate2.Text) <> '' then
        sgStandard.Cells[rCol, NewRow] := leRate2.Text;
    end;
    if (leRate3.Visible) then
    begin
      rCol := getCol(sgStandard,'Rate 3',getCol(sgStandard,'Fetal Heart',10) + 3);
      if Trim(leRate3.Text) <> '' then
        sgStandard.Cells[rCol, NewRow] := leRate3.Text;
    end;

    for ct := 1 to 5 do
    begin
      customCol := TLabeledEdit(FindComponent('custCol' + IntToStr(ct)));
      if customCol <> nil then
      begin
        if customCol.Visible then
        begin
          if Trim(customCol.Text) <> '' then
          begin
            customCol.ReadOnly := True;
            cCol := getCol(sgStandard,customCol.Text,sgStandard.ColCount);
            customVal := TEdit(FindComponent('custVal' + IntToStr(ct)));
            if customVal <> nil then
              sgStandard.Cells[cCol, NewRow] := customVal.Text;
          end;
        end;
      end;
    end;

    for I := 0 to sgStandard.ColCount - 1 do
      sgStandard.AutoSizeCol(I,70,10);

    sgStandardSelectCell(nil, 1, NewRow, Select);
  end else
  begin
    // Diabetic Exam
    sDate := GetExamDateTime;

    for I := 0 to sgDiabetic.RowCount - 1 do
    if sgDiabetic.Cells[0, I] = sDate then
    begin
      NewRow := I;
      Break;
    end;
    if NewRow = -1 then
    begin
      if ((sgDiabetic.RowCount = 2) and (sgDiabetic.Cells[0,1] = '')) then
        NewRow := 1
      else
      begin
        NewRow := sgDiabetic.RowCount;
        sgDiabetic.InsertRow(NewRow);
      end;
    end;
    sgDiabetic.Cells[getCol(sgDiabetic,'Date',0), NewRow] := sDate;

    if (Trim(leAvgFBS.Text) <> '') then
      sgDiabetic.Cells[getCol(sgDiabetic,'Avg. FBS',1), NewRow] := leAvgFBS.Text;
    if (Trim(cbxAvgNumReadPerDay.Text) <> '') then
      sgDiabetic.Cells[getCol(sgDiabetic,'Avg. # Read/Day',2), NewRow] := cbxAvgNumReadPerDay.Text;
    if (Trim(leAvgPostPrandial.Text) <> '') then
      sgDiabetic.Cells[getCol(sgDiabetic,'Avg. Post Prandial',3), NewRow] := leAvgPostPrandial.Text;
    if (Trim(cbxDiet.Text) <> '') then
      sgDiabetic.Cells[getCol(sgDiabetic,'Diet (kcal)',4), NewRow] := cbxDiet.Text;
    if (Trim(cbxControl.Text) <> '') then
      sgDiabetic.Cells[getCol(sgDiabetic,'Control',5), NewRow] := cbxControl.Text;

    for I := sgDiabetic.ColCount - 1 downto 6 do
    begin
      sgDiabetic.Cells[I, NewRow] := '';

      if IsColumnEmpty(sgDiabetic, I) then
        sgDiabetic.RemoveCol(I);
    end;

    for I := sgDrug.RowCount - 1 downto 1 do
    begin
      drug := Trim(sgDrug.Cells[0, I]);
      if drug <> '' then
      begin
        drugheader := drug + ' Admin. ';
        drugct := 1;
        leftlength := Length(drugheader);

        for Ic := sgDiabetic.ColCount - 1 downto 6 do
        begin
          if AnsiLeftStr(sgDiabetic.Cells[Ic, 0], leftlength) = drugheader then
          begin
            if sgDiabetic.Cells[Ic, NewRow] = '' then
              drugct := StrToIntDef(AnsiRightStr(sgDiabetic.Cells[Ic, 0], Length(sgDiabetic.Cells[Ic, 0]) - leftlength),0);
          end;
        end;

        sgDiabetic.Cells[getCol(sgDiabetic,drugheader + IntToStr(drugct),sgDiabetic.ColCount), NewRow] :=
        Trim(sgDrug.Cells[1, I]) + ' ' + Trim(sgDrug.Cells[2, I]) + ' ' + Trim(sgDrug.Cells[3, I]);
      end;
    end;

    for I := 0 to sgDiabetic.ColCount - 1 do
      sgDiabetic.AutoSizeCol(I,70,10);

    sgDiabeticSelectCell(nil, 1, NewRow, Select);
  end;
end;

procedure TdlgOBSpread.btnAddRowClick(Sender: TObject);
begin
  if ValidateSave then
    SaveRow;
end;

procedure TdlgOBSpread.bbtnOKClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    if not ValidateSave then
    begin
      if MessageDlg('The input data has not been completed - continue without adding a new row?',mtWarning,mbOKCancel,0) = mrOk then
      begin
        GetNoteText(sl);
        TmpStrList.AddStrings(sl);
        ModalResult := mrOk;
      end else
        Exit;
    end else
    begin
      SaveRow;
      GetNoteText(sl);
      TmpStrList.AddStrings(sl);
      ModalResult := mrOk;
    end;
  finally
    sl.Free;
  end;
end;

procedure TdlgOBSpread.DialogClose(Sender: TObject; var Action: TCloseAction);
begin
  if btnEditMode.Caption <> 'Enable Edit Mode' then
    btnEditModeClick(Sender)
  else
    ClearInputValues;
end;

procedure TdlgOBSpread.btnCustAddClick(Sender: TObject);
var
  I: Integer;
  customCol: TLabeledEdit;
  customVal: TEdit;
begin
  for I := 1 to 5 do
  begin
    customCol := TLabeledEdit(FindComponent('custCol' + IntToStr(I)));
    if customCol <> nil then
    begin
      if not customCol.Visible then
      begin
        customCol.Visible := True;
        customVal := TEdit(FindComponent('custVal' + IntToStr(I)));
        if customVal <> nil then
          customVal.Visible := True;

        Break;
      end;
    end;
  end;
end;

procedure TdlgOBSpread.btnAddDrugClick(Sender: TObject);
var
  CurRow,I: Integer;
  FormatSettings: TFormatSettings;
begin
  if cbxDrug.Text = '' then
  begin
    MessageDlg('You did not enter Drug', mtInformation, [mbOK], 0);
    Exit;
  end;
  if ((lbledtDosage.Text = '') or (lbledtDosage.Text = '0')) then
  begin
    MessageDlg('You did not enter Dosage', mtInformation, [mbOK], 0);
    Exit;
  end;
  if cbxUnits.Text = '' then
  begin
    MessageDlg('You did not enter Units', mtInformation, [mbOK], 0);
    Exit;
  end;

  if sgDrug.Cells[0,1] = '' then
  CurRow := 1
  else
  begin
    CurRow := sgDrug.RowCount;
    sgDrug.InsertRow(CurRow);
  end;

  sgDrug.Cells[0,CurRow] := cbxDrug.Text;
  sgDrug.Cells[1,CurRow] := lbledtDosage.Text;
  sgDrug.Cells[2,CurRow] := cbxUnits.Text;

  FormatSettings := TFormatSettings.Create;
  FormatSettings.LongTimeFormat := 'hh:mm ampm';
  sgDrug.Cells[3,CurRow] := TimeToStr(cbxDispenceTime.Time, FormatSettings);

  for I := 0 to sgDrug.ColCount - 1 do
  sgDrug.AutoSizeCol(I,70,10);
end;

procedure TdlgOBSpread.ClearDrugs;
var
  I,nI: Integer;
begin
  for I := sgDrug.RowCount - 1 downto 1 do
  begin
    if ((sgDrug.RowCount = 2) and (I = 1)) then
    begin
    for nI := 0 to sgDrug.ColCount - 1 do
    sgDrug.Cells[nI, I] := '';
    end else
    sgDrug.RemoveRow(I);
  end;
end;

procedure TdlgOBSpread.btnDeleteDrugClick(Sender: TObject);
var
  I: Integer;
  Select: Boolean;
begin
  if sgDrug.Row < 1 then Exit;

  if sgDrug.Row <> 0 then
  begin
    if ((sgDrug.RowCount = 2) and (sgDrug.Row = 1)) then
    begin
      for I := 0 to sgDrug.ColCount - 1 do
      sgDrug.Cells[I, sgDrug.Row] := '';
    end else
    sgDrug.RemoveRow(sgDrug.Row);
  end;

  Select := True;
  sgDrugSelectCell(Sender, 0, 1, Select);
end;

function TdlgOBSpread.IsColumnEmpty(Grid: TJvStringGrid; Ic: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := Grid.RowCount - 1 downto 1 do
  begin
    if Grid.Cells[Ic, I] <> '' then Result := False;
    if Grid.Name = 'sgStandard' then
    begin
      if MatchStr(Grid.Cells[Ic, 0], ['Date','Age (wks)','Fundal Height','Weight','Cumulative Weight','BP','Fetal Activity',
                                      'Urine Protein','Urine Glucose','Edema','Fetal Heart','Presentation','Cervical Exam']) then
      Result := False;
    end;
  end;
end;

function TdlgOBSpread.GetExamDateTime: string;
begin
  Result := '';

  if (btnEditMode.Caption = 'Enable Edit Mode') then
    Result := FormatDateTime('MM/dd/yyyy',Now - rdgrbxStandardExamDate.ItemIndex) + ' 00:00'
  else
    Result := FormatDateTime('MM/dd/yyyy',dtpicrExamDate.Date) + ' ' + FormatDateTime('HH:mm', dtpicrExamTime.Time);
end;

procedure TdlgOBSpread.btnDeleteRowClick(Sender: TObject);
var
  Grid: TJvStringGrid;
  I,ct: Integer;
label
  StandardRestart;
begin
  if pgcOBFlow.ActivePageIndex = 0 then
  Grid := sgStandard
  else Grid := sgDiabetic;

  if Grid.Row < 1 then Exit;

  if MessageDlg('Are you sure you want to delete the entire selected table row?',
                 mtWarning, mbYesNo, 0) = mrYes then
  begin
    if Grid.Row <> 0 then
    begin
      if ((Grid.RowCount = 2) and (Grid.Row = 1)) then
      begin
        for ct := 0 to Grid.ColCount - 1 do
        Grid.Cells[ct, Grid.Row] := '';
      end else
      Grid.RemoveRow(Grid.Row);
    end;

    if Grid.Name = 'sgStandard' then
    begin
      StandardRestart:
      for I := 0 to Grid.ColCount - 1 do
      if IsColumnEmpty(Grid, I) then
      begin
        Grid.RemoveCol(I);
        goto StandardRestart;
      end;
    end else
    begin
      for I := Grid.ColCount - 1 downto 6 do
      if IsColumnEmpty(Grid, I) then
      Grid.RemoveCol(I);

      ClearDrugs;
    end;

    ClearInputValues;
  end;
end;

procedure TdlgOBSpread.btnEditClick(Sender: TObject);
begin
  SetValuesForDate(GetExamDateTime);
end;

procedure TdlgOBSpread.btnEditModeClick(Sender: TObject);
var
  EditRow: Boolean;
begin
  if (btnEditMode.Caption = 'Enable Edit Mode') then
  begin
    btnEditMode.Caption := 'Disable Edit Mode';
    rdgrbxDiabeticExamDate.Visible := False;
    rdgrbxStandardExamDate.Visible := False;
    grbxExamDate.Visible := True;
    pgcOBFlowChange(self);
    btnCustAdd.Visible := True;
    lblWt.ReadOnly := False;
    lblBP.ReadOnly := False;
    btnAddRow.Visible := True;

    EditRow := True;
    if pgcOBFlow.ActivePageIndex = 0 then
    begin
      if sgStandard.Row > 0 then
        sgStandardSelectCell(sgStandard,sgStandard.Col,sgStandard.Row,EditRow);
    end else
    begin
      if sgDiabetic.Row > 0 then
        sgDiabeticSelectCell(sgDiabetic,sgDiabetic.Col,sgDiabetic.Row,EditRow);
    end;

  end
  else
  begin
    btnEditMode.Caption := 'Enable Edit Mode';
    rdgrbxDiabeticExamDate.Visible := True;
    rdgrbxStandardExamDate.Visible := True;
    rdgrbxStandardExamDate.ItemIndex := 0;
    grbxExamDate.Visible := False;
    btnCustAdd.Visible := False;
    ClearInputValues;
    lblWt.ReadOnly := True;
    lblBP.ReadOnly := True;
    btnAddRow.Visible := False;
  end;
end;

procedure TdlgOBSpread.cmbHeartChange(Sender: TObject);
label
 one, two, three;
begin
  leRate3.Visible := False;
  leRate2.Visible := False;
  leRate.Visible := False;
  cmbHeart.ItemIndex := cmbHeart.Items.IndexOf(cmbHeart.Text);
  if (cmbHeart.ItemIndex > 0) then
  begin
   case cmbHeart.ItemIndex of
     1: goto one;
     2: goto two;
     3: goto three;
   end;
    three: leRate3.Visible := True;
    two:   leRate2.Visible := True;
    one:   leRate.Visible  := True;
  end;
  if cmbHeart.Text = 'Yes' then
  begin
    leRate.Visible := True;
    leRate.SetFocus;
  end
  else if cmbHeart.Text = 'No' then
  begin
    leRate.Visible := False;
    leRate.Clear
  end;
end;

procedure TdlgOBSpread.GetNoteText(var NoteText: TStringList);
var
  bGridEmpty: boolean;
  cntr: integer;
  I: integer;
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

  bGridEmpty := True;
  cntr := 0;
  while ((cntr < sgDiabetic.ColCount) and (bGridEmpty)) do
  begin
    I := 1;
    while ((I < sgDiabetic.RowCount) and (bGridEmpty)) do
    begin
      if sgDiabetic.Cells[cntr,I] <> '' then
      bGridEmpty := false
      else
      inc(I);
    end;
    inc(cntr);
  end;

  if not bGridEmpty then
  begin
    slTemp.Clear;
    slHeader.Clear;
    if sgDiabetic.Cols[0].Count > 1 then
    begin
      NoteText.Add('');
      NoteText.Add('');
      NoteText.Add('DIABETIC FLOW SHEET:');
      for cntr := 0 to sgDiabetic.Rows[0].Count - 1 do
        slTemp.Add('| ');
      row_ptr := 0;
      row_width := 0;
      for cntr := 0 to sgDiabetic.Rows[0].Count - 1 do
      begin
       if (row_width < Length(Trim(sgDiabetic.Cells[cntr, row_ptr]))) then
        row_width := Length(Trim(sgDiabetic.Cells[cntr, row_ptr]));
      end;
      if (row_ptr = 0) then
       header_width := row_width + 3;
      for cntr := 0 to sgDiabetic.Rows[0].Count - 1 do
      begin
        sVal := Trim(sgDiabetic.Cells[cntr, row_ptr]);
        while Length(sVal) < row_width do
         sVal := sVal + ' ';
         slTemp[cntr] := slTemp[cntr] + sVal + ' | ';
        if row_ptr = 0 then
          slHeader.Add(sVal);
      end;
      for row_ptr := sgDiabetic.Cols[0].Count - 1 downto 1 do
      begin
        row_width := 0;
        for cntr := 0 to sgDiabetic.Rows[0].Count - 1 do
        begin
         if (row_width < Length(Trim(sgDiabetic.Cells[cntr, row_ptr]))) then
          row_width := Length(Trim(sgDiabetic.Cells[cntr, row_ptr]));
        end;
        if (row_ptr = 0) then
         header_width := row_width + 3;
        if (Length(slTemp[0]) + row_width + 3 > 70) then
        begin

          // Row Lines
          sVal := '|-';
          while Length(sVal) < Length(slTemp[0]) do
          sVal := sVal + '-';
          for cntr := sgDiabetic.Rows[0].Count downto 1 do
          slTemp.Insert(cntr,sVal);

          NoteText.AddStrings(slTemp);
          NoteText.Add('');
          NoteText.Add('');
          NoteText.Add('DIABETIC FLOW SHEET (cont.):');
          slTemp.Clear;
          for cntr := 0 to sgDiabetic.Rows[0].Count - 1 do
          slTemp.Add('| ' +  slHeader[cntr] + ' | ');
        end;
        for cntr := 0 to sgDiabetic.Rows[0].Count - 1 do
        begin
          sVal := Trim(sgDiabetic.Cells[cntr, row_ptr]);
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
      for cntr := sgDiabetic.Rows[0].Count downto 1 do
      slTemp.Insert(cntr,sVal);

      if Length(slTemp[0]) > 2 + header_width then
      NoteText.AddStrings(slTemp)
      else
      begin
        NoteText.Delete(NoteText.Count-1);
        NoteText.Delete(NoteText.Count-1);
        NoteText.Delete(NoteText.Count-1);
      end;
    end;
  end;
  slTemp.Free;
  slHeader.Free;
end;

procedure TdlgOBSpread.GridSortColumn(Sender: TJvStringGrid; AColumn,
  ARow: Integer);
begin
  if not (Sender is TJvStringGrid) then
    Exit;
  if ARow <> 0 then
    Exit;

  if TJvStringGrid(Sender).Name = 'sgStandard' then
  begin
    AscendingS := not AscendingS;
    TJvStringGrid(Sender).SortGrid(AColumn, AscendingS, True, stAutomatic, True);
  end else
  begin
    AscendingD := not AscendingD;
    TJvStringGrid(Sender).SortGrid(AColumn, AscendingD, True, stAutomatic, True);
  end;
end;

procedure TdlgOBSpread.SetValuesForDate(Date: string);
var
  row_ptr,col_ptr,I,nI: integer;
  sTmp,sTime: string;
  customCol: TLabeledEdit;
  customVal: TEdit;

  procedure CBSelect(CB: TComboBox; val: string);
  var
    I: Integer;
  begin
    for I := 0 to CB.Items.Count do
      if CB.Items[I] = val then
      begin
        CB.ItemIndex := I;
        Break;
      end;
  end;

begin
  ClearInputValues;

  if pgcOBFlow.ActivePageIndex = 0 then
  begin

    //Standard
    row_ptr := sgStandard.Cols[0].IndexOf(Date);
    if (row_ptr <> -1) then
    begin
      col_ptr := sgStandard.Rows[0].IndexOf('Fetal Heart');
      if (col_ptr <> -1) then
      begin
        CBSelect(cmbHeart,sgStandard.Cells[col_ptr, row_ptr]);
        cmbHeartChange(self);
      end;

      col_ptr := sgStandard.Rows[0].IndexOf('Rate 3');
      if (col_ptr <> -1) then
        leRate3.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('Rate 2');
      if (col_ptr <> -1) then
        leRate2.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('Rate 1');
      if (col_ptr <> -1) then
        leRate.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('Edema');
      if (col_ptr <> -1) then
        CBSelect(cmbEdema,sgStandard.Cells[col_ptr, row_ptr]);

      col_ptr := sgStandard.Rows[0].IndexOf('Urine Glucose');
      if (col_ptr <> -1) then
        CBSelect(cmbSugar,sgStandard.Cells[col_ptr, row_ptr]);

      col_ptr := sgStandard.Rows[0].IndexOf('Urine Protein');
      if (col_ptr <> -1) then
        CBSelect(cmbProtein,sgStandard.Cells[col_ptr, row_ptr]);

      col_ptr := sgStandard.Rows[0].IndexOf('Fetal Activity');
      if (col_ptr <> -1) then
        CBSelect(cmbFetAct,sgStandard.Cells[col_ptr, row_ptr]);

      col_ptr := sgStandard.Rows[0].IndexOf('Presentation');
      if (col_ptr <> -1) then
        CBSelect(cmbPres,sgStandard.Cells[col_ptr, row_ptr]);

      col_ptr := sgStandard.Rows[0].IndexOf('Cervical Exam');
      if (col_ptr <> -1) then
        cbCervical.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('BP');
      if (col_ptr <> -1) then
        lblBP.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('Weight');
      if (col_ptr <> -1) then
        lblWt.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('Fundal Height');
      if (col_ptr <> -1) then
        lbledtFndHt.Text := sgStandard.Cells[col_ptr, row_ptr];

      col_ptr := sgStandard.Rows[0].IndexOf('Age (wks)');
      if (col_ptr <> -1) then
        lbledtAge.Text := sgStandard.Cells[col_ptr, row_ptr];

      for I := 0 to sgStandard.ColCount - 1 do
      begin
        if not MatchStr(sgStandard.Cells[I, 0], ['Date','Age (wks)','Fundal Height','Weight','Cumulative Weight','BP','Fetal Activity',
               'Urine Protein','Urine Glucose','Edema','Fetal Heart','Rate 1','Rate 2','Rate 3','Presentation','Cervical Exam']) then
          CustomColumn(sgStandard.Cells[I, 0],sgStandard.Cells[I, row_ptr]);

      end;
    end;

  end else
  begin

    //Diabetic
    row_ptr := sgDiabetic.Cols[0].IndexOf(Date);
    if (row_ptr <> -1) then
    begin
      col_ptr := sgDiabetic.Rows[0].IndexOf('Avg. FBS');
      if (col_ptr <> -1) then
        leAvgFBS.Text := sgDiabetic.Cells[col_ptr, row_ptr];

      col_ptr := sgDiabetic.Rows[0].IndexOf('Avg. # Read/Day');
      if (col_ptr <> -1) then
        cbxAvgNumReadPerDay.Text := sgDiabetic.Cells[col_ptr, row_ptr];

      col_ptr := sgDiabetic.Rows[0].IndexOf('Avg. Post Prandial');
      if (col_ptr <> -1) then
        leAvgPostPrandial.Text := sgDiabetic.Cells[col_ptr, row_ptr];

      col_ptr := sgDiabetic.Rows[0].IndexOf('Diet (kcal)');
      if (col_ptr <> -1) then
        CBSelect(cbxDiet,sgDiabetic.Cells[col_ptr, row_ptr]);

      col_ptr := sgDiabetic.Rows[0].IndexOf('Control');
      if (col_ptr <> -1) then
        CBSelect(cbxControl,sgDiabetic.Cells[col_ptr, row_ptr]);

      ClearDrugs;

      for I := sgDiabetic.ColCount - 1 downto 6 do
      begin
        sTmp := Trim(sgDiabetic.Cells[I, row_ptr]);
        if sTmp <> '' then
        begin
          cbxDrug.Text := LeftStr(sgDiabetic.Cells[I, 0], Pos('Admin',sgDiabetic.Cells[I, 0]) - 1);
          lbledtDosage.Text := Piece(sTmp,' ',1);
          cbxUnits.Text := Piece(sTmp,' ',2);
          cbxDispenceTime.Time := StrToTime('12:00 AM');
          sTime := Copy(sTmp, Pos(Piece(sTmp,' ',2),sTmp) + Length(Piece(sTmp,' ',2)), Length(sTmp));
          try
            cbxDispenceTime.Time := StrToTime(sTime);
          except
          end;

          if ((cbxUnits.Text <> '') and (lbledtDosage.Text <> '')) then
            btnAddDrugClick(self);
        end;
      end;
    end;
  end;
end;

procedure TdlgOBSpread.sgDiabeticSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  Select: Boolean;
begin
  if (not grbxExamDate.Visible) or (sgDiabetic.Cells[0, ARow] = '') then
    Exit;

  dtpicrExamDate.Date := StrToDateTime(sgDiabetic.Cells[0, ARow]);
  dtpicrExamTime.Time := StrToDateTime(sgDiabetic.Cells[0, ARow]);

  btnEditClick(Sender);
  Select := True;

  if sgDrug.Cells[0,1] <> '' then
    sgDrugSelectCell(Sender, 0, 1, Select);
end;

procedure TdlgOBSpread.sgDrugCustomCompare(Sender: TObject; str1, str2: string;
  var Res: Integer);
var
  str1U: string;
  str2U: string;
  tmpResult: Integer;
begin
  str1U := UpperCase(Trim(str1));
  str2U := UpperCase(Trim(str2));
  if ((Pos(':',str1U) = 0) and (Pos(':',str2U) = 0) or
     (Pos(':',str1U) <> 0) and (Pos(':',str2U) <> 0)) then
  begin
    tmpResult := AnsiCompareText(str1U,str2U);
  end
  else if (Pos(':',str1U) <> 0) then
  begin
    tmpResult := 1;
  end
  else
  begin
    tmpResult := -1;
  end;
  if tmpResult > 0 then
    Res := 1
  else if tmpResult < 0 then
    Res := -1
  else
    Res := 0;
end;

procedure TdlgOBSpread.sgDrugSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  cbxDrug.Text := sgDrug.Cells[0, ARow];
  lbledtDosage.Text := sgDrug.Cells[1, ARow];
  cbxUnits.Text := sgDrug.Cells[2, ARow];
  try
    cbxDispenceTime.Time := StrToTime(sgDrug.Cells[3, ARow]);
  except
  end;
end;

procedure TdlgOBSpread.sgStandardSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (not grbxExamDate.Visible) or (sgStandard.Cells[0, ARow] = '') then
    Exit;

  dtpicrExamDate.Date := StrToDateTime(sgStandard.Cells[0, ARow]);
  dtpicrExamTime.Time := StrToDateTime(sgStandard.Cells[0, ARow]);

  btnEditClick(Sender);
end;

procedure TdlgOBSpread.jvspnbtnDosageBottomClick(Sender: TObject);
var
  tmpDosage: double;
begin
  tmpDosage := StrToFloatDef(lbledtDosage.Text,0) - 0.1;
  if (tmpDosage > 0) then
    lbledtDosage.Text := FloatToStr(tmpDosage);
end;

procedure TdlgOBSpread.jvspnbtnDosageTopClick(Sender: TObject);
var
  tmpDosage: double;
begin
  tmpDosage := StrToFloatDef(lbledtDosage.Text,0) + 0.1;
  lbledtDosage.Text := FloatToStr(tmpDosage);
end;

procedure TdlgOBSpread.pgcOBFlowChange(Sender: TObject);
var
  Select: Boolean;
begin
  Select := True;
  if pgcOBFlow.ActivePageIndex = 0 then
  begin
    grbxExamDate.Left := rdgrbxStandardExamDate.Left + 5;
    grbxExamDate.Top := rdgrbxStandardExamDate.Top + 24;
    if grbxExamDate.Visible then
      sgStandardSelectCell(Sender, 0, sgStandard.Row, Select);
  end else
  begin
    grbxExamDate.Left := rdgrbxDiabeticExamDate.Left + 5;
    grbxExamDate.Top := rdgrbxDiabeticExamDate.Top + 24;
    if grbxExamDate.Visible then
      sgDiabeticSelectCell(Sender, 0, sgDiabetic.Row, Select);
  end;
end;

procedure TdlgOBSpread.rdgrbxDiabeticExamDateClick(Sender: TObject);
begin
  rdgrbxStandardExamDate.ItemIndex := rdgrbxDiabeticExamDate.ItemIndex;
end;

procedure TdlgOBSpread.rdgrbxStandardExamDateClick(Sender: TObject);
begin
  rdgrbxDiabeticExamDate.ItemIndex := rdgrbxStandardExamDate.ItemIndex;
end;

function TdlgOBSpread.CustomColumn(cText,cVal: string): Boolean;
var
  I: Integer;
  customCol: TLabeledEdit;
  customVal: TEdit;
begin
  Result := False;

  for I := 1 to 5 do
  begin
    customCol := TLabeledEdit(FindComponent('custCol' + IntToStr(I)));
    if customCol <> nil then
    begin
      if AnsiCompareText(customCol.Text,cText) = 0 then
      begin
        Result := True;

        customVal := TEdit(FindComponent('custVal' + IntToStr(I)));
        if customVal <> nil then
        begin
          customVal.Visible := True;
          customVal.Text := cVal;
        end;

        Break;
      end;
    end;
  end;
end;

procedure TdlgOBSpread.HideCustom;
var
  I,nI: Integer;
  customCol: TLabeledEdit;
  customVal: TEdit;
begin
  for I := 1 to 5 do
  begin
    customCol := TLabeledEdit(FindComponent('custCol' + IntToStr(I)));
    if customCol <> nil then
    begin
      customCol.ReadOnly := False;
      customCol.Clear;
      customCol.Visible := False;
      customVal := TEdit(FindComponent('custVal' + IntToStr(I)));
      if customVal <> nil then
      begin
        customVal.Clear;
        customVal.Visible := False;
      end;
    end;
  end;

  for I := 0 to sgStandard.ColCount - 1 do
  begin
    if not MatchStr(sgStandard.Cells[I, 0], ['Date','Age (wks)','Fundal Height','Weight','Cumulative Weight','BP','Fetal Activity',
           'Urine Protein','Urine Glucose','Edema','Fetal Heart','Rate 1','Rate 2','Rate 3','Presentation','Cervical Exam']) then
    begin
      if not CustomColumn(sgStandard.Cells[I, 0],'') then
        for nI := 1 to 5 do
        begin
          customCol := TLabeledEdit(FindComponent('custCol' + IntToStr(nI)));
          if ((customCol <> nil) and (customCol.Text = '')) then
          begin
            customCol.Visible := True;
            customCol.Text := sgStandard.Cells[I, 0];
            customCol.ReadOnly := True;
            customVal := TEdit(FindComponent('custVal' + IntToStr(nI)));
            if customVal <> nil then
              customVal.Visible := True;
            Break;
          end;
        end;
    end;
  end;
end;

procedure TdlgOBSpread.ClearInputValues;
begin
  //  sgStandard
  lbledtAge.Text := '';
  lbledtFndHt.Text := '6';
  //lblWt.Text := '';
  //lblBP.Text := '';
  cmbFetAct.ItemIndex := -1;
  cmbFetAct.Text := '';
  cmbProtein.ItemIndex := -1;
  cmbProtein.Text := '';
  cmbSugar.ItemIndex := -1;
  cmbSugar.Text := '';
  cmbEdema.ItemIndex := -1;
  cmbEdema.Text := '';
  cmbHeart.ItemIndex := -1;
  cmbHeart.Text := '';
  cmbHeartChange(self);
  leRate.Text := '';
  leRate2.Text := '';
  leRate3.Text := '';
  cmbPres.ItemIndex := -1;
  cmbPres.Text := '';
  cbCervical.Text := '';
  HideCustom;
  //  sgDiabetic
  leAvgFBS.Text := '';
  cbxAvgNumReadPerDay.Text := '';
  leAvgPostPrandial.Text := '';
  cbxDiet.ItemIndex := -1;
  cbxDiet.Text := '';
  cbxControl.ItemIndex := -1;
  cbxControl.Text := '';
  cbxDrug.ItemIndex := -1;
  cbxDrug.Text := '';
  lbledtDosage.Text := '';
  cbxUnits.ItemIndex := -1;
  cbxUnits.Text := '';
  cbxDispenceTime.Time := StrToTime('00:00');
  //  Drugs
  ClearDrugs;
end;

end.

