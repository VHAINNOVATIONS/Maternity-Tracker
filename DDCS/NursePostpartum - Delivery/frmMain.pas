unit frmMain;

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
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.Mask, ORCtrls, ORDtTm, uBase, frmBaby;

type
  TForm1 = class(TForm)
    DDCSForm1: TDDCSForm;
    oPage1: TTabSheet;
    oPage2: TTabSheet;
    oPage3: TTabSheet;
    oPage4: TTabSheet;
    lbDeliveryDate: TLabel;
    lbDischargeDate: TLabel;
    lbDaysIn: TLabel;
    lbAnesthesia: TLabel;
    lbLabor: TLabel;
    lbDeliveryNotes: TLabel;
    lbGestationalAge: TLabel;
    lbLaborLength: TLabel;
    lbDeliveryPlace: TLabel;
    lbOutcome: TLabel;
    dtDelivery: TORDateBox;
    dtMaternal: TORDateBox;
    edtDeliveryAt: TSpinEdit;
    cbAnesthesia: TCaptionComboBox;
    cbLabor: TCaptionComboBox;
    meDeliveryNotes: TCaptionMemo;
    rgPretermDelivery: TRadioGroup;
    spnLaborLength: TSpinEdit;
    spnGADays: TSpinEdit;
    cbDeliveryPlace: TCaptionComboBox;
    cbOutcome: TCaptionComboBox;
    pgBaby: TPageControl;
    pnlBirthCount: TPanel;
    gbCesarean: TGroupBox;
    lbCesareanReasons: TLabel;
    lbReasonsCPrimary: TLabel;
    lbReasonsCSecondary: TLabel;
    lbReasonforCOther: TLabel;
    ckCPrimaryFor: TCheckBox;
    edCPrimaryFor: TEdit;
    ckCUnsuccessfulVBAC: TCheckBox;
    rgIncision: TRadioGroup;
    ckRepeatwoLabor: TCheckBox;
    cbReasonsCPrimary: TCaptionComboBox;
    cbReasonsCSecondary: TCaptionComboBox;
    edReasonsCOthPrimary: TEdit;
    edReasonsCOthSecondary: TEdit;
    gbOtherProcedures: TGroupBox;
    edProceduresOther: TEdit;
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
    spnBirthCount: TSpinEdit;
    lbBirthCount: TLabel;
    lbProceduresOther: TLabel;
    pnlSpacer: TPanel;
    lbGADays: TLabel;
    Panel1: TPanel;
    spnGAWeeks: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinCheck(Sender: TObject);
    procedure spnGADaysChange(Sender: TObject);
    procedure spnBirthCountChange(Sender: TObject);
    procedure rgPretermDeliveryClick(Sender: TObject);
    procedure Finished(Sender: TObject);
  private
    BirthCount: Integer;
    function GetBaby(Value: TTabSheet): TfrmInner;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uCommon, uReportItems, uExtndComBroker;

procedure TForm1.FormCreate(Sender: TObject);
var
  nItem: TDDCSNoteItem;
begin
  BirthCount := 0;
  Form1 := Self;

  nItem := DDCSForm1.ReportCollection.GetNoteItemAddifNil(spnGAWeeks);
  if nItem <> nil then
    nItem.SayOnFocus := 'Gestation Age in Weeks';
  nItem := DDCSForm1.ReportCollection.GetNoteItemAddifNil(spnGADays);
  if nItem <> nil then
    nItem.SayOnFocus := 'Gestation Age in Days';
end;

procedure TForm1.FormShow(Sender: TObject);
var
  I,J: Integer;
  fBaby: TfrmInner;
  val: string;
begin
  oPage4.TabVisible := False;

  //  ID^IEN^NUMBER^NAME^GENDER^BIRTH WEIGHT^STILLBORN^APGAR1^APGAR2^STATUS^NICU

  for I := 0 to lstDelivery.Items.Count - 1 do
  begin
    for J := lstDelivery.Items.item[I].SubItems.Count - 1 to 8 do
      lstDelivery.Items.Item[I].SubItems.Add('');
  end;

  for I := 0 to lstDelivery.Items.Count - 1 do
  begin
    if lstDelivery.Items.Item[I].Caption = 'L' then
    begin
      spnBirthCount.Value := spnBirthCount.Value + 1;

      fBaby := GetBaby(pgBaby.Pages[pgBaby.PageCount - 1]);
      if fBaby = nil then
        Continue;

      for J := 0 to lstDelivery.Items.Item[I].SubItems.Count - 1 do
      begin
        val := lstDelivery.Items.Item[I].SubItems[J];
        if val <> '' then
          case J of
            0 : fBaby.IEN := val;                                // IEN
            1 : ;                                                // Baby Number
            2 : ;                                                // Name
            3 : begin                                            // Gender
                  if val = 'M' then
                    fBaby.rgSex.ItemIndex := 0
                  else if val = 'F' then
                    fBaby.rgSex.ItemIndex := 1
                  else
                    fBaby.rgSex.ItemIndex := 2;
                end;
            4 : fBaby.UpdateBirthWeightGrams(val);               // Birth Weight in grams
            5 : if val = '1' then                                // StillBorn
                  fBaby.rgLife.ItemIndex := 1;
            6 : fBaby.edAPGARone.Text := val;                    // APGAR1
            7 : fBaby.edAPGARfive.Text := val;                   // APGAR2
            8 : begin                                            // Status
                  if val = 'L' then
                    fBaby.rgLife.ItemIndex := 0
                  else if val = 'D' then
                    fBaby.rgLife.ItemIndex := 1;
                end;
            9 : if val = '1' then
                  fBaby.ckNICU.Checked := True;                  // NICU
          end;
      end;
    end
    else if lstDelivery.Items.Item[I].Caption = 'C' then         // Complications
    begin
      for J := 0 to pgBaby.PageCount - 1 do
      begin
        fBaby := GetBaby(pgBaby.Pages[J]);
        if fBaby <> nil then
          if lstDelivery.Items.Item[I].SubItems[0] = fBaby.IEN then
            fBaby.meComplications.Lines.Add(lstDelivery.Items.Item[I].SubItems[1]);
      end;
    end;
  end;

  DDCSForm1.ActivePageIndex := 0;
end;

procedure TForm1.SpinCheck(Sender: TObject);
begin
  if not (Sender is TSpinEdit) then
    Exit;

  if TSpinEdit(Sender).Value < 0 then
    TSpinEdit(Sender).Value := 0;
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
var
  vTabSheet: TTabsheet;
  vPN: string;
  fBaby: TfrmInner;
begin
  if spnBirthCount.Value < 1 then
  begin
    spnBirthCount.Value := 1;
    Exit;
  end;

  if spnBirthCount.Value = BirthCount then
    Exit;

  if spnBirthCount.Value > BirthCount then
  begin
    vTabSheet := TTabSheet.Create(pgBaby);
    vTabSheet.PageControl := pgBaby;
    vPN := IntToStr(spnBirthCount.Value);
    vTabSheet.Caption := 'Baby '+ vPN;

    fBaby := TfrmInner.Create(vTabSheet);
    fBaby.Parent := vTabSheet;
    fBaby.Name := 'fBaby' + vPN;
    fBaby.Align := alClient;
    fBaby.Show;

    fBaby.BabyNumber := spnBirthCount.Value;
    fBaby.rgSex.OnEnter := DDCSForm1.RadioGroupEnter;
    fBaby.rgLife.OnEnter := DDCSForm1.RadioGroupEnter;
  end else
    pgBaby.Pages[pgBaby.PageCount - 1].Free;

  BirthCount := spnBirthCount.Value;
end;

procedure TForm1.rgPretermDeliveryClick(Sender: TObject);
begin
  if (cbOutcome.ItemIndex = -1) or (cbOutcome.Text = 'Unknown') then
    case rgPretermDelivery.ItemIndex of
      0: begin
           if cbOutcome.Items.IndexOf('Full Term') = -1 then
             cbOutcome.Items.Add('Full Term');
           cbOutcome.ItemIndex := cbOutcome.Items.IndexOf('Full Term');
         end;
      1: begin
           if cbOutcome.Items.IndexOf('Preterm') = -1 then
             cbOutcome.Items.Add('Preterm');
           cbOutcome.ItemIndex := cbOutcome.Items.IndexOf('Preterm');
         end;
    end;
end;

procedure TForm1.Finished(Sender: TObject);
var
  fBaby: TfrmInner;
  I,J: Integer;
  sl,tl: TStringList;
  tmpStr: string;
  lvItem: TListItem;

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

  DDCSForm1.TmpStrList.Add('  Length of Labor: ' + spnLaborLength.Text + ' hrs');

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

  if BirthCount > 0 then
  begin
    DDCSForm1.TmpStrList.Add('Neonatal Information:');
    DDCSForm1.tmpStrList.Add('  Number of Babies: ' + IntToStr(BirthCount));

    for I := 0 to pgBaby.PageCount - 1 do
    begin
      fBaby := GetBaby(pgBaby.Pages[I]);
      if fBaby <> nil then
        DDCSForm1.TmpStrList.AddStrings(fBaby.GetText);
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

  for I := 0 to pgBaby.PageCount - 1 do
  begin
    fBaby := GetBaby(pgBaby.Pages[I]);
    if fBaby = nil then
      Continue;

    lvItem := lstDelivery.Items.Add;
    lvItem.Caption := 'L';
    for J := 0 to 10 do
      lvitem.SubItems.Add('');

    lvitem.SubItems[0] := fBaby.IEN;

    case fBaby.rgSex.ItemIndex of                                        // Gender
      0 : lvItem.SubItems[3] := 'M';
      1 : lvItem.SubItems[3] := 'F';
      2 : lvItem.SubItems[3] := 'U';
    end;

    lvItem.SubItems[4] := fBaby.spnG.Text;                               // Birth Weight
    lvItem.SubItems[6] := fBaby.edAPGARone.Text;                         // APGAR one
    lvItem.SubItems[7] := fBaby.edAPGARfive.Text;                        // APGAR five

    case fBaby.rgLife.ItemIndex of                                       // Status
      0 : lvItem.SubItems[8] := 'L';
      1 : lvItem.SubItems[8] := 'D';
    end;

    if fBaby.ckNICU.Checked then                                         // NICU
      lvItem.SubItems[9] := '1';

    for J := 0 to fBaby.meComplications.Lines.Count - 1 do               // Complications
    begin
      lvItem := lstDelivery.Items.Add;
      lvItem.Caption := 'C';
      lvItem.SubItems.Add(fBaby.IEN);
      lvItem.SubItems.Add(fBaby.meComplications.Lines[J]);
    end;
  end;
end;

// Private ---------------------------------------------------------------------

function TForm1.GetBaby(Value: TTabSheet): TfrmInner;
begin
  if Value.ControlCount > 0 then
    if Value.Controls[0] is TfrmInner then
      Result := TfrmInner(Value.Controls[0]);
end;

end.
