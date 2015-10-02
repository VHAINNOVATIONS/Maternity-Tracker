unit NursePostartumDelivery;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Samples.Spin, System.ConvUtils, System.StdConvs, Vcl.Mask, JvExMask, JvSpin,
  Vcl.ExtCtrls, oCNTBase, uCommon, uExtndComBroker;

type
  TForm1 = class(TForm)
    ofrm1: ToForm;
    oPage1: ToPage;
    gbDeliveryMethod: TGroupBox;
    lbDeliveryMethodComplications: TLabel;
    gbVaginal: TGroupBox;
    chkVagVacuum: TCheckBox;
    chkVagForceps: TCheckBox;
    chkVagEpisiotomy: TCheckBox;
    chkVagLacerations: TCheckBox;
    chkVagVBAC: TCheckBox;
    chkVagSVD: TCheckBox;
    gbCesarean: TGroupBox;
    lbCesareanReasons: TLabel;
    lbReasonsCPrimary: TLabel;
    lbReasonsCSecondary: TLabel;
    lblReasonforCOther: TLabel;
    chkCPrimaryFor: TCheckBox;
    edtCPrimaryFor: TEdit;
    chkCUnsuccessfulVBAC: TCheckBox;
    rgincision: TRadioGroup;
    ckRepeatwoLabor: TCheckBox;
    cbReasonsCPrimary: TComboBox;
    cbReasonsCSecondary: TComboBox;
    edtReasonsCOthPrimary: TEdit;
    edtReasonsCOthSecondary: TEdit;
    rbVaginal: TRadioButton;
    rbCesarean: TRadioButton;
    gbOtherProcedures: TGroupBox;
    edtProceduresOther: TLabeledEdit;
    ckProUterineCurettage: TCheckBox;
    ckProTubalLigationatCesarean: TCheckBox;
    ckProPostpartumTubalLigation: TCheckBox;
    ckProPostpartumHysterectomy: TCheckBox;
    ckNexplanonImplant: TCheckBox;
    ckIUDInsertion: TCheckBox;
    memoDeliveryMethodComplications: TMemo;
    GroupBox3: TGroupBox;
    rbSingleton: TRadioButton;
    rbMultiple: TRadioButton;
    edtNumBabies: TSpinEdit;
    pgCtrlBaby: TPageControl;
    TsBaby1: TTabSheet;
    lblBirthweight1: TLabel;
    lblLB1: TLabel;
    lblOz1: TLabel;
    lblComplications1: TLabel;
    lblg1: TLabel;
    rgSex1: TRadioGroup;
    edtLb1: TJvSpinEdit;
    edtOz1: TJvSpinEdit;
    memComplications1: TMemo;
    rbLiving1: TRadioButton;
    rbDemised1: TRadioButton;
    edtAPGAR1: TLabeledEdit;
    ckNICU1: TCheckBox;
    edtAPGARs1: TEdit;
    edtg1: TJvSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    lblLabor: TLabel;
    lbDeliveryNotes: TLabel;
    dtMaternal: TDateTimePicker;
    edtDeliveryAt: TSpinEdit;
    cbLabor: TComboBox;
    cbAnesthesia: TComboBox;
    memoDeliveryNotes: TMemo;
    lstDelivery: TListView;
    chkAKRI: TCheckBox;
    dtDelivery: TDateTimePicker;
    ckBakri: TCheckBox;
    procedure edtDeliveryAtChange(Sender: TObject);
    procedure rbSingletonClick(Sender: TObject);
    procedure rbMultipleClick(Sender: TObject);
    procedure edtNumBabiesChange(Sender: TObject);
    procedure edtNumBabiesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLb1Change(Sender: TObject);
    procedure edtOz1Change(Sender: TObject);
    procedure rbVaginalClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateLBOZ(Sender: TObject);
    procedure Finished(Sender: TObject);
    procedure ofrm1FormShow(Sender: TObject);
  private
    rgSexlist: TList;
    rbLivingList: TList;
    rbDemisedList: TList;
    edtLBList: TList;
    edtOzList: TList;
    edtGList: TList;
    edtAPGARList: TList;
    edtAPGARsList: TList;
    ckNICUList: TList;
    memComplicationsList: Tlist;
    KeyValue: Integer;
    procedure Rebuild;
    procedure FreeTabs;
    procedure AddBabyTab;
    procedure SetPageControlTabs;
    procedure EnableDeliveryMethodControls;
    procedure OnChangeNil(J: Integer);
    procedure OnChangeRestore(J: Integer);
    procedure UpdateGrams(J: Integer);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.OnChangeNil(J: Integer);
var
  lbc,ozc,gc: TJvSpinEdit;
begin
  lbc := TJvSpinEdit(edtLBList[J]);
  ozc := TJvSpinEdit(edtOzList[J]);
   gc := TJvSpinEdit(edtGList[J]);
  lbc.OnChange := nil;
  ozc.OnChange := nil;
   gc.OnChange := nil;
end;

procedure TForm1.OnChangeRestore(J: Integer);
var
  lbc,ozc,gc: TJvSpinEdit;
begin
  lbc := TJvSpinEdit(edtLBList[J]);
  ozc := TJvSpinEdit(edtOzList[J]);
   gc := TJvSpinEdit(edtGList[J]);
  lbc.OnChange := edtLb1Change;
  ozc.OnChange := edtOz1Change;
   gc.OnChange := UpdateLBOZ;
end;

procedure TForm1.UpdateLBOZ(Sender: TObject);
var
  lb,lb2,oz: double;
  I: Integer;
begin
  if not (Sender is TJvSpinEdit) then
    Exit;

  I := TTabSheet(TJvSpinEdit(Sender).Parent).PageIndex;
  OnChangeNil(I);

  oz := Convert(TJvSpinEdit(edtGList[I]).Value, muGrams, muOunces);
  lb := Convert(TJvSpinEdit(edtGList[I]).Value, muGrams, muPounds);
  if lb >= 1 then
  begin
    lb2 := Convert(Trunc(lb), muPounds, muOunces);
     oz := oz - lb2;

    TJvSpinEdit(edtLBList[I]).Value := Convert(lb2, muOunces, muPounds);
    TJvSpinEdit(edtOzList[I]).Value := oz;
  end else
  begin
    TJvSpinEdit(edtOzList[I]).Value := oz;
    TJvSpinEdit(edtLBList[I]).Value := 0;
  end;

  OnChangeRestore(I);
end;

procedure TForm1.edtDeliveryAtChange(Sender: TObject);
begin
  if not (Sender is TSpinEdit) then
    Exit;

  if TSpinEdit(Sender).Value < 0 then
  begin
    TSpinEdit(Sender).Value := 0;
    Exit;
  end;
end;

procedure TForm1.edtLb1Change(Sender: TObject);
begin
  if not (Sender is TJvSpinEdit) then
    Exit;

  if TJvSpinEdit(Sender).Value < 0 then
  begin
    TJvSpinEdit(Sender).Value := 0;
    Exit;
  end;

  UpdateGrams(TTabSheet(TJvSpinEdit(Sender).Parent).PageIndex);
end;

procedure TForm1.edtOz1Change(Sender: TObject);
var
  lb,lb2,oz: double;
  J: Integer;
begin
  if not (Sender is TJvSpinEdit) then Exit;
  if TJvSpinEdit(Sender).Value < 0 then
  begin
    TJvSpinEdit(Sender).Value := 0;
    Exit;
  end;

  J := TTabSheet(TJvSpinEdit(Sender).Parent).PageIndex;
  UpdateGrams(J);

  lb := Convert(TJvSpinEdit(edtOzList[J]).Value, muOunces, muPounds);
  if lb >= 1 then
  begin
    lb2 := Convert(Trunc(lb), muPounds, muOunces);
     oz := TJvSpinEdit(edtOzList[J]).Value - lb2;
     lb := Convert(lb2, muOunces, muPounds);

    TJvSpinEdit(edtLBList[J]).Value := TJvSpinEdit(edtLBList[J]).Value + lb;
    TJvSpinEdit(edtOzList[J]).Value := oz;
  end;
end;

procedure TForm1.UpdateGrams(J: Integer);
var
  lbs,ozs: double;
begin
  OnChangeNil(J);

  lbs := Convert(TJvSpinEdit(edtLBList[J]).Value, muPounds, muGrams);
  ozs := Convert(TJvSpinEdit(edtOzList[J]).Value, muOunces, muGrams);
  TJvSpinEdit(edtGList[J]).Value := lbs + ozs;

  OnChangeRestore(J);
end;

procedure TForm1.edtNumBabiesChange(Sender: TObject);
begin
  if edtNumBabies.Value < 2 then
    edtNumBabies.Value := 2;

  edtNumBabies.OnChange := nil;
  if ((KeyValue <> -1) or ((edtNumBabies.Value >= 2) and (edtNumBabies.Value <= 8))) then
  begin
    if ((KeyValue <> - 1) and (KeyValue <> 0)) then
      edtNumBabies.Value := KeyValue
    else
      KeyValue := edtNumBabies.Value;

    if KeyValue < 2 then
      edtNumBabies.Value := 2;
    if KeyValue > 8 then
      edtNumBabies.Value := 8;
  end else
  begin
    if edtNumBabies.Value < 2 then
      edtNumBabies.Value := 2;
    if edtNumBabies.Value > 8 then
      edtNumBabies.Value := 8;
  end;

  edtNumBabies.OnChange := edtNumBabiesChange;

  SetPageControlTabs;
  KeyValue := -1;
end;

procedure TForm1.edtNumBabiesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key >= 98) and (Key <= 104)) then
  begin
    edtNumBabies.OnChange := nil;
    edtNumBabies.Value := (Key - 96);
    edtNumBabies.OnChange := edtNumBabiesChange;
  end;
  if ((Key >= 50) and (Key <= 56)) then
  begin
    edtNumBabies.OnChange := nil;
    edtNumBabies.Value := (Key - 48);
    edtNumBabies.OnChange := edtNumBabiesChange;
  end;
  KeyValue := edtNumBabies.Value;
end;

procedure TForm1.SetPageControlTabs;
var
  I,edtcnt,pgcnt: Integer;
begin
  edtcnt := edtNumBabies.Value;
  if  edtcnt > 8 then
    Exit;

  pgcnt := pgCtrlBaby.PageCount;
  for I := pgcnt to edtcnt - 1 do
    AddBabyTab;

  for I := 0 to pgcnt - 1 do
    pgCtrlBaby.Pages[I].TabVisible := (I<edtCnt);
end;

procedure TForm1.rbMultipleClick(Sender: TObject);
begin
  if rbMultiple.Checked then
  begin
    edtNumBabies.Visible := True;
    edtNumBabies.Value := 2;
    SetPageControlTabs;
  end;
end;

procedure TForm1.rbSingletonClick(Sender: TObject);
var
  I: integer;
begin
  if rbSingleton.Checked then
  begin
    edtNumBabies.Visible := False;
    pgCtrlBaby.Pages[0].TabVisible := True;

    for I := 1 to pgCtrlBaby.PageCount - 1 do
      pgCtrlBaby.Pages[I].TabVisible := False;
  end;
end;

procedure TForm1.AddbabyTab;
var
  vTabsheet: TTabsheet;
  vPN: string;
  rg: TRadioGroup;
  ck: TCheckBox;
  rbL,rbD: TRadioButton;
  edtlbla: TLabeledEdit;
  edtAPGARs: TEdit;
  lblBirthweightx,lblLBx,lblOzx,lblg,lblComplicationsx: TLabel;
  edtLbx,edtOzx,edtlblg: TJvSpinEdit;
  memComplicationsx: TMemo;
begin
  if rgSexlist = nil then
    Rebuild;

  vTabSheet := TTabSheet.Create(pgCtrlBaby);
  vTabsheet.PageControl := pgCtrlBaby;
  vPN := IntToStr(pgCtrlBaby.PageCount);
  vTabsheet.Caption := 'Baby '+ vPN;

  //Sex
  rg := TRadioGroup.Create(vTabsheet);
  rg.Name := 'rgSex' + vPN;
  rg.Parent := vTabsheet;
  rg.Caption := rgSex1.Caption;
  rg.Top:= rgSex1.Top;
  rg.Left := rgSex1.Left;
  rg.Height := rgSex1.Height;
  rg.Width := rgSex1.Width;
  rg.Items.Add('Male');
  rg.Items.Add('Female');
  rg.Items.Add('Unknown');
  rg.Columns := 3;
  rgSexList.Add(rg);

  //Living
  rbL := TRadioButton.Create(vTabsheet);
  rbL.Name := 'rbLiving' + vPN;
  rbL.Parent := vTabsheet;
  rbL.Caption := rbLiving1.Caption;
  rbL.Top := rbLiving1.Top;
  rbL.Left := rbLiving1.Left;
  rbL.Height := rbLiving1.Height;
  rbL.Width := rbLiving1.Width;
  rbLivingList.Add(rbL);

  //Demised
  rbD := TRadioButton.Create(vTabsheet);
  rbD.Name := 'rbDemised' + vPN;
  rbD.Parent := vTabsheet;
  rbD.Caption := rbDemised1.Caption;
  rbD.Top := rbDemised1.Top;
  rbD.Left := rbDemised1.Left;
  rbD.Height := rbDemised1.Height;
  rbD.Width := rbDemised1.Width;
  rbDemisedList.Add(rbD);

  //Birth Weight Label
  lblBirthweightx := TLabel.Create(vTabSheet);
  lblBirthweightx.Name := 'lblBirthweight'+vPN;
  lblBirthweightx.Parent := vTabSheet;
  lblBirthweightx.Caption := lblBirthweight1.Caption;
  lblBirthweightx.Top := lblBirthweight1.Top;
  lblBirthweightx.Left := lblBirthweight1.Left;
  lblBirthweightx.Height := lblBirthweight1.Height;
  lblBirthweightx.Width := lblBirthweight1.Width;

  //Birth Weight SpinEdit LBS
  edtLBx := TJvSpinEdit.Create(vTabSheet);
  edtLBx.Name := 'edtLB' + vPN;
  edtLBx.Parent := vTabSheet;
  edtLbx.ValueType := vtFloat;
  edtLBx.Value := 0;
  edtLbx.Decimal := 0;
  edtLBx.Top := edtLB1.Top;
  edtLBx.Left := edtLB1.Left;
  edtLBx.Height := edtLB1.Height;
  edtLBx.Width := edtLB1.Width;
  edtLbx.OnChange := edtLb1Change;
  edtLBList.Add(edtLBx);

  //Birth Weight lbs Label
  lblLBx := TLabel.Create(vTabSheet);
  lblLBx.Name := 'lblLB' + vPN;
  lblLBx.Parent := vTabSheet;
  lblLBx.Caption := lblLB1.Caption;
  lblLBx.Top := lblLB1.Top;
  lblLBx.Left := lblLB1.Left;
  lblLBx.Height := lblLB1.Height;
  lblLBx.Width := lblLB1.Width;

  //Birth Weight SpinEdit OZS
  edtOZx := TJvSpinEdit.Create(vTabSheet);
  edtOZx.Name := 'edtOZ' + vPN;
  edtOZx.Parent := vTabSheet;
  edtOzx.ValueType := vtFloat;
  edtOZx.Value := 0;
  edtozx.Decimal := 0;
  edtOZx.Top := edtOZ1.Top;
  edtOZx.Left := edtOZ1.Left;
  edtOZx.Height := edtOZ1.Height;
  edtOZx.Width := edtOZ1.Width;
  edtOzx.OnChange := edtOz1Change;
  edtOZList.Add(edtOZx);

  //Birth Weight ozs Label
  lblOzx := TLabel.Create(vTabSheet);
  lblOzx.Name := 'lblOz' + vPN;
  lblOzx.Parent := vTabSheet;
  lblOzx.Caption := lblOz1.Caption;
  lblOzx.Top := lblOz1.Top;
  lblOzx.Left := lblOz1.Left;
  lblOzx.Height := lblOz1.Height;
  lblOzx.Width := lblOz1.Width;

  //Birth Weight grams spinedit
  edtlblg := TJvSpinEdit.Create(vTabsheet);
  edtlblg.Name := 'edtg' + vPN;
  edtlblg.Parent := vTabsheet;
  edtlblg.ValueType := vtFloat;
  edtlblg.Value := 0;
  edtlblg.Top := edtg1.Top;
  edtlblg.Left := edtg1.Left;
  edtlblg.Height := edtg1.Height;
  edtlblg.Width := edtg1.Width;
  edtlblg.OnChange := UpdateLBOZ;
  edtGList.Add(edtlblg);

  //Birth Weight grams Label
  lblg := TLabel.Create(vTabSheet);
  lblg.Name := 'lblg' + vPN;
  lblg.Parent := vTabSheet;
  lblg.Caption := lblg1.Caption;
  lblg.Top := lblg1.Top;
  lblg.Left := lblg1.Left;
  lblg.Height := lblg1.Height;
  lblg.Width := lblg1.Width;

  //APGAR Score Part 1
  edtlbla := TLabeledEdit.Create(vTabsheet);
  edtlbla.Name := 'edtAPGAR' + vPN;
  edtlbla.Parent := vTabsheet;
  edtlbla.LabelPosition := lpLeft;
  edtlbla.EditLabel.Caption := edtAPGAR1.EditLabel.Caption;
  edtlbla.Text := '';
  edtlbla.Top := edtAPGAR1.Top;
  edtlbla.Left := edtAPGAR1.Left;
  edtlbla.Height := edtAPGAR1.Height;
  edtlbla.Width := edtAPGAR1.Width;
  edtAPGARList.Add(edtlbla);

  //APGAR Score Part 2
  edtAPGARs := TEdit.Create(vTabsheet);
  edtAPGARs.Name := 'edtAPGARs' + vPN;
  edtAPGARs.Parent := vTabsheet;
  edtAPGARs.Text := '';
  edtAPGARs.Top := edtAPGARs1.Top;
  edtAPGARs.Left := edtAPGARs1.Left;
  edtAPGARs.Height := edtAPGARs1.Height;
  edtAPGARs.Width := edtAPGARs1.Width;
  edtAPGARsList.Add(edtAPGARs);

  //NICU
  ck := TCheckBox.Create(vTabsheet);
  ck.Name := 'ckNICU' + vPN;
  ck.Parent := vTabsheet;
  ck.Caption := ckNICU1.Caption;
  ck.Top := ckNICU1.Top;
  ck.Left := ckNICU1.Left;
  ck.Height := ckNICU1.Height;
  ck.Width := ckNICU1.Width;
  ckNICUList.Add(ck);

  //Complications Memo
  memComplicationsx := TMemo.Create(vTabSheet);
  memComplicationsx.Name := 'memComplications' + vPN;
  memComplicationsx.Parent := vTabSheet;
  memComplicationsx.Top := memComplications1.Top;
  memComplicationsx.Left := memComplications1.Left;
  memComplicationsx.Height := memComplications1.Height;
  memComplicationsx.Width := memComplications1.Width;
  memComplicationsx.Lines.Clear;
  memComplicationsx.ScrollBars := ssVertical;
  memComplicationsList.Add(memComplicationsx);

  //Complications Memo Label
  lblComplicationsx := TLabel.Create(vTabSheet);
  lblComplicationsx.Name := 'lblComplications' + vPN;
  lblComplicationsx.Parent := vTabSheet;
  lblComplicationsx.Caption := lblComplications1.Caption;
  lblComplicationsx.Top := lblComplications1.Top;
  lblComplicationsx.Left := lblComplications1.Left;
  lblComplicationsx.Height := lblComplications1.Height;
  lblComplicationsx.Width := lblComplications1.Width;
end;

procedure TForm1.FreeTabs;
var
  I, counter: integer;
  vtabsheet: TTAbsheet;
begin
 counter := pgCtrlBaby.PageCount;

  for I :=  counter - 1 downto 1 do
  begin
    vTabsheet := pgCtrlBaby.Pages[I];
    vTabsheet.Free;
    vTabsheet := nil;
  end;
end;

procedure TForm1.EnableDeliveryMethodControls;
begin
  if rbCesarean.Checked then
  begin
    gbVaginal.Visible:= False;
    gbCesarean.Visible:= True;
    gbCesarean.Top := 50;
    gbCesarean.Left := 25;
  end;

  if rbVaginal.Checked then
  begin
    gbCesarean.Visible:= False;
    gbVaginal.Visible:= True;
    gbVaginal.Top := 50;
    gbVaginal.Left := 25;
  end;
end;

procedure TForm1.Finished(Sender: TObject);
var
  tmpstr,IEN: string;
  I,J: Integer;
  lvitem: TListItem;

  procedure ClearComments(LV: TListView);
  var
    I: Integer;
  begin
    for I := 0 to LV.Items.Count - 1 do
    begin
      if LV.Items.Item[I].Caption = 'C' then
      begin
        lv.Items.Item[I].Delete;
        ClearComments(LV);
        Break;
      end;
    end;
  end;

begin
  ofrm1.Validated := True;
  tmpstr := '';

  ofrm1.TmpStrList.Add('Delivery Details:');
  ofrm1.TmpStrList.Add('  Delivery Date: ' + formatdatetime('mm/dd/yyyy',dtDelivery.date));
  ofrm1.TmpStrList.Add('  Maternal Date: ' + formatdatetime('mm/dd/yyyy',dtMAternal.date));
  ofrm1.TmpStrList.Add('  Days to Delivery at '+ edtDeliveryAt.text);

  if cbLabor.ItemIndex > -1 then
    ofrm1.TmpStrList.Add('  Labor: ' + cbLabor.Text);
  if cbAnesthesia.ItemIndex > -1 then
    ofrm1.TmpStrList.Add('  Anesthesia: ' + cbAnesthesia.Text);

  if memoDeliveryNotes.Lines.Count > 0 then
  begin
    ofrm1.TmpStrList.Add('  Delivery Notes: ');
    for I := 0 to memoDeliveryNotes.Lines.Count - 1 do
      ofrm1.TmpStrList.Add('   ' + memoDeliveryNotes.Lines[I]);
  end;

  if rbVaginal.Checked then
  begin
    ofrm1.TmpStrList.Add('  Delivery Method - Vaginal: ');

    if chkVagSVD.Checked then
      ofrm1.TmpStrList.Add('  - Spontaneous Vaginal Delivery');
    if chkVagVacuum.Checked then
      ofrm1.TmpStrList.Add('  - Vacuum');
    if chkVagForceps.Checked then
      ofrm1.TmpStrList.Add('  - Forceps');
    if chkVagEpisiotomy.Checked then
      ofrm1.TmpStrList.Add('  - Episiotomy');
    if chkVagLacerations.Checked then
      ofrm1.TmpStrList.Add('  - Lacerations');
    if chkVagVBAC.Checked then
      ofrm1.TmpStrList.Add('  - Vaginal Birth after Cesarean');
    if chkAKRI.Checked then
      ofrm1.TmpStrList.Add('  - AKRI');
  end;

  if rbcesarean.Checked then
  begin
    ofrm1.TmpStrList.Add('  Delivery Method - Cesarean: ');

    if (chkCPrimaryFor.Checked) and (Trim(edtCPrimaryFor.Text) <> '') then
      ofrm1.TmpStrList.Add('   Primary ' + Trim(edtCPrimaryFor.Text));
    if ckRepeatwoLabor.Checked then
      ofrm1.TmpStrList.Add('   Repeat without Labor');
    if chkCUnsuccessfulVBAC.Checked then
      ofrm1.TmpStrList.Add('   Repeat - Unsuccessful Vaginal Birth at Cesarean');

    ofrm1.TmpStrList.Add('   Indications for Cesarean:');
    ofrm1.TmpStrList.Add('      Primary: ' + cbReasonsCPrimary.Text);
    ofrm1.TmpStrList.Add('        Other: ' + edtReasonsCOthPrimary.Text);
    ofrm1.TmpStrList.Add('    Secondary: ' + cbReasonsCSecondary.Text);
    ofrm1.TmpStrList.Add('        Other: ' + edtReasonsCOthSecondary.Text);

    if rgIncision.ItemIndex > -1 then
    begin
      tmpStr := '    Uterine Incision - ';
      if rgIncision.ItemIndex = 0  then
        tmpstr := tmpstr + 'Low Transverse'
      else if rgIncision.ItemIndex = 1  then
        tmpstr := tmpstr + 'Low Vertical'
      else if rgIncision.ItemIndex = 2  then
        tmpstr := tmpstr + 'Classical';

      ofrm1.TmpStrList.Add(tmpstr);
    end;
  end;

  ofrm1.TmpStrList.Add('  Other Procedures done during same Hospitalization:');
  if ckNexplanonImplant.Checked then
    ofrm1.TmpStrList.Add('   ' + ckNexplanonImplant.Caption);
  if ckProTubalLigationatCesarean.Checked then
    ofrm1.TmpStrList.Add('   ' + ckProTubalLigationatCesarean.Caption);
  if ckProUterineCurettage.Checked then
    ofrm1.TmpStrList.Add('   ' + ckProUterineCurettage.Caption);
  if ckProPostpartumTubalLigation.Checked then
    ofrm1.TmpStrList.Add('   ' + ckProPostpartumTubalLigation.Caption);
  if ckProPostpartumHysterectomy.Checked then
    ofrm1.TmpStrList.Add('   ' + ckProPostpartumHysterectomy.Caption);
  if ckIUDInsertion.Checked then
    ofrm1.TmpStrList.Add('   ' + ckIUDInsertion.Caption);
  if ckBakri.Checked then
    ofrm1.TmpStrList.Add('   ' + ckBakri.Caption);
  if Trim(edtProceduresOther.Text) <> '' then
    ofrm1.TmpStrList.Add('   Other: ' + edtProceduresOther.Text);

  if memoDeliveryMethodComplications.Lines.Count > 0 then
  begin
    ofrm1.TmpStrList.Add('  Complications/Anomalies: ');
    for I := 0 to memoDeliveryMethodComplications.Lines.Count - 1 do
      ofrm1.TmpStrList.Add('   ' + memoDeliveryMethodComplications.Lines[I]);
  end;

  ofrm1.TmpStrList.Add('  Neonatal Information:');
  if rbSingleton.Checked then
    ofrm1.tmpStrList.Add('   Number of Babies: 1')
  else if rbMultiple.Checked then
    ofrm1.tmpStrList.Add('   Number of Babies: ' + IntToStr(edtNumBabies.Value));

  for I := 0 to pgCtrlbaby.PageCount - 1 do
  begin
    if pgCtrlbaby.Pages[I].TabVisible then
    begin
      tmpstr := '   Baby ' + IntTostr(I+1);
      if TRadioButton(rbLivingList[I]).Checked then
        tmpstr := tmpstr + ' (Living):'
      else if TRadioButton(rbDemisedList[I]).Checked then
        tmpstr := tmpstr + ' (Demise):';

      ofrm1.TmpStrList.Add(tmpstr);
      tmpstr := '';

      if TRadioGroup(rgSexList[I]).ItemIndex = 0 then
        ofrm1.TmpStrList.add('    Gender: Male')
      else if TRadioGroup(rgSexList[I]).ItemIndex = 1 then
        ofrm1.TmpStrList.add('    Gender: Female')
      else if TRadioGroup(rgSexlist[I]).ItemIndex = 2 then
        ofrm1.TmpStrList.Add('    Gender: Unknown');

      tmpstr := '';
      if TJvSpinEdit(edtLBList[I]).Value > 0 then
        tmpstr := FloatToStr(TJvSpinEdit(edtLBList[I]).Value) + ' Lb';
      if TJvSpinEdit(edtOZList[I]).Value > 0 then
      begin
        if tmpstr <> '' then
          tmpstr := tmpstr + ' ';

        tmpstr := tmpstr + FloatToStr(TJvSpinEdit(edtOZList[I]).Value) + ' Oz';
      end;
      if tmpstr <> '' then
      begin
        tmpstr := '    Weight: ' + tmpstr + ' (' + TJvSpinEdit(edtGList[I]).Text + 'g)';
        ofrm1.TmpStrList.Add(tmpstr);
      end;

      tmpstr := '';
      if Trim(TLabeledEdit(edtAPGARList[I]).Text) <> '' then
        tmpstr := '    APGAR Score: ' + TLabeledEdit(edtAPGARList[I]).Text;
      if Trim(TEdit(edtAPGARsList[I]).Text) <> '' then
      begin
        if tmpstr <> '' then
          tmpstr := tmpstr + ' ' + TEdit(edtAPGARsList[I]).Text
        else
          tmpstr := '    APGAR Score: ' + TEdit(edtAPGARsList[I]).Text;
      end;
      if tmpstr <> '' then
        ofrm1.TmpStrList.Add(tmpstr);

      if TCheckBox(ckNICUList[I]).Checked then
        ofrm1.TmpStrList.Add('    NICU Admission: Yes')
      else
        ofrm1.TmpStrList.Add('    NICU Admission: No');

      if TMemo(memComplicationsList[I]).Lines.Count > 0 then
      begin
        ofrm1.Tmpstrlist.Add('    Complications: ');
        for J := 0 to TMemo(memComplicationsList[I]).Lines.Count - 1 do
          ofrm1.TmpStrList.Add('     ' + TMemo(memComplicationsList[I]).Lines[J]);
      end;
    end;
  end;

  //Update the DataList Control
  ClearComments(lstDelivery);

  for I := 0 to pgCtrlBaby.PageCount - 1 do
  begin
    if pgCtrlBaby.Pages[I].TabVisible then
    begin
      if lstDelivery.Items.Count - 1 < I then
        lstDelivery.Items.Add;

      for J := lstDelivery.Items.Item[I].SubItems.Count - 1 to 9 do
        lstDelivery.Items.Item[I].SubItems.Add('');

      IEN := lstDelivery.Items.Item[I].SubItems[0];

      case TRadioGroup(rgSexlist[I]).ItemIndex of                                        // Gender
        0 : lstDelivery.Items.Item[I].SubItems[3] := 'M';
        1 : lstDelivery.Items.Item[I].SubItems[3] := 'F';
        2 : lstDelivery.Items.Item[I].SubItems[3] := 'U';
      end;
                                                                                         // Birth Weight
      lstDelivery.Items.Item[I].SubItems[4] := TJvSpinEdit(edtLBList[I]).Text + '|' +
                                               TJvSpinEdit(edtOzList[I]).Text + '|' +
                                               TJvSpinEdit(edtGList[I]).Text;

      lstDelivery.Items.Item[I].SubItems[6] := TLabeledEdit(edtAPGARList[I]).Text;       // APGAR1
      lstDelivery.Items.Item[I].SubItems[7] := TLabeledEdit(edtAPGARsList[I]).Text;      // APGAR2

      if TRadioButton(rbLivingList[I]).Checked then                                      // Status
        lstDelivery.Items.Item[I].SubItems[8] := 'L'
      else if TRadioButton(rbDemisedList[I]).Checked then
        lstDelivery.Items.Item[I].SubItems[8] := 'D';

      if TCheckBox(ckNICUList[I]).Checked then                                           // NICU
          lstDelivery.Items.Item[I].SubItems[9] := '1';

      if TMemo(memComplicationsList[I]).Lines.Count > 0 then                             //COMMENTS
      begin
        for J := 0 to TMemo(memComplicationsList[I]).Lines.Count - 1 do
        begin
          lvitem := lstDelivery.Items.Add;
          lvitem.Caption := 'C';
          lvitem.SubItems.Add(IEN);
          lvitem.SubItems.Add(TMemo(memComplicationsList[I]).Lines[J]);
        end;
      end;
    end;
  end;
end;

procedure TForm1.Rebuild;
begin
  if rgSexlist = nil then
  begin
    rgSexlist := TList.Create;
    rgSexList.Add(rgSex1);
  end;
  if rbLivingList = nil then
  begin
    rbLivingList := TList.Create;
    rbLivingList.Add(rbLiving1);
  end;
  if rbDemisedList = nil then
  begin
    rbDemisedList := TList.Create;
    rbDemisedList.Add(rbDemised1);
  end;
  if edtLBList = nil then
  begin
    edtLBList := TList.Create;
    edtLBList.Add(edtLB1);
  end;
  if edtOzList = nil then
  begin
    edtOzList := TList.Create;
    edtOzList.Add(edtOz1);
  end;
  if edtGList = nil then
  begin
    edtGList := TList.Create;
    edtGList.Add(edtg1);
  end;
  if edtAPGARList = nil then
  begin
    edtAPGARList := TList.Create;
    edtAPGARList.Add(edtAPGAR1);
  end;
  if edtAPGARsList = nil then
  begin
    edtAPGARsList := TList.Create;
    edtAPGARsList.Add(edtAPGARs1);
  end;
  if ckNICUList = nil then
  begin
    ckNICUList := TList.Create;
    ckNICUList.Add(ckNICU1);
  end;
  if memComplicationsList = nil then
  begin
    memComplicationsList:= Tlist.Create;
    memComplicationsList.Add(memComplications1);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  dtDelivery.Format := 'MM/dd/yyyy';
  dtDelivery.DateTime := Now;
  dtMaternal.Format := 'MM/dd/yyyy';
  dtMaternal.DateTime := Now;

  Rebuild;

  EnableDeliveryMethodControls;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  rgSexList.Clear;
  rbLivingList.Clear;
  rbDemisedList.Clear;
  edtLBList.Clear;
  edtOzList.Clear;
  edtGList.Clear;
  edtAPGARList.Clear;
  edtAPGARsList.Clear;
  ckNICUList.Clear;
  memComplicationsList.Clear;
  FreeTabs;
end;

procedure TForm1.ofrm1FormShow(Sender: TObject);
var
  I,J,pgct,pgx: Integer;
  pg: TTabSheet;
  val: string;
  pageplace: array of string;
begin

  //  ID^IEN^NUMBER^NAME^GENDER^BIRTH WEIGHT^STILLBORN^APGAR1^APGAR2^STATUS^NICU

  for I := 0 to lstDelivery.Items.Count - 1 do
  begin
    if lstDelivery.Items.Item[I].Caption = 'L' then
    begin
      SetLength(pageplace,Length(pageplace)+1);
      pageplace[Length(pageplace)-1] := lstDelivery.Items.Item[I].SubItems[0];
    end;

    for J := lstDelivery.Items.item[I].SubItems.Count - 1 to 8 do
      lstDelivery.Items.Item[I].SubItems.Add('');
  end;
  pgct := 0;

  for I := 0 to lstDelivery.Items.Count - 1 do
  begin
    if lstDelivery.Items.Item[I].Caption = 'L' then
    begin
      inc(pgct);

      if pgct > 1 then
      begin
        rbMultiple.Checked := True;
        if pgct > 2 then
          edtNumBabies.Value := edtNumBabies.Value + 1;
      end;

      pgx := pgCtrlBaby.PageCount-1;
      pg := pgCtrlBaby.Pages[pgx];

      for J := 0 to lstDelivery.Items.Item[I].SubItems.Count - 1 do
      begin
        val := lstDelivery.Items.Item[I].SubItems[J];
        if val <> '' then
          case J of
            0 : ;                                                               // IEN
            1 : ;                                                               // Baby Number
            2 : ;                                                               // Name
            3 : begin                                                           // Gender
                  if val = 'M' then
                    TRadioGroup(rgSexlist[pgx]).ItemIndex := 0
                  else if val = 'F' then
                    TRadioGroup(rgSexlist[pgx]).ItemIndex := 1
                  else
                    TRadioGroup(rgSexlist[pgx]).ItemIndex := 2;
                end;
            4 : begin                                                           // Birth Weight
                  OnChangeNil(pgx);

                  TJvSpinEdit(edtLBList[pgx]).Value := StrToIntDef(Piece(val,'|',1),0);
                  TJvSpinEdit(edtOzList[pgx]).Value := StrToIntDef(Piece(val,'|',2),0);

                  OnChangeRestore(pgx);
                  UpdateGrams(pgx);
                end;
            5 : if val = '1' then                                               // StillBorn
                  TRadioButton(rbDemisedList[pgx]).Checked := True;
            6 : TLabeledEdit(edtAPGARList[pgx]).Text := val;                    // APGAR1
            7 : TLabeledEdit(edtAPGARsList[pgx]).Text := val;                   // APGAR2
            8 : begin                                                           // Status
                  if val = 'L' then
                    TRadioButton(rbLivingList[pgx]).Checked := True
                  else if val = 'D' then
                    TRadioButton(rbDemisedList[pgx]).Checked := True;
                end;
            9 : if val = '1' then
                  TCheckBox(ckNICUList[pgx]).Checked := True;                   // NICU
          end;
      end;
    end else if lstDelivery.Items.Item[I].Caption = 'C' then
    begin
      for J := 0 to Length(pageplace) - 1 do
      begin
        if pageplace[J] = lstDelivery.Items.Item[I].SubItems[0] then
        begin
          pg := pgCtrlBaby.Pages[J];
          if pg <> nil then
            TMemo(memComplicationsList[J]).Lines.Add(lstDelivery.Items.Item[I].SubItems[1]);

          Break;
        end;
      end;
    end;
  end;

  SetLength(pageplace,0);
end;

procedure TForm1.rbVaginalClick(Sender: TObject);
begin
  EnableDeliveryMethodControls;
end;

end.
