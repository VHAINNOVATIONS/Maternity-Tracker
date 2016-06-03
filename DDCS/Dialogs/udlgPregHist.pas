unit udlgPregHist;

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

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin, Vcl.ComCtrls,
  uDialog, frmPregHistPreg;

type
  TdlgPregHist = class(TDDCSDialog)
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lbTotalPreg: TLabel;
    lbFullTerm: TLabel;
    lbPremature: TLabel;
    lbInduced: TLabel;
    lbSpontaneous: TLabel;
    lbEctopics: TLabel;
    lbMultipleBirths: TLabel;
    lbLiving: TLabel;
    pgPregnancy: TPageControl;
    edtAbInduced: TSpinEdit;
    edtAbSpont: TSpinEdit;
    edtTotPreg: TSpinEdit;
    edtEctopic: TSpinEdit;
    PregListView: TListView;
    lbFullTermValue: TStaticText;
    lbPrematureValue: TStaticText;
    lbMultipleBirthsValue: TStaticText;
    lbLivingValue: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TotPregChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    TotalPreg,TotalAI,TotalAS,TotalE: Integer;
    procedure PregHeaderChangeOff;
    procedure PregHeaderChangeOn;
    function GetPregInfobyIEN(Value: Integer): TfPreg;
  public
    procedure ModifyPreterm(Value: Integer);
    procedure ModifyFullTerm(Value: Integer);
    procedure ModifyMultiBirth(Value: Integer);
    procedure ModifyLiving(Value: Integer);
    procedure DeletePregnancy(iIndex: Integer);
  end;

var
  dlgPregHist: TdlgPregHist;

implementation

{$R *.dfm}

uses
  frmPregHistPregInfo, frmPregHistChild, uCommon, uExtndComBroker;

procedure TdlgPregHist.FormCreate(Sender: TObject);
begin
  TotalPreg := 0;
  TotalAI   := 0;
  TotalAS   := 0;
  TotalE    := 0;

  dlgPregHist := Self;
end;

procedure TdlgPregHist.FormShow(Sender: TObject);
var
  I,J,bI,bJ: Integer;
  val,bval: string;
  vPreg: TfPreg;
  vPregInfo: TfPregInfo;
  vPregChild: TfChild;

  function SubCount(str: string; d: Char): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to Length(str) - 1 do
      if str[I] = d then
        inc(Result);
  end;

begin
  try
    //  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
    //    EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
    //    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE^LENGTH OF LABOR^
    //    TYPE OF DELIVERY^ANESTHESIA^PRETERM DELIVERY^BIRTH TYPE^
    //    IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU^
    //    OUTCOME^HIGH RISK FLAG^DELIVERY AT
    //  C^IEN^COMMENT

    for I := 0 to PregListView.Items.Count - 1 do
      for J := PregListView.Items.Item[I].SubItems.Count - 1 to 19 do
        PregListView.Items.Item[I].SubItems.Add('');

    for I := 0 to PregListView.Items.Count - 1 do
      if PregListView.Items.Item[I].Caption = 'L' then
      begin
        // ---- Add the Pregnancy Tab ------------------------------------------
        val := Uppercase(PregListView.Items.Item[I].SubItems[18]);    // Outcome
        if val = 'ECTOPIC' then
          edtEctopic.Value := edtEctopic.Value + 1
        else if val = 'TERMINATION' then
          edtAbInduced.Value := edtAbInduced.Value + 1
        else if val = 'SPONTANEOUS ABORTION' then
          edtAbSpont.Value := edtAbSpont.Value + 1
        else
          edtTotPreg.Value := edtTotPreg.Value + 1;
        // ---------------------------------------------------------------------

        // ---- Get the Pregnancy Info Form ------------------------------------
        if pgPregnancy.Pages[pgPregnancy.PageCount - 1].ControlCount > 0 then
          if pgPregnancy.Pages[pgPregnancy.PageCount - 1].Controls[0] is TfPreg then
          begin
            vPreg := TfPreg(pgPregnancy.Pages[pgPregnancy.PageCount - 1].Controls[0]);
            vPreg.PregnancyIEN := StrToIntDef(PregListView.Items.Item[I].SubItems[0], 0);
            vPregInfo := vPreg.GetPregInfo;
          end;

        if vPregInfo <> nil then
        begin
          for J := 0 to PregListView.Items.Item[I].SubItems.Count - 1 do
          begin
            val := PregListView.Items.Item[I].SubItems[J];
            if val <> '' then
            case J of
              0: ;                                                              // IEN
              1: ;                                                              // DATE RECORDED
              2: ;                                                              // EDC
              3: ;                                                              // DFN|PATIENT
              4: if val = 'CURRENT' then                                        // STATUS
                   vPregInfo.lbStatus.Caption := vPregInfo.lbStatus.Caption + ' (C)';
              5: ;                                                              // FOF|(IEN OR IDENTIFIER)
              6: ;                                                              // EDD
              7: vPregInfo.dtDelivery.Text := val;                              // PREGNANCY END
              8: ;                                                              // OB IEN|OB
              9: begin                                                          // FACILITY IEN|FACILITY
                   if vPregInfo.cbDeliveryPlace.Items.IndexOf(Piece(val,'|',2)) <> -1 then
                     vPregInfo.cbDeliveryPlace.ItemIndex := vPregInfo.cbDeliveryPlace.Items.IndexOf(Piece(val,'|',2))
                   else
                     vPregInfo.cbDeliveryPlace.Text := Piece(val,'|',2);
                 end;
             10: ;                                                              // UPDATED BY IEN|UPDATED BY
             11: begin                                                          // GESTATIONAL AGE
                   vPregInfo.spnGAWeeks.Value := StrToIntDef(Piece(val,'W',1), 0);
                   vPregInfo.spnGADays.Value := StrToIntDef(Piece(Piece(val,'D',1),'W',2), 0);
                 end;
             12: vPregInfo.spnLaborLength.Value := StrToIntDef(val, 0);         // LENGTH OF DELIVERY
             13: begin                                                          // TYPE OF DELIVERY (C/V)
                   if val = 'V' then
                     vPregInfo.rgTypeDelivery.ItemIndex := 0
                   else if val = 'C' then
                     vPregInfo.rgTypeDelivery.ItemIndex := 1;
                 end;
             14: begin                                                          // ANESTHESIA
                   if vPregInfo.cbAnesthesia.Items.IndexOf(val) = -1 then
                     vPregInfo.cbAnesthesia.Items.Add(val);
                   vPregInfo.cbAnesthesia.ItemIndex := vPregInfo.cbAnesthesia.Items.IndexOf(val);
                 end;
             15: vPregInfo.rgPretermDelivery.ItemIndex := StrToIntDef(val, 0);  // PRETERM DELIVERY
             16: ;                                                              // BIRTH TYPE
             // IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
             17: begin
                   bJ := SubCount(val,'|') + 1;

                   for bI := 1 to bJ do
                   begin
                     bval := Piece(val,'|',bI);
                     // ---- Add the Baby Tab ---------------------------------
                     vPregInfo.spnBirthCount.Value := vPregInfo.spnBirthCount.Value + 1;
                     // -------------------------------------------------------

                     // ---- Get the Baby Info Form ---------------------------
                     if vPreg.pgPreg.PageCount > 1 then
                       if vPreg.pgPreg.Pages[vPreg.pgPreg.PageCount - 1].ControlCount > 0 then
                         if vPreg.pgPreg.Pages[vPreg.pgPreg.PageCount - 1].Controls[0] is TfChild then
                         begin
                           vPregChild := TfChild(vPreg.pgPreg.Pages[vPreg.pgPreg.PageCount - 1].Controls[0]);

                           // IEN
                           vPregChild.BabyIEN := StrToIntDef(Piece(bval,';',1), 0);

                           // Baby #
                           vPregChild.BabyNumber := StrToIntDef(Piece(bval,';',2), 0);

                           // Sex
                           if Piece(bval,';',4) = 'M' then
                             vPregChild.rgSex.ItemIndex := 0
                           else if Piece(bval,';',4) = 'F' then
                             vPregChild.rgSex.ItemIndex := 1
                           else if Piece(bval,';',4) = 'U' then
                             vPregChild.rgSex.ItemIndex := 2;

                           // Weight
                           vPregChild.spnG.Value := StrToIntDef(Piece(bval,';',5), 0);

                           // Stillborn - set status to demise
                           vPregChild.rgLife.ItemIndex := StrToIntDef(Piece(bval,';',6), 0);
                           // Status
                           if Piece(bval,';',9) = 'D' then
                             vPregChild.rgLife.ItemIndex := 1;

                           // APGAR1
                           vPregChild.edAPGARone.Text := Piece(bval,';',7);

                           // APGAR2
                           vPregChild.edAPGARfive.Text := Piece(bval,';',8);

                           // NICU
                           vPregChild.ckNICU.Checked := (Piece(bval,';',10) = '1');
                         end;
                   end;
                 end;
             18: begin                                                          // OUTCOME
                   if vPregInfo.cbOutcome.Enabled then
                   begin
                     if vPregInfo.cbOutcome.Items.IndexOf(val) = -1 then
                       vPregInfo.cbOutcome.Items.Add(val);
                     vPregInfo.cbOutcome.ItemIndex := vPregInfo.cbOutcome.Items.IndexOf(val);
                   end;
                 end;
             19: ;                                                              // HIGH RISK FLAG
             20: vPregInfo.edtDeliveryAt.Value := StrToIntDef(val, 0);          // DELIVERY AT
            end;
          end;
        end;
      end;

    for I := 0 to PregListView.Items.Count - 1 do
      if PregListView.Items.Item[I].Caption = 'C' then
      begin
        vPreg := GetPregInfobyIEN(StrToIntDef(PregListView.Items.Item[I].SubItems[0], 0));
        if vPreg <> nil then
        begin
          vPregInfo := vPreg.GetPregInfo;
          if vPregInfo <> nil then
            vPregInfo.meDeliveryNotes.Lines.Add(PregListView.Items.Item[I].SubItems[1]);
        end;
      end;
  finally
    if pgPregnancy.PageCount > 0 then
      pgPregnancy.ActivePageIndex := 0;
  end;
end;

procedure TdlgPregHist.TotPregChange(Sender: TObject);
var
  notAllowed: Boolean;
  vTabSheet: TTabsheet;
  vPreg: TfPreg;
  vPregInfo: TfPregInfo;
begin
  PregHeaderChangeOff;
  try
    if TSpinEdit(Sender).Value < 0 then
    begin
      TSpinEdit(Sender).Value := 0;
      Exit;
    end;

    notAllowed := False;
    case TSpinEdit(Sender).Tag of
      1: notAllowed := edtTotPreg.Value   < TotalPreg;
      2: notAllowed := edtAbInduced.Value < TotalAI;
      3: notAllowed := edtAbSpont.Value   < TotalAS;
      4: notAllowed := edtEctopic.Value   < TotalE;
    end;

    if notAllowed then
    begin
      TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1;
      ShowMsg('Use the "X" button on the pregnancy you wish to remove.', smiWarning, smbOK);
    end else
    begin
      Inc(TotalPreg);
      edtTotPreg.Value := TotalPreg;

      case TSpinEdit(Sender).Tag of
        2: TotalAI := edtAbInduced.Value;
        3: TotalAS := edtAbSpont.Value;
        4: TotalE  := edtEctopic.Value;
      end;

      vTabSheet := TTabSheet.Create(pgPregnancy);
      vTabSheet.PageControl := pgPregnancy;
      vTabSheet.Caption := '# '+ IntToStr(vTabSheet.TabIndex + 1);

      vPreg := TfPreg.Create(vTabSheet);
      vPreg.Parent := vTabSheet;
      vPreg.Align := alClient;
      vPreg.Show;

      vTabSheet := TTabSheet.Create(vPreg.pgPreg);
      vTabSheet.PageControl := vPreg.pgPreg;
      vTabSheet.Caption := 'Pregnancy';

      vPregInfo := TfPregInfo.Create(vTabSheet);
      vPregInfo.Parent := vTabSheet;
      vPregInfo.Align := alClient;
      vPregInfo.Show;

      case TSpinEdit(Sender).Tag of
        1: vPreg.PregnancyType := ptN;
        2: begin
             vPreg.PregnancyType := ptAI;
             vPregInfo.spnBirthCount.Enabled := False;
             vPregInfo.lbBirthCount.Enabled := False;
             vPregInfo.rgPretermDelivery.ItemIndex := -1;
             dlgPregHist.ModifyFullTerm(-1);
             vPregInfo.rgPretermDelivery.Visible := False;
             if vPregInfo.cbOutcome.Items.IndexOf('Termination') = -1 then
               vPregInfo.cbOutcome.Items.Add('Termination');
             vPregInfo.cbOutcome.ItemIndex := vPregInfo.cbOutcome.Items.IndexOf('Termination');
             vPregInfo.cbOutcome.Enabled := False;
           end;
        3: begin
             vPreg.PregnancyType := ptAS;
             vPregInfo.spnBirthCount.Enabled := False;
             vPregInfo.lbBirthCount.Enabled := False;
             vPregInfo.rgPretermDelivery.ItemIndex := -1;
             dlgPregHist.ModifyFullTerm(-1);
             vPregInfo.rgPretermDelivery.Visible := False;
             if vPregInfo.cbOutcome.Items.IndexOf('Spontaneous Abortion') = -1 then
               vPregInfo.cbOutcome.Items.Add('Spontaneous Abortion');
             vPregInfo.cbOutcome.ItemIndex := vPregInfo.cbOutcome.Items.IndexOf('Spontaneous Abortion');
             vPregInfo.cbOutcome.Enabled := False;
           end;
        4: begin
             vPreg.PregnancyType := ptE;
             if vPregInfo.cbOutcome.Items.IndexOf('Ectopic') = -1 then
               vPregInfo.cbOutcome.Items.Add('Ectopic');
             vPregInfo.cbOutcome.ItemIndex := vPregInfo.cbOutcome.Items.IndexOf('Ectopic');
             vPregInfo.cbOutcome.Enabled := False;
           end;
      end;

      if vPregInfo.cbOutcome.Items.IndexOf(vPregInfo.lbStatus.Caption) <> -1 then
      begin
        vPregInfo.cbOutcome.ItemIndex := vPregInfo.cbOutcome.Items.IndexOf(vPregInfo.lbStatus.Caption);
        vPregInfo.cbOutcome.Enabled := False;
        vPregInfo.lbOutcome.Enabled := False;
      end;
    end;
  finally
    PregHeaderChangeOn;
  end;
end;

procedure TdlgPregHist.btnOKClick(Sender: TObject);
var
  I,J: Integer;
  vPreg: TfPreg;
  vPregInfo: TfPregInfo;
  lvItem: TListItem;
begin
  TmpStrList.Add('Pregnancy History: ');
  TmpStrList.Add('  Total Pregnancies: ' + edtTotPreg.Text);
  TmpStrList.Add('  Full Term: ' + lbFullTermValue.Caption);
  TmpStrList.Add('  Premature: ' + lbPrematureValue.Caption);
  TmpStrList.Add('  Induced Abortion: ' + edtAbInduced.Text);
  TmpStrList.Add('  Spontaneous Abortion: ' + edtAbSpont.Text);
  TmpStrList.Add('  Ectopic: ' + edtEctopic.Text);
  TmpStrList.Add('  Multiple Births: ' + lbMultipleBirthsValue.Caption);
  TmpStrList.Add('  Living: ' + lbLivingValue.Caption);

  for I := 0 to pgPregnancy.PageCount - 1 do
    if pgPregnancy.Pages[I].ControlCount > 0 then
      if pgPregnancy.Pages[I].Controls[0] is TfPreg then
      begin
        vPreg := TfPreg(pgPregnancy.Pages[I].Controls[0]);

        TmpStrList.AddStrings(vPreg.GetText);
      end;

  PregListView.Clear;

  for I := 0 to pgPregnancy.PageCount - 1 do
  begin
    if pgPregnancy.Pages[I].ControlCount > 0 then
      if pgPregnancy.Pages[I].Controls[0] is TfPreg then
      begin
        vPreg := TfPreg(pgPregnancy.Pages[I].Controls[0]);

        vPregInfo := vPreg.GetPregInfo;
        if vPregInfo <> nil then
        begin
          lvItem := PregListView.Items.Add;
          lvItem.Caption := 'L';

          for J := 0 to 19 do
            lvItem.SubItems.Add('');

          lvItem.SubItems[0]  := IntToStr(vPreg.PregnancyIEN);                    // IEN
          lvItem.SubItems[7]  := vPregInfo.dtDelivery.Text;                       // PREGNANCY END
          lvItem.SubItems[9]  := '|' + vPregInfo.cbDeliveryPlace.Text;            // PLACE OF DELIVERY
          lvItem.SubItems[11] := vPregInfo.spnGAWeeks.Text + 'W' +                // GESTATIONAL AGE #W#D
                                 vPregInfo.spnGADays.Text  + 'D';
          lvItem.SubItems[12] := vPregInfo.spnLaborLength.Text;                   // LENGTH OF DELIVERY

          if vPregInfo.rgTypeDelivery.ItemIndex = 0 then                          // TYPE OF DELIVERY (C/V)
            lvItem.SubItems[13] := 'V'
          else if vPregInfo.rgTypeDelivery.ItemIndex = 1 then
            lvItem.SubItems[13] := 'C';

          lvItem.SubItems[14] := vPregInfo.cbAnesthesia.Text;                     // ANESTHESIA
          lvItem.SubItems[15] := IntToStr(vPregInfo.rgPretermDelivery.ItemIndex); // PRETERM DELIVERY

          // IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
          lvItem.SubItems[17] := vPreg.GetChildrenV;

          lvItem.SubItems[18] := vPregInfo.cbOutcome.Text;                        // OUTCOME
          lvItem.SubItems[20] := vPregInfo.edtDeliveryAt.Text;                    // DELIVERY AT

          for J := 0 to vPregInfo.meDeliveryNotes.Lines.Count - 1 do              // COMMENTS
          begin
            lvItem := PregListView.Items.Add;
            lvItem.Caption := 'C';
            lvItem.SubItems.Add(IntToStr(vPreg.PregnancyIEN));
            lvItem.SubItems.Add(vPregInfo.meDeliveryNotes.Lines[J]);
          end;
        end;
      end;
  end;
end;

// Private ---------------------------------------------------------------------

procedure TdlgPregHist.PregHeaderChangeOff;
begin
  edtTotPreg.OnChange   := nil;
  edtAbInduced.OnChange := nil;
  edtAbSpont.OnChange   := nil;
  edtEctopic.OnChange   := nil;
end;

procedure TdlgPregHist.PregHeaderChangeOn;
begin
  edtTotPreg.OnChange   := TotPregChange;
  edtAbInduced.OnChange := TotPregChange;
  edtAbSpont.OnChange   := TotPregChange;
  edtEctopic.OnChange   := TotPregChange;
end;

function TdlgPregHist.GetPregInfobyIEN(Value: Integer): TfPreg;
var
  I: Integer;
  vPreg: TfPreg;
begin
  Result := nil;

  if Value < 1 then
    Exit;

  for I := 0 to pgPregnancy.PageCount - 1 do
    if pgPregnancy.Pages[I].ControlCount > 0 then
      if pgPregnancy.Pages[I].Controls[0] is TfPreg then
      begin
        vPreg := TfPreg(pgPregnancy.Pages[I].Controls[0]);
        if vPreg.PregnancyIEN = Value then
        begin
          Result := vPreg;
          Break;
        end;
      end;
end;

// Public ----------------------------------------------------------------------

procedure TdlgPregHist.ModifyPreterm(Value: Integer);
var
  I: Integer;
begin
  I := StrToIntDef(lbPrematureValue.Caption, 0);
  I := I + Value;
  lbPrematureValue.Caption := IntToStr(I);
end;

procedure TdlgPregHist.ModifyFullTerm(Value: Integer);
var
  I: Integer;
begin
  I := StrToIntDef(lbFullTermValue.Caption, 0);
  I := I + Value;
  lbFullTermValue.Caption := IntToStr(I);
end;

procedure TdlgPregHist.ModifyMultiBirth(Value: Integer);
var
  I: Integer;
begin
  I := StrToIntDef(lbMultipleBirthsValue.Caption, 0);
  I := I + Value;
  lbMultipleBirthsValue.Caption := IntToStr(I);
end;

procedure TdlgPregHist.ModifyLiving(Value: Integer);
var
  I: Integer;
begin
  I := StrToIntDef(lbLivingValue.Caption, 0);
  I := I + Value;
  lbLivingValue.Caption := IntToStr(I);
end;

procedure TdlgPregHist.DeletePregnancy(iIndex: Integer);
var
  vPreg: TfPreg;
  I: Integer;
begin
  PregHeaderChangeOff;
  try
    if (iIndex < 0) or (iIndex > pgPregnancy.PageCount - 1) then
      Exit;

    if pgPregnancy.Pages[iIndex].ControlCount > 0 then
      if pgPregnancy.Pages[iIndex].Controls[0] is TfPreg then
      begin
        vPreg := TfPreg(pgPregnancy.Pages[iIndex].Controls[0]);

        case vPreg.PregnancyType of
          ptAI: dec(TotalAI);
          ptAS: dec(TotalAS);
           ptE: dec(TotalE);
        end;
        dec(TotalPreg);
        edtTotPreg.Value   := TotalPreg;
        edtAbInduced.Value := TotalAI;
        edtAbSpont.Value   := TotalAS;
        edtEctopic.Value   := TotalE;

        pgPregnancy.Pages[iIndex].Free;

        for I := 0 to pgPregnancy.PageCount - 1 do
          pgPregnancy.Pages[I].Caption := '# ' + IntToStr(I);
      end;
  finally
    PregHeaderChangeOn;
  end;
end;

end.
