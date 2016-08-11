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
    spnBirthCount: TSpinEdit;
    lbBirthCount: TLabel;
    lbProceduresOther: TLabel;
    pnlSpacer: TPanel;
    lbGADays: TLabel;
    Panel1: TPanel;
    spnGAWeeks: TSpinEdit;
    rgTypeDelivery: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinCheck(Sender: TObject);
    procedure spnGADaysChange(Sender: TObject);
    procedure spnBirthCountChange(Sender: TObject);
    procedure rgPretermDeliveryClick(Sender: TObject);
    procedure Finished(Sender: TObject);
  private
    FPregIEN: Integer;
    BirthCount: Integer;
    function GetBaby(Value: TTabSheet): TfChild;
  public
    property PregnancyIEN: Integer read FPregIEN write FPregIEN default 0;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uCommon, uReportItems, uExtndComBroker;

function SubCount(str: string; d: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(str) - 1 do
    if str[I] = d then
      inc(Result);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BirthCount := 0;
  Form1 := Self;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  I,G,J,L: Integer;
  vPregChild: TfChild;
  cItem: TConfigItem;
  tmp,btmp,sLkup: string;
begin

  //   1) L
  //   2) IEN
  //   3) DATE RECORDED
  //   4) EDC
  //   5) DFN|PATIENT
  //   6) STATUS
  //   7) FOF|(IEN OR IDENTIFIER)
  //   8) EDD
  //   9) PREGNANCY END
  //  10) OB IEN|OB
  //  11) FACILITY IEN|FACILITY
  //  12) UPDATED BY IEN|UPDATED BY
  //  13) GESTATIONAL AGE
  //  14) LENGTH OF LABOR
  //  15) TYPE OF DELIVERY
  //  16) ANESTHESIA
  //  17) PRETERM DELIVERY
  //  18) BIRTH TYPE
  //  19) IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU|
  //  20) OUTCOME
  //  21) HIGH RISK FLAG
  //  22) DAYS IN HOSPITAL
  //
  //  C^IEN^COMMENT
  //  B^IEN|BABY|#^COMMENT

  if DDCSForm1.Configuration.Count > 0 then
  begin
    for I := 0 to DDCSForm1.Configuration.Count - 1 do
    begin
      cItem := DDCSForm1.Configuration.Items[I];

      if cItem.ID[1] = 'L' then
      begin
        PregnancyIEN := StrToIntDef(cItem.Piece[2], 0);

        dtDelivery.Text := cItem.Piece[9];

        tmp := cItem.Piece[11];
        if tmp <> '' then
        begin
          if cbDeliveryPlace.Items.IndexOf(Piece(tmp,'|',2)) <> -1 then
            cbDeliveryPlace.ItemIndex := cbDeliveryPlace.Items.IndexOf(Piece(tmp,'|',2))
          else
            cbDeliveryPlace.Text := Piece(tmp,'|',2);
        end;

        tmp := cItem.Piece[13];
        spnGAWeeks.Value := StrToIntDef(Piece(tmp,'W',1), 0);
        spnGADays.Value  := StrToIntDef(Piece(Piece(tmp,'D',1),'W',2), 0);

        spnLaborLength.Value := StrToIntDef(cItem.Piece[14], 0);

        tmp := cItem.Piece[15];
        if tmp = 'V' then
          rgTypeDelivery.ItemIndex := 0
        else if tmp = 'C' then
          rgTypeDelivery.ItemIndex := 1;

        tmp := cItem.Piece[16];
        if tmp <> '' then
        begin
          if cbAnesthesia.Items.IndexOf(tmp) = -1 then
            cbAnesthesia.Items.Add(tmp);
          cbAnesthesia.ItemIndex := cbAnesthesia.Items.IndexOf(tmp);
        end;

        rgPretermDelivery.ItemIndex := StrToIntDef(cItem.Piece[17], 0);

        if cbOutcome.Enabled then
        begin
          tmp := cItem.Piece[20];
          if tmp <> '' then
          begin
            if cbOutcome.Items.IndexOf(tmp) = -1 then
              cbOutcome.Items.Add(tmp);
            cbOutcome.ItemIndex := cbOutcome.Items.IndexOf(tmp);
          end;
        end;

        edtDeliveryAt.Value := StrToIntDef(cItem.Piece[22], 0);

        // IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
        tmp := cItem.Piece[19];
        if tmp <> '' then
        begin
          G := SubCount(tmp,'|') + 1;
          for J := 1 to G do
          begin
            btmp := Piece(tmp,'|',J);
            // ---- Add the Baby Tab ---------------------------------------
            spnBirthCount.Value := spnBirthCount.Value + 1;
            // -------------------------------------------------------------

            // ---- Get the Baby Info Form ---------------------------------
            if pgBaby.PageCount > 1 then
              if pgBaby.Pages[pgBaby.PageCount - 1].ControlCount > 0 then
                if pgBaby.Pages[pgBaby.PageCount - 1].Controls[0] is TfChild then
                begin
                  vPregChild := TfChild(pgBaby.Pages[pgBaby.PageCount - 1].Controls[0]);

                  // IEN
                  vPregChild.BabyIEN := Piece(btmp,';',1);

                  // Baby #
                  vPregChild.BabyNumber := Piece(btmp,';',2);

                  // Sex
                  if Piece(btmp,';',4) = 'M' then
                    vPregChild.rgSex.ItemIndex := 0
                  else if Piece(btmp,';',4) = 'F' then
                    vPregChild.rgSex.ItemIndex := 1
                  else if Piece(btmp,';',4) = 'U' then
                    vPregChild.rgSex.ItemIndex := 2;

                  // Weight
                  vPregChild.spnG.Value := StrToIntDef(Piece(btmp,';',5), 0);

                  // APGAR1
                  vPregChild.edAPGARone.Text := Piece(btmp,';',7);

                  // APGAR2
                  vPregChild.edAPGARfive.Text := Piece(btmp,';',8);

                  // NICU
                  vPregChild.ckNICU.Checked := (Piece(btmp,';',10) = '1');

                  // Baby Notes
                  sLkup := IntToStr(PregnancyIEN) + '|' + vPregChild.BabyIEN + '|' + vPregChild.BabyNumber;

                  cItem := DDCSForm1.Configuration.LookUp('B', sLkup, '');
                  if cItem <> nil then
                    for L := 0 to cItem.Data.Count - 1 do
                      vPregChild.meComplications.Lines.Add(Pieces(cItem.Data[L],U,3,999));
                end;
          end;
        end;

        // Delivery Notes
        sLkup := IntToStr(PregnancyIEN);

        cItem := DDCSForm1.Configuration.LookUp('C', sLkup, '');
        if cItem <> nil then
          for J := 0 to cItem.Data.Count - 1 do
            meDeliveryNotes.Lines.Add(Pieces(cItem.Data[J],U,3,999));
      end;
    end;
  end;

  if pgBaby.PageCount > 0 then
    pgBaby.ActivePageIndex := 0;
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
  fBaby: TfChild;
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

    fBaby := TfChild.Create(vTabSheet);
    fBaby.Parent := vTabSheet;
    fBaby.Name := 'fBaby' + vPN;
    fBaby.Align := alClient;
    fBaby.Show;

    fBaby.BabyNumber := IntToStr(spnBirthCount.Value);
    fBaby.rgSex.OnEnter := DDCSForm1.RadioGroupEnter;
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
  fBaby: TfChild;
  I,J: Integer;
  sl,tl: TStringList;
  tmpStr: string;
  lvItem: TListItem;
  cItem: TConfigItem;

  procedure GetSaveChildComments;
  var
    PregID,BabyID: string;
    I,J: Integer;
    vChild: TfChild;
    cItem: TConfigItem;
  begin
    PregID := IntToStr(PregnancyIEN);

    //  B^IEN|BABY|#^COMMENT
    if pgBaby.PageCount > 1 then
      for I := 1 to pgBaby.PageCount - 1 do
        if pgBaby.Pages[I].ControlCount > 0 then
          if pgBaby.Pages[I].Controls[0] is TfChild then
          begin
            vChild := TfChild(pgBaby.Pages[I].Controls[0]);
            BabyID := PregID + '|' + vChild.BabyIEN + '|' + vChild.BabyNumber;

            cItem := DDCSForm1.Configuration.LookUp('B', BabyID, '');
            if cItem = nil then
            begin
              cItem := TConfigItem.Create(DDCSForm1.Configuration);
              cItem.ID[1] := 'B';
              cItem.ID[2] := BabyID;
            end;
            cItem.Data.Clear;

            for J := 0 to vChild.meComplications.Lines.Count - 1 do
              cItem.Data.Add('B^' + BabyID + U + vChild.meComplications.Lines[J]);
          end;
  end;

  procedure GetSavePregComments(var oText: TStringList);
  var
    I: Integer;
    PregID: string;
  begin
    oText.Clear;

    PregID := IntToStr(PregnancyIEN);
    //  C^IEN^COMMENT
    for I := 0 to meDeliveryNotes.Lines.Count - 1 do
      oText.Add('C^' + PregID + U + meDeliveryNotes.Lines[I])
  end;

  function GetChildrenV: string;
  var
    I: Integer;
  begin
    Result := '';

    if pgBaby.PageCount > 1 then
      for I := 1 to pgBaby.PageCount - 1 do
        if pgBaby.Pages[I].ControlCount > 0 then
          if pgBaby.Pages[I].Controls[0] is TfChild then
            Result := Result + TfChild(pgBaby.Pages[I].Controls[0]).GetV;
  end;

  function GetSavePregInfo: string;
  begin
    Result := '';

    //   1) L
    //   2) IEN
    //   3) DATE RECORDED
    //   4) EDC
    //   5) DFN|PATIENT
    //   6) STATUS
    //   7) FOF|(IEN OR IDENTIFIER)
    //   8) EDD
    //   9) PREGNANCY END
    //  10) OB IEN|OB
    //  11) FACILITY IEN|FACILITY
    //  12) UPDATED BY IEN|UPDATED BY
    //  13) GESTATIONAL AGE
    //  14) LENGTH OF LABOR
    //  15) TYPE OF DELIVERY
    //  16) ANESTHESIA
    //  17) PRETERM DELIVERY
    //  18) BIRTH TYPE
    //  19) IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU|
    //  20) OUTCOME
    //  21) HIGH RISK FLAG
    //  22) DAYS IN HOSPITAL

    Result := 'L^';                                                             // ID (L)
    Result := Result + IntToStr(PregnancyIEN) + U;                              // IEN (Replaced upstream if 0)
    Result := Result + U;                                                       // DATE RECORDED
    Result := Result + U;                                                       // EDC
    Result := Result + U;                                                       // DFN| PATIENT (handled by routine)
    Result := Result + 'CURRENT^';                                              // STATUS
    Result := Result + U;                                                       // FOF|(IEN OR IDENTIFIER)
    Result := Result + U;                                                       // EDD
    Result := Result + dtDelivery.Text + U;                                     // PREGNANCY END
    Result := Result + U;                                                       // OB IEN|OB
    Result := Result + '|' + cbDeliveryPlace.Text + U;                          // FACILITY IEN|FACILITY
    Result := Result + U;                                                       // UPDATED BY IEN|UPDATED BY
    Result := Result + spnGAWeeks.Text + 'W' + spnGADays.Text  + 'D^';          // GESTATIONAL AGE
    Result := Result + spnLaborLength.Text + U;                                 // LENGTH OF LABOR

    // TYPE OF DELIVERY
    if rgTypeDelivery.ItemIndex = 0 then
      Result := Result + 'V^'
    else if rgTypeDelivery.ItemIndex = 1 then
      Result := Result + 'C^'
    else
      Result := Result + U;

    Result := Result + cbAnesthesia.Text + U;                                   // ANESTHESIA
    Result := Result + IntToStr(rgPretermDelivery.ItemIndex) + U;               // PRETERM DELIVERY
    Result := Result + U;                                                       // BIRTH TYPE
    Result := Result + GetChildrenV + U;                                        // IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU|
    Result := Result + cbOutcome.Text + U;                                      // OUTCOME
    Result := Result + U;                                                       // HIGH RISK FLAG
    Result := Result + edtDeliveryAt.Text;                                      // DAYS IN HOSPITAL
  end;

begin
  sl := TStringList.Create;
  tl := TStringList.Create;
  try
    DDCSForm1.Validated := True;

    DDCSForm1.TmpStrList.Add('Delivery Details:');
    DDCSForm1.TmpStrList.Add('  Delivery Date: ' + dtDelivery.Text);
    DDCSForm1.TmpStrList.Add('  Maternal Date: ' + dtMaternal.Text);
    DDCSForm1.TmpStrList.Add('  Days in Hospital following Delivery '+ edtDeliveryAt.text);
    DDCSForm1.TmpStrList.Add('  Gestational Age: ' + spnGAWeeks.Text + ' Weeks ' + spnGADays.Text + ' Days');

    if cbAnesthesia.ItemIndex <> -1 then
      DDCSForm1.TmpStrList.Add('  Anesthesia: ' + cbAnesthesia.Text);

    if cbLabor.ItemIndex <> -1 then
      DDCSForm1.TmpStrList.Add('  Labor: ' + cbLabor.Items[cbLabor.ItemIndex]);

    DDCSForm1.TmpStrList.Add('  Length of Labor: ' + spnLaborLength.Text + ' hrs');

    if rgTypeDelivery.ItemIndex = 0 then
      DDCSForm1.TmpStrList.Add('  Type of Delivery: Vaginal')
    else if rgTypeDelivery.ItemIndex = 1 then
      DDCSForm1.TmpStrList.Add('  Type of Delivery: Cesarean');

    if cbOutcome.ItemIndex <> -1 then
      DDCSForm1.TmpStrList.Add('  Outcome: ' + cbOutcome.Items[cbOutcome.ItemIndex]);

    if rgPretermDelivery.ItemIndex = 0 then
      DDCSForm1.TmpStrList.Add('  Preterm Labor: No')
    else if rgPretermDelivery.ItemIndex = 1 then
      DDCSForm1.TmpStrList.Add('  Preterm Labor: Yes');

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
        begin
          fBaby.GetText(sl);
          if sl.Count > 0 then
            DDCSForm1.TmpStrList.AddStrings(sl);
        end;
      end;
    end;
    sl.Clear;

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
    tl.Clear;

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
    sl.Clear;

    // Pregnancy Info
    cItem := DDCSForm1.Configuration.LookUp('L', IntToStr(PregnancyIEN), '');
    if cItem = nil then
    begin
      cItem := TConfigItem.Create(DDCSForm1.Configuration);
      cItem.ID[1] := 'L';
      cItem.ID[2] := IntToStr(PregnancyIEN);
      cItem.Data.Add('');
    end;
    cItem.Data[0] := GetSavePregInfo;

    // Pregnancy Comments
    cItem := DDCSForm1.Configuration.LookUp('C', IntToStr(PregnancyIEN), '');
    if cItem = nil then
    begin
      cItem := TConfigItem.Create(DDCSForm1.Configuration);
      cItem.ID[1] := 'C';
      cItem.ID[2] := IntToStr(PregnancyIEN);
    end;
    cItem.Data.Clear;
    GetSavePregComments(sl);
    if sl.Count > 0 then
      cItem.Data.AddStrings(sl);
    sl.Clear;

    // Baby Comments
    GetSaveChildComments;
  finally
    sl.Free;
    tl.Free;
  end;
end;

// Private ---------------------------------------------------------------------

function TForm1.GetBaby(Value: TTabSheet): TfChild;
begin
  Result := nil;

  if Value.ControlCount > 0 then
    if Value.Controls[0] is TfChild then
      Result := TfChild(Value.Controls[0]);
end;

end.
