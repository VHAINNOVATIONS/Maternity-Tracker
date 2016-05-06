unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.Mask, System.ConvUtils, System.StdConvs, ORCtrls, ORDtTm, uBase;

type
  TForm1 = class(TForm)
    DDCSForm1: TDDCSForm;
    oPage1: TTabSheet;
    oPage2: TTabSheet;
    oPage3: TTabSheet;
    oPage4: TTabSheet;
    lbDeliveryDate: TStaticText;
    lbDischargeDate: TStaticText;
    lbDaysIn: TStaticText;
    lbAnesthesia: TStaticText;
    lbLabor: TStaticText;
    lbDeliveryNotes: TStaticText;
    lbGestationalAge: TStaticText;
    lbLaborLength: TStaticText;
    lbDeliveryPlace: TStaticText;
    lbOutcome: TStaticText;
    dtDelivery: TORDateBox;
    dtMaternal: TORDateBox;
    edtDeliveryAt: TSpinEdit;
    cbAnesthesia: TCaptionComboBox;
    cbLabor: TCaptionComboBox;
    meDeliveryNotes: TCaptionMemo;
    rgPretermDelivery: TRadioGroup;
    spnLaborLength: TSpinEdit;
    spnGADays: TSpinEdit;
    spnGAWeeks: TSpinEdit;
    cbDeliveryPlace: TCaptionComboBox;
    cbOutcome: TCaptionComboBox;
    pgBaby: TPageControl;
    TsBaby1: TTabSheet;
    lbBirthWeight1: TStaticText;
    lbComplications1: TStaticText;
    lbg1: TStaticText;
    rgSex1: TRadioGroup;
    spnLb1: TSpinEdit;
    spnOz1: TSpinEdit;
    meComplications1: TCaptionMemo;
    edAPGARone1: TCaptionEdit;
    ckNICU1: TCheckBox;
    edAPGARfive1: TCaptionEdit;
    spng1: TSpinEdit;
    pnlBirthCount: TPanel;
    gbCesarean: TGroupBox;
    lbCesareanReasons: TStaticText;
    lbReasonsCPrimary: TStaticText;
    lbReasonsCSecondary: TStaticText;
    lbReasonforCOther: TStaticText;
    ckCPrimaryFor: TCheckBox;
    edCPrimaryFor: TCaptionEdit;
    ckCUnsuccessfulVBAC: TCheckBox;
    rgIncision: TRadioGroup;
    ckRepeatwoLabor: TCheckBox;
    cbReasonsCPrimary: TCaptionComboBox;
    cbReasonsCSecondary: TCaptionComboBox;
    edReasonsCOthPrimary: TCaptionEdit;
    edReasonsCOthSecondary: TCaptionEdit;
    gbOtherProcedures: TGroupBox;
    edProceduresOther: TCaptionEdit;
    ckProUterineCurettage: TCheckBox;
    ckProTubalLigationatCesarean: TCheckBox;
    ckProPostpartumTubalLigation: TCheckBox;
    ckProPostpartumHysterectomy: TCheckBox;
    ckNexplanonImplant: TCheckBox;
    ckIUDInsertion: TCheckBox;
    ckBakri: TCheckBox;
    gbVaginal: TGroupBox;
    ckVagVacuum: TCheckBox;
    ckVagForceps: TCheckBox;
    ckVagEpisiotomy: TCheckBox;
    ckVagLacerations: TCheckBox;
    ckVagVBAC: TCheckBox;
    ckVagSVD: TCheckBox;
    ckDeliveryMethodV: TCheckBox;
    ckDeliveryMethodC: TCheckBox;
    lstDelivery: TListView;
    lbAPGAR1: TStaticText;
    spnBirthCount: TSpinEdit;
    lbBirthCount: TStaticText;
    lbProceduresOther: TStaticText;
    pnlSpacer: TPanel;
    StaticText1: TStaticText;
    lbOz1: TStaticText;
    ckLiving1: TCheckBox;
    ckDemise1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinCheck(Sender: TObject);
    procedure RadioGroupEnter(Sender: TObject);
    procedure spnGADaysChange(Sender: TObject);
    procedure spnBirthCountChange(Sender: TObject);
    procedure spnLb1Change(Sender: TObject);
    procedure spnOz1Change(Sender: TObject);
    procedure UpdateLBOZ(Sender: TObject);
    procedure CheckBoxCheckClick(Sender: TObject);
    procedure Finished(Sender: TObject);
  private
    rgSexlist,ckLivingList,ckDemisedList,spnLBList,spnOzList,spnGList: TList;
    edAPGARoneList,edAPGARfiveList,ckNICUList,meComplicationsList: Tlist;
    BirthCount: Integer;
    pgIENs: array of string;
    procedure Rebuild;
    procedure AddBaby;
    procedure RemoveBaby;
    procedure UpdateGrams(I: Integer);
    procedure OnChangeNil(I: Integer);
    procedure OnChangeRestore(I: Integer);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  VAUtils, uExtndComBroker;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BirthCount := 1;

  Rebuild;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  I,J,pgct,pgx,tVal: Integer;
  pageplace: array of string;
  val: string;
begin
  oPage4.TabVisible := False;
  //  ID^IEN^NUMBER^NAME^GENDER^BIRTH WEIGHT^STILLBORN^APGAR1^APGAR2^STATUS^NICU

  for I := 0 to lstDelivery.Items.Count - 1 do
  begin
    if lstDelivery.Items.Item[I].Caption = 'L' then
    begin
      SetLength(pageplace,Length(pageplace)+1);
      pageplace[Length(pageplace) - 1] := lstDelivery.Items.Item[I].SubItems[0];
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

      spnBirthCount.Value := pgct;

      pgx := pgBaby.PageCount - 1;
      SetLength(pgIENs, pgBaby.PageCount);

      for J := 0 to lstDelivery.Items.Item[I].SubItems.Count - 1 do
      begin
        val := lstDelivery.Items.Item[I].SubItems[J];
        if val <> '' then
          case J of
            0 : pgIENs[pgx] := val;                                             // IEN
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
            4 : begin                                                           // Birth Weight in grams
                  OnChangeNil(pgx);

                  if TryStrToInt(val, tVal) then
                    TSpinEdit(spnGList[pgx]).Value := tVal;

                  OnChangeRestore(pgx);
                  UpdateLBOZ(TSpinEdit(spnGList[pgx]));
                end;
            5 : if val = '1' then                                               // StillBorn
                  TCheckBox(ckDemisedList[pgx]).Checked := True;
            6 : TLabeledEdit(edAPGARoneList[pgx]).Text := val;                  // APGAR1
            7 : TLabeledEdit(edAPGARfiveList[pgx]).Text := val;                 // APGAR2
            8 : begin                                                           // Status
                  if val = 'L' then
                    TCheckBox(ckLivingList[pgx]).Checked := True
                  else if val = 'D' then
                    TCheckBox(ckDemisedList[pgx]).Checked := True;
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
          if J <= pgBaby.PageCount - 1 then
            TCaptionMemo(meComplicationsList[J]).Lines.Add(lstDelivery.Items.Item[I].SubItems[1]);

          Break;
        end;
      end;
    end;
  end;

  SetLength(pageplace, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SetLength(pgIENs, 0);
  rgSexList.Free;
  ckLivingList.Free;
  ckDemisedList.Free;
  spnLBList.Free;
  spnOzList.Free;
  spnGList.Free;
  edAPGARoneList.Free;
  edAPGARfiveList.Free;
  ckNICUList.Free;
  meComplicationsList.Free;
end;

procedure TForm1.SpinCheck(Sender: TObject);
begin
  if not (Sender is TSpinEdit) then
    Exit;

  if TSpinEdit(Sender).Value < 0 then
    TSpinEdit(Sender).Value := 0;
end;

procedure TForm1.RadioGroupEnter(Sender: TObject);
begin
  if not (Sender is TRadioGroup) then
    Exit;

  if TRadioGroup(Sender).ItemIndex = -1 then
  begin
    TRadioGroup(Sender).ItemIndex := 0;
    TRadioButton(TRadioGroup(Sender).Controls[0]).SetFocus;
  end;
end;

procedure TForm1.spnGADaysChange(Sender: TObject);
begin
  SpinCheck(Sender);

  if spnGADays.Value > 6 then
  begin
    spnGADays.OnChange := nil;
    spnGAWeeks.Value := spnGAWeeks.Value + 1;
    spnGADays.Value := 0;
    spnGADays.OnChange := spnGADaysChange;
  end;
end;

procedure TForm1.spnBirthCountChange(Sender: TObject);
begin
  if spnBirthCount.Value < 1 then
  begin
    spnBirthCount.Value := 1;
    Exit;
  end;

  if spnBirthCount.Value = BirthCount then
    Exit;

  if spnBirthCount.Value > BirthCount then
    AddBaby
  else RemoveBaby;

  BirthCount := spnBirthCount.Value;
end;

procedure TForm1.spnLb1Change(Sender: TObject);
var
  I: Integer;
begin
  I := TTabSheet(TSpinEdit(Sender).Parent).PageIndex;
  OnChangeNil(I);
  SpinCheck(Sender);
  UpdateGrams(TTabSheet(TSpinEdit(Sender).Parent).PageIndex);
  OnChangeRestore(I);
end;

procedure TForm1.spnOz1Change(Sender: TObject);
var
  I: Integer;
  lb: double;
begin
  I := TTabSheet(TSpinEdit(Sender).Parent).PageIndex;
  OnChangeNil(I);
  SpinCheck(Sender);

  lb := Convert(TSpinEdit(spnOzList[I]).Value, muOunces, muPounds);
  if lb >= 1 then
  begin
    TSpinEdit(spnLBList[I]).Value := TSpinEdit(spnLBList[I]).Value + Trunc(lb);
    TSpinEdit(spnOzList[I]).Value := 0;
  end;

  UpdateGrams(I);
  OnChangeRestore(I);
end;

procedure TForm1.UpdateLBOZ(Sender: TObject);
var
  I: Integer;
  lb: double;
begin
  I := TTabSheet(TSpinEdit(Sender).Parent).PageIndex;
  OnChangeNil(I);
  SpinCheck(Sender);

  lb := Convert(TSpinEdit(spnGList[I]).Value, muGrams, muPounds);
  if lb >= 1 then
  begin
    TSpinEdit(spnLBList[I]).Value := Trunc(lb);
    TSpinEdit(spnOzList[I]).Value := Trunc(Convert(lb - Trunc(lb), muPounds, muOunces));
  end else
  begin
    TSpinEdit(spnLBList[I]).Value := 0;
    TSpinEdit(spnOzList[I]).Value := Trunc(Convert(TSpinEdit(spnGList[I]).Value, muGrams, muOunces));
  end;

  OnChangeRestore(I);
end;

procedure TForm1.UpdateGrams(I: Integer);
var
  lbs,ozs: double;
begin
  OnChangeNil(I);

  lbs := Convert(TSpinEdit(spnLBList[I]).Value, muPounds, muGrams);
  ozs := Convert(TSpinEdit(spnOzList[I]).Value, muOunces, muGrams);
  TSpinEdit(spnGList[I]).Value := Trunc(lbs + ozs);

  OnChangeRestore(I);
end;

procedure TForm1.CheckBoxCheckClick(Sender: TObject);
var
  I: Integer;
begin
  I := TTabSheet(TCheckBox(Sender).Parent).PageIndex;

  OnChangeNil(I);

  case TCheckBox(Sender).Tag of
    1: TCheckBox(ckDemisedList[I]).Checked := False;
    2: TCheckBox(ckLivingList[I]).Checked := False;
  end;

  OnChangeRestore(I);
end;

procedure TForm1.Finished(Sender: TObject);
var
  tmpstr,IEN: string;
  I,J: Integer;
  sl,tl: TStringList;
  lvitem: TListItem;

  procedure CleanLv(Lv: TListView);
  var
    I: Integer;
  begin
    for I := 0 to Lv.Items.Count - 1 do
      if ((Lv.Items[I].Caption = 'L') or (Lv.Items[I].Caption = 'C')) then
      begin
        Lv.Items[I].Delete;
        CleanLv(Lv);
        Break;
      end;
  end;

begin
  DDCSForm1.Validated := True;
  tmpstr := '';

  DDCSForm1.TmpStrList.Add('Delivery Details:');
  DDCSForm1.TmpStrList.Add('  Delivery Date: ' + dtDelivery.Text);
  DDCSForm1.TmpStrList.Add('  Maternal Date: ' + dtMaternal.Text);
  DDCSForm1.TmpStrList.Add('  Days in Hospital following Delivery '+ edtDeliveryAt.text);
  DDCSForm1.TmpStrList.Add('  Gestational Age: ' + spnGAWeeks.Text + ' Weeks ' + spnGADays.Text + ' Days');

  if cbAnesthesia.ItemIndex <> -1 then
    DDCSForm1.TmpStrList.Add('  Anesthesia: ' + cbAnesthesia.Text);

  if rgPretermDelivery.ItemIndex = 0 then
    DDCSForm1.TmpStrList.Add('  Preterm Labor: No')
  else if rgPretermDelivery.ItemIndex = 1 then
    DDCSForm1.TmpStrList.Add('  Preterm Labor: Yes');

  if cbLabor.ItemIndex <> -1 then
    DDCSForm1.TmpStrList.Add('  Labor: ' + cbLabor.Items[cbLabor.ItemIndex]);

  if Trim(spnLaborLength.Text) <> '' then
    DDCSForm1.TmpStrList.Add('  Length of Labor: ' + Trim(spnLaborLength.Text) + ' hrs');

  if cbOutcome.ItemIndex <> -1 then
    DDCSForm1.TmpStrList.Add('  Outcome: ' + cbOutcome.Items[cbOutcome.ItemIndex]);

  if Trim(cbDeliveryPlace.Text) <> '' then
    DDCSForm1.TmpStrList.Add('  Place of Delivery: ' + Trim(cbDeliveryPlace.Text));

  if meDeliveryNotes.Lines.Count > 0 then
  begin
    DDCSForm1.TmpStrList.Add('  Delivery Notes: ');
    for I := 0 to meDeliveryNotes.Lines.Count - 1 do
      DDCSForm1.TmpStrList.Add('   ' + meDeliveryNotes.Lines[I]);
  end;

  DDCSForm1.TmpStrList.Add('Neonatal Information:');
  DDCSForm1.tmpStrList.Add('  Number of Babies: ' + IntToStr(Trunc(spnBirthCount.Value)));

  for I := 0 to pgbaby.PageCount - 1 do
  begin
    tmpstr := '  Baby ' + IntTostr(I + 1);
    if TCheckBox(ckLivingList[I]).Checked then
      tmpstr := tmpstr + ' (Living):'
    else if TCheckBox(ckDemisedList[I]).Checked then
      tmpstr := tmpstr + ' (Demise):';

    DDCSForm1.TmpStrList.Add(tmpstr);
    tmpstr := '';

    if TRadioGroup(rgSexList[I]).ItemIndex = 0 then
      DDCSForm1.TmpStrList.add('   Gender: Male')
    else if TRadioGroup(rgSexList[I]).ItemIndex = 1 then
      DDCSForm1.TmpStrList.add('   Gender: Female')
    else if TRadioGroup(rgSexlist[I]).ItemIndex = 2 then
      DDCSForm1.TmpStrList.Add('   Gender: Unknown');

    tmpstr := '';
    if TSpinEdit(spnLBList[I]).Value > 0 then
      tmpstr := FloatToStr(TSpinEdit(spnLBList[I]).Value) + ' lb';
    if TSpinEdit(spnOZList[I]).Value > 0 then
    begin
      if tmpstr <> '' then
        tmpstr := tmpstr + ' ';

      tmpstr := tmpstr + FloatToStr(TSpinEdit(spnOZList[I]).Value) + ' oz';
    end;
    if tmpstr <> '' then
    begin
      tmpstr := '   Weight: ' + tmpstr + ' (' + TSpinEdit(spnGList[I]).Text + 'g)';
      DDCSForm1.TmpStrList.Add(tmpstr);
    end;

    if Trim(TCaptionEdit(edAPGARoneList[I]).Text) <> '' then
      DDCSForm1.TmpStrList.Add('   APGAR Score (one minute): ' + TCaptionEdit(edAPGARoneList[I]).Text);
    if Trim(TCaptionEdit(edAPGARfiveList[I]).Text) <> '' then
      DDCSForm1.TmpStrList.Add('   APGAR Score (five minute): ' + TCaptionEdit(edAPGARfiveList[I]).Text);

    if TCheckBox(ckNICUList[I]).Checked then
      DDCSForm1.TmpStrList.Add('   NICU Admission: Yes')
    else
      DDCSForm1.TmpStrList.Add('   NICU Admission: No');

    if TCaptionMemo(meComplicationsList[I]).Lines.Count > 0 then
    begin
      DDCSForm1.Tmpstrlist.Add('   Complications: ');

      for J := 0 to TMemo(meComplicationsList[I]).Lines.Count - 1 do
        DDCSForm1.TmpStrList.Add('    ' + TMemo(meComplicationsList[I]).Lines[J]);
    end;
  end;

  sl := TStringList.Create;
  tl := TStringList.Create;
  try
    if ckVagSVD.Checked then
      sl.Add('  - Normal Spontaneous Vaginal Delivery');
    if ckVagVacuum.Checked then
      sl.Add('  - Vacuum');
    if ckVagForceps.Checked then
      sl.Add('  - Forceps');
    if ckVagEpisiotomy.Checked then
      sl.Add('  - Episiotomy');
    if ckVagLacerations.Checked then
      sl.Add('  - Lacerations');
    if ckVagVBAC.Checked then
      sl.Add('  - Vaginal Birth after Cesarean');

    if sl.Count > 0 then
    begin
      DDCSForm1.TmpStrList.Add('Delivery Method - Vaginal: ');
      DDCSForm1.TmpStrList.AddStrings(sl);
      ckDeliveryMethodV.Checked := True;
    end;
    sl.Clear;

    if (ckCPrimaryFor.Checked) and (Trim(edCPrimaryFor.Text) <> '') then
      sl.Add('  Primary ' + Trim(edCPrimaryFor.Text));
    if ckRepeatwoLabor.Checked then
      sl.Add('  Repeat without Labor');
    if ckCUnsuccessfulVBAC.Checked then
      sl.Add('  Repeat - Unsuccessful Vaginal Birth at Cesarean');

    if cbReasonsCPrimary.ItemIndex <> -1 then
    begin
      tl.Add('     Primary: ' + cbReasonsCPrimary.Text);

      if Trim(edReasonsCOthPrimary.Text) <> '' then
        tl.Add('       Other: ' + edReasonsCOthPrimary.Text);
    end;

    if cbReasonsCSecondary.ItemIndex <> -1 then
    begin
      tl.Add('   Secondary: ' + cbReasonsCSecondary.Text);

      if Trim(edReasonsCOthSecondary.Text) <> '' then
        tl.Add('       Other: ' + edReasonsCOthSecondary.Text);
    end;

    if tl.Count > 0 then
    begin
      sl.Add('  Indications for Cesarean:');
      sl.AddStrings(tl);
    end;

    if rgIncision.ItemIndex <> -1 then
    begin
      tmpStr := '   Uterine Incision - ';
      if rgIncision.ItemIndex = 0  then
        tmpstr := tmpstr + 'Low Transverse'
      else if rgIncision.ItemIndex = 1  then
        tmpstr := tmpstr + 'Low Vertical'
      else if rgIncision.ItemIndex = 2  then
        tmpstr := tmpstr + 'Classical';

      sl.Add(tmpstr);
    end;

    if sl.Count > 0 then
    begin
      DDCSForm1.TmpStrList.Add('Delivery Method - Cesarean: ');
      DDCSForm1.TmpStrList.AddStrings(sl);
      ckDeliveryMethodC.Checked := True;
    end;
    sl.Clear;

    if ckNexplanonImplant.Checked then
      sl.Add('  - ' + ckNexplanonImplant.Caption);
    if ckProTubalLigationatCesarean.Checked then
      sl.Add('  - ' + ckProTubalLigationatCesarean.Caption);
    if ckProUterineCurettage.Checked then
      sl.Add('  - ' + ckProUterineCurettage.Caption);
    if ckProPostpartumTubalLigation.Checked then
      sl.Add('  - ' + ckProPostpartumTubalLigation.Caption);
    if ckProPostpartumHysterectomy.Checked then
      sl.Add('  - ' + ckProPostpartumHysterectomy.Caption);
    if ckIUDInsertion.Checked then
      sl.Add('  - ' + ckIUDInsertion.Caption);
    if ckBakri.Checked then
      sl.Add('  - ' + ckBakri.Caption);
    if Trim(edProceduresOther.Text) <> '' then
      sl.Add('  - Other: ' + edProceduresOther.Text);

    if sl.Count > 0 then
    begin
      DDCSForm1.TmpStrList.Add('Other Procedures done during same Hospitalization:');
      DDCSForm1.TmpStrList.AddStrings(sl);
    end;
  finally
    sl.Free;
    tl.Free;
  end;

  CleanLv(lstDelivery);

  for I := 0 to pgbaby.PageCount - 1 do
  begin
    lvitem := lstDelivery.Items.Add;
    lvitem.Caption := 'L';
    for J := 0 to 10 do
      lvitem.SubItems.Add('');

    if ((Length(pgIENs) >= I) and (I > 0)) then                                        // IEN
      IEN := pgIENs[I]
    else IEN := '';

    lvitem.SubItems[0] := IEN;

    case TRadioGroup(rgSexlist[I]).ItemIndex of                                        // Gender
      0 : lvitem.SubItems[3] := 'M';
      1 : lvitem.SubItems[3] := 'F';
      2 : lvitem.SubItems[3] := 'U';
    end;

    lvitem.SubItems[4] := TSpinEdit(spnGList[I]).Text;                                 // Birth Weight
    lvitem.SubItems[6] := TCaptionEdit(edAPGARoneList[I]).Text;                        // APGAR one
    lvitem.SubItems[7] := TCaptionEdit(edAPGARfiveList[I]).Text;                       // APGAR five

    if TCheckBox(ckLivingList[I]).Checked then                                         // Status
      lvitem.SubItems[8] := 'L'
    else if TCheckBox(ckDemisedList[I]).Checked then
      lvitem.SubItems[8] := 'D';

    if TCheckBox(ckNICUList[I]).Checked then                                           // NICU
      lvitem.SubItems[9] := '1';

    if TCaptionMemo(meComplicationsList[I]).Lines.Count > 0 then                       //COMMENTS
    begin
      for J := 0 to TCaptionMemo(meComplicationsList[I]).Lines.Count - 1 do
      begin
        lvitem := lstDelivery.Items.Add;
        lvitem.Caption := 'C';
        lvitem.SubItems.Add(IEN);
        lvitem.SubItems.Add(TCaptionMemo(meComplicationsList[I]).Lines[J]);
      end;
    end;
  end;
end;

// Private ---------------------------------------------------------------------

procedure TForm1.Rebuild;
begin
  if rgSexlist = nil then
  begin
    rgSexlist := TList.Create;
    rgSexList.Add(rgSex1);
  end;
  if ckLivingList = nil then
  begin
    ckLivingList := TList.Create;
    ckLivingList.Add(ckLiving1);
  end;
  if ckDemisedList = nil then
  begin
    ckDemisedList := TList.Create;
    ckDemisedList.Add(ckDemise1);
  end;
  if spnLBList = nil then
  begin
    spnLBList := TList.Create;
    spnLBList.Add(spnLB1);
  end;
  if spnOzList = nil then
  begin
    spnOzList := TList.Create;
    spnOzList.Add(spnOz1);
  end;
  if spnGList = nil then
  begin
    spnGList := TList.Create;
    spnGList.Add(spng1);
  end;
  if edAPGARoneList = nil then
  begin
    edAPGARoneList := TList.Create;
    edAPGARoneList.Add(edAPGARone1);
  end;
  if edAPGARfiveList = nil then
  begin
    edAPGARfiveList := TList.Create;
    edAPGARfiveList.Add(edAPGARfive1);
  end;
  if ckNICUList = nil then
  begin
    ckNICUList := TList.Create;
    ckNICUList.Add(ckNICU1);
  end;
  if meComplicationsList = nil then
  begin
    meComplicationsList:= Tlist.Create;
    meComplicationsList.Add(meComplications1);
  end;
end;

procedure TForm1.AddBaby;
var
  vTabsheet: TTabsheet;
  vPN: string;
  rgx: TRadioGroup;
  lbx: TStaticText;
  spx: TSpinEdit;
  edx: TCaptionEdit;
  ckx: TCheckBox;
  mex: TCaptionMemo;
begin
  if rgSexlist = nil then
    Rebuild;

  vTabSheet := TTabSheet.Create(pgBaby);
  vTabsheet.PageControl := pgBaby;
  vPN := IntToStr(pgBaby.PageCount);
  vTabsheet.Caption := 'Baby '+ vPN;

  //Sex
  rgx := TRadioGroup.Create(vTabsheet);
  rgx.Name := 'rgSex' + vPN;
  rgx.Parent := vTabsheet;
  rgx.Font.Style := [fsbold];
  rgx.Caption := rgSex1.Caption;
  rgx.Top:= rgSex1.Top;
  rgx.Left := rgSex1.Left;
  rgx.Height := rgSex1.Height;
  rgx.Width := rgSex1.Width;
  rgx.Items.Add('Male');
  rgx.Items.Add('Female');
  rgx.Items.Add('Unknown');
  rgx.Columns := 3;
  rgx.OnEnter := RadioGroupEnter;
  rgx.TabOrder := 0;
  rgx.TabStop := True;
  rgSexList.Add(rgx);

  //Living
  ckx := TCheckBox.Create(vTabsheet);
  ckx.Name := 'ckLiving' + vPN;
  ckx.Parent := vTabsheet;
  ckx.Font.Style := [fsbold];
  ckx.Caption := ckLiving1.Caption;
  ckx.Top := ckLiving1.Top;
  ckx.Left := ckLiving1.Left;
  ckx.Height := ckLiving1.Height;
  ckx.Width := ckLiving1.Width;
  ckx.OnClick := CheckBoxCheckClick;
  ckx.TabOrder := 1;
  ckx.TabStop := True;
  ckLivingList.Add(ckx);

  //Demised
  ckx := TCheckBox.Create(vTabsheet);
  ckx.Name := 'ckDemise' + vPN;
  ckx.Parent := vTabsheet;
  ckx.Font.Style := [fsbold];
  ckx.Caption := ckDemise1.Caption;
  ckx.Top := ckDemise1.Top;
  ckx.Left := ckDemise1.Left;
  ckx.Height := ckDemise1.Height;
  ckx.Width := ckDemise1.Width;
  ckx.OnClick := CheckBoxCheckClick;
  ckx.TabOrder := 2;
  ckx.TabStop := False;
  ckDemisedList.Add(ckx);

  //Birth Weight Label
  lbx := TStaticText.Create(vTabSheet);
  lbx.Name := 'lbBirthWeight' + vPN;
  lbx.Parent := vTabSheet;
  lbx.Font.Style := [fsbold];
  lbx.Caption := lbBirthWeight1.Caption;
  lbx.Top := lbBirthWeight1.Top;
  lbx.Left := lbBirthWeight1.Left;
  lbx.Height := lbBirthWeight1.Height;
  lbx.Width := lbBirthWeight1.Width;
  lbx.TabOrder := 3;
  lbx.TabStop := True;

  //Birth Weight SpinEdit LBS
  spx := TSpinEdit.Create(vTabSheet);
  spx.Name := 'spnLb' + vPN;
  spx.Parent := vTabSheet;
  spx.Value := 0;
  spx.Top := spnLB1.Top;
  spx.Left := spnLB1.Left;
  spx.Height := spnLB1.Height;
  spx.Width := spnLB1.Width;
  spx.OnChange := spnLb1Change;
  spx.TabOrder := 4;
  spx.TabStop := True;
  spnLBList.Add(spx);

  //Birth Weight ozs Label
  lbx := TStaticText.Create(vTabSheet);
  lbx.Name := 'lbOz' + vPN;
  lbx.Parent := vTabSheet;
  lbx.Font.Style := [fsbold];
  lbx.Caption := lbOz1.Caption;
  lbx.Top := lbOz1.Top;
  lbx.Left := lbOz1.Left;
  lbx.Height := lbOz1.Height;
  lbx.Width := lbOz1.Width;
  lbx.TabOrder := 7;
  lbx.TabStop := True;

  //Birth Weight SpinEdit OZS
  spx := TSpinEdit.Create(vTabSheet);
  spx.Name := 'spnOZ' + vPN;
  spx.Parent := vTabSheet;
  spx.Value := 0;
  spx.Top := spnOZ1.Top;
  spx.Left := spnOZ1.Left;
  spx.Height := spnOZ1.Height;
  spx.Width := spnOZ1.Width;
  spx.OnChange := spnOz1Change;
  spx.TabOrder := 6;
  spx.TabStop := True;
  spnOZList.Add(spx);

  //Birth Weight grams Label
  lbx := TStaticText.Create(vTabSheet);
  lbx.Name := 'lbg' + vPN;
  lbx.Parent := vTabSheet;
  lbx.Font.Style := [fsbold];
  lbx.Caption := lbg1.Caption;
  lbx.Top := lbg1.Top;
  lbx.Left := lbg1.Left;
  lbx.Height := lbg1.Height;
  lbx.Width := lbg1.Width;
  lbx.TabOrder := 9;
  lbx.TabStop := True;

  //Birth Weight grams spinedit
  spx := TSpinEdit.Create(vTabsheet);
  spx.Name := 'spng' + vPN;
  spx.Parent := vTabsheet;
  spx.Value := 0;
  spx.Top := spng1.Top;
  spx.Left := spng1.Left;
  spx.Height := spng1.Height;
  spx.Width := spng1.Width;
  spx.OnChange := UpdateLBOZ;
  spx.TabOrder := 8;
  spx.TabStop := True;
  spnGList.Add(spx);

  //APGAR Label
  lbx := TStaticText.Create(vTabSheet);
  lbx.Name := 'lbAPGAR' + vPN;
  lbx.Parent := vTabSheet;
  lbx.Font.Style := [fsbold];
  lbx.Caption := lbAPGAR1.Caption;
  lbx.Top := lbAPGAR1.Top;
  lbx.Left := lbAPGAR1.Left;
  lbx.Height := lbAPGAR1.Height;
  lbx.Width := lbAPGAR1.Width;
  lbx.TabOrder := 10;
  lbx.TabStop := False;

  //APGAR Score one minute captionedit
  edx := TCaptionEdit.Create(vTabsheet);
  edx.Name := 'edAPGARone' + vPN;
  edx.Parent := vTabsheet;
  edx.Text := '';
  edx.NumbersOnly := True;
  edx.Caption := edAPGARone1.Caption;
  edx.Top := edAPGARone1.Top;
  edx.Left := edAPGARone1.Left;
  edx.Height := edAPGARone1.Height;
  edx.Width := edAPGARone1.Width;
  edx.TabOrder := 11;
  edx.TabStop := True;
  edAPGARoneList.Add(edx);

  //APGAR Score five minute captionedit
  edx := TCaptionEdit.Create(vTabsheet);
  edx.Name := 'edAPGARfive' + vPN;
  edx.Parent := vTabsheet;
  edx.Text := '';
  edx.NumbersOnly := True;
  edx.Caption := edAPGARfive1.Caption;
  edx.Top := edAPGARfive1.Top;
  edx.Left := edAPGARfive1.Left;
  edx.Height := edAPGARfive1.Height;
  edx.Width := edAPGARfive1.Width;
  edx.TabOrder := 12;
  edx.TabStop := True;
  edAPGARfiveList.Add(edx);

  //NICU checkbox
  ckx := TCheckBox.Create(vTabsheet);
  ckx.Name := 'ckNICU' + vPN;
  ckx.Parent := vTabsheet;
  ckx.Font.Style := [fsbold];
  ckx.Caption := ckNICU1.Caption;
  ckx.Top := ckNICU1.Top;
  ckx.Left := ckNICU1.Left;
  ckx.Height := ckNICU1.Height;
  ckx.Width := ckNICU1.Width;
  ckx.TabOrder := 13;
  ckx.TabStop := True;
  ckNICUList.Add(ckx);

  //Complications Memo Label
  lbx := TStaticText.Create(vTabSheet);
  lbx.Name := 'lbComplications' + vPN;
  lbx.Parent := vTabSheet;
  lbx.Font.Style := [fsbold];
  lbx.Caption := lbComplications1.Caption;
  lbx.Top := lbComplications1.Top;
  lbx.Left := lbComplications1.Left;
  lbx.Height := lbComplications1.Height;
  lbx.Width := lbComplications1.Width;
  lbx.TabOrder := 14;
  lbx.TabStop := False;

  //Complications CaptionMemo
  mex := TCaptionMemo.Create(vTabSheet);
  mex.Name := 'meComplications' + vPN;
  mex.Parent := vTabSheet;
  mex.Caption := meComplications1.Caption;
  mex.Top := meComplications1.Top;
  mex.Left := meComplications1.Left;
  mex.Height := meComplications1.Height;
  mex.Width := meComplications1.Width;
  mex.Lines.Clear;
  mex.ScrollBars := ssVertical;
  mex.TabOrder := 15;
  mex.TabStop := True;
  meComplicationsList.Add(mex);
end;

procedure TForm1.RemoveBaby;
begin
  pgBaby.Pages[pgBaby.PageCount - 1].Free;
end;

procedure TForm1.OnChangeNil(I: Integer);
begin
  TSpinEdit(spnLBList[I]).OnChange := nil;
  TSpinEdit(spnOzList[I]).OnChange := nil;
  TSpinEdit(spnGList[I]).OnChange := nil;

  TCheckBox(ckLivingList[I]).OnClick := nil;
  TCheckBox(ckDemisedList[I]).OnClick := nil;
end;

procedure TForm1.OnChangeRestore(I: Integer);
begin
  TSpinEdit(spnLBList[I]).OnChange := spnLb1Change;
  TSpinEdit(spnOzList[I]).OnChange := spnOz1Change;
  TSpinEdit(spnGList[I]).OnChange := UpdateLBOZ;

  TCheckBox(ckLivingList[I]).OnClick := CheckBoxCheckClick;
  TCheckBox(ckDemisedList[I]).OnClick := CheckBoxCheckClick;
end;

end.
