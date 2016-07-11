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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, System.Actions, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin,
  Vcl.ComCtrls, Vcl.ActnList, Vcl.Menus, uDialog, frmPregHistPreg;

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
    lbFullTermValue: TStaticText;
    lbPrematureValue: TStaticText;
    lbMultipleBirthsValue: TStaticText;
    lbLivingValue: TStaticText;
    NavControl: TActionList;
    cbOutcome: TComboBox;
    cbAnesthesia: TComboBox;
    cbDeliveryPlace: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CtrlTab(Sender: TObject);
    procedure CtrlShiftTab(Sender: TObject);
    procedure TotPregChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    TotalPreg,TotalAI,TotalAS,TotalE: Integer;
    procedure PregHeaderChangeOff;
    procedure PregHeaderChangeOn;
    procedure Navigate(Value: Boolean);
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
  frmPregHistPregInfo, frmPregHistChild, uCommon, uReportItems, uExtndComBroker;

function SubCount(str: string; d: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(str) - 1 do
    if str[I] = d then
      inc(Result);
end;

procedure TdlgPregHist.FormCreate(Sender: TObject);
var
  nAct: TAction;
  nItem: TDDCSNoteItem;
begin
  TotalPreg := 0;
  TotalAI   := 0;
  TotalAS   := 0;
  TotalE    := 0;

  dlgPregHist := Self;

  nAct := TAction.Create(NavControl);
  nAct.ActionList := NavControl;
  nAct.ShortCut := ShortCut(VK_TAB, [ssCtrl]);
  nAct.OnExecute := CtrlTab;
  nAct := TAction.Create(NavControl);
  nAct.ActionList := NavControl;
  nAct.ShortCut := ShortCut(VK_TAB, [ssShift, ssCtrl]);
  nAct.OnExecute := CtrlShiftTab;

  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(lbFullTermValue);
  if nItem <> nil then
    nItem.SayOnFocus := 'Full Term';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(lbPrematureValue);
  if nItem <> nil then
    nItem.SayOnFocus := 'Premature';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(lbMultipleBirthsValue);
  if nItem <> nil then
    nItem.SayOnFocus := 'Multiple Births';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(lbLivingValue);
  if nItem <> nil then
    nItem.SayOnFocus := 'Living';
end;

procedure TdlgPregHist.FormShow(Sender: TObject);
var
  I,G,J,L: Integer;
  vPreg: TfPreg;
  vPregInfo: TfPregInfo;
  vPregChild: TfChild;
  cItem: TConfigItem;
  tmp,btmp: string;
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

  if Configuration.Count > 0 then
  begin
    for I := 0 to Configuration.Count - 1 do
    begin
      cItem := Configuration.Items[I];

      if cItem.ID[0] = 'L' then
      begin
        // ---- Add the Pregnancy Tab ------------------------------------------
        tmp := Uppercase(cItem.Piece[20]);    // Outcome
        if tmp = 'ECTOPIC' then
          edtEctopic.Value := edtEctopic.Value + 1
        else if tmp = 'TERMINATION' then
          edtAbInduced.Value := edtAbInduced.Value + 1
        else if tmp = 'SPONTANEOUS ABORTION' then
          edtAbSpont.Value := edtAbSpont.Value + 1
        else
          edtTotPreg.Value := edtTotPreg.Value + 1;
        // ---------------------------------------------------------------------

        // ---- Get the Pregnancy Info Form ------------------------------------
        if pgPregnancy.Pages[pgPregnancy.PageCount - 1].ControlCount > 0 then
          if pgPregnancy.Pages[pgPregnancy.PageCount - 1].Controls[0] is TfPreg then
          begin
            vPreg := TfPreg(pgPregnancy.Pages[pgPregnancy.PageCount - 1].Controls[0]);
            vPreg.PregnancyIEN := StrToIntDef(cItem.Piece[2], 0);
            vPregInfo := vPreg.GetPregInfo;
            if vPregInfo <> nil then
            begin
              if cItem.Piece[6] = 'CURRENT' then
              begin
                vPregInfo.lbStatus.Visible := True;
                if vPregInfo.lbStatus.Caption <> '' then
                  vPregInfo.lbStatus.Caption := vPregInfo.lbStatus.Caption + ' (C)'
                else vPregInfo.lbStatus.Caption := 'CURRENT';
                vPregInfo.Enabled := False;
                vPreg.btnDelete.Enabled := False;
              end;

              vPregInfo.dtDelivery.Text := cItem.Piece[9];

              tmp := cItem.Piece[11];
              if tmp <> '' then
              begin
                if vPregInfo.cbDeliveryPlace.Items.IndexOf(Piece(tmp,'|',2)) <> -1 then
                  vPregInfo.cbDeliveryPlace.ItemIndex := vPregInfo.cbDeliveryPlace.Items.IndexOf(Piece(tmp,'|',2))
                else
                  vPregInfo.cbDeliveryPlace.Text := Piece(tmp,'|',2);
              end;

              tmp := cItem.Piece[13];
              vPregInfo.spnGAWeeks.Value := StrToIntDef(Piece(tmp,'W',1), 0);
              vPregInfo.spnGADays.Value  := StrToIntDef(Piece(Piece(tmp,'D',1),'W',2), 0);

              vPregInfo.spnLaborLength.Value := StrToIntDef(cItem.Piece[14], 0);

              tmp := cItem.Piece[15];
              if tmp = 'V' then
                vPregInfo.rgTypeDelivery.ItemIndex := 0
              else if tmp = 'C' then
                vPregInfo.rgTypeDelivery.ItemIndex := 1;

              tmp := cItem.Piece[16];
              if tmp <> '' then
              begin
                if vPregInfo.cbAnesthesia.Items.IndexOf(tmp) = -1 then
                  vPregInfo.cbAnesthesia.Items.Add(tmp);
                vPregInfo.cbAnesthesia.ItemIndex := vPregInfo.cbAnesthesia.Items.IndexOf(tmp);
              end;

              vPregInfo.rgPretermDelivery.ItemIndex := StrToIntDef(cItem.Piece[17], 0);

              if vPregInfo.cbOutcome.Enabled then
              begin
                tmp := cItem.Piece[20];
                if tmp <> '' then
                begin
                  if vPregInfo.cbOutcome.Items.IndexOf(tmp) = -1 then
                    vPregInfo.cbOutcome.Items.Add(tmp);
                  vPregInfo.cbOutcome.ItemIndex := vPregInfo.cbOutcome.Items.IndexOf(tmp);
                end;
              end;

              vPregInfo.edtDeliveryAt.Value := StrToIntDef(cItem.Piece[22], 0);

              // IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
              tmp := cItem.Piece[19];
              if tmp <> '' then
              begin
                G := SubCount(tmp,'|') + 1;
                for J := 1 to G do
                begin
                  btmp := Piece(tmp,'|',J);
                  // ---- Add the Baby Tab ---------------------------------------
                  vPregInfo.spnBirthCount.Value := vPregInfo.spnBirthCount.Value + 1;
                  // -------------------------------------------------------------

                  // ---- Get the Baby Info Form ---------------------------------
                  if vPreg.pgPreg.PageCount > 1 then
                    if vPreg.pgPreg.Pages[vPreg.pgPreg.PageCount - 1].ControlCount > 0 then
                      if vPreg.pgPreg.Pages[vPreg.pgPreg.PageCount - 1].Controls[0] is TfChild then
                      begin
                        vPregChild := TfChild(vPreg.pgPreg.Pages[vPreg.pgPreg.PageCount - 1].Controls[0]);

                        // IEN
                        vPregChild.BabyIEN := Piece(btmp,';',1);

                        // Baby #
                        // vPregChild.BabyNumber := Piece(btmp,';',2);

                        // Sex
                        if Piece(btmp,';',4) = 'M' then
                          vPregChild.rgSex.ItemIndex := 0
                        else if Piece(btmp,';',4) = 'F' then
                          vPregChild.rgSex.ItemIndex := 1
                        else if Piece(btmp,';',4) = 'U' then
                          vPregChild.rgSex.ItemIndex := 2;

                        // Weight
                        vPregChild.spnG.Value := StrToIntDef(Piece(btmp,';',5), 0);

                        // Stillborn - set status to demise
                        vPregChild.rgLife.ItemIndex := StrToIntDef(Piece(btmp,';',6), 0);
                        // Status
                        if Piece(btmp,';',9) = 'D' then
                         vPregChild.rgLife.ItemIndex := 1;

                        // APGAR1
                        vPregChild.edAPGARone.Text := Piece(btmp,';',7);

                        // APGAR2
                        vPregChild.edAPGARfive.Text := Piece(btmp,';',8);

                        // NICU
                        vPregChild.ckNICU.Checked := (Piece(btmp,';',10) = '1');

                        // Baby Notes
                        cItem := Configuration.LookUp('B', IntToStr(vPreg.PregnancyIEN) + '|' +
                                                      vPregChild.BabyIEN + '|' + vPregChild.BabyNumber, '');
                        if cItem <> nil then
                          for L := 0 to cItem.Data.Count - 1 do
                            vPregChild.meComplications.Lines.Add(Pieces(cItem.Data[L],U,3,9999));
                      end;
                end;
              end;

              // Delivery Notes
              cItem := Configuration.LookUp('C', IntToStr(vPreg.PregnancyIEN), '');
              if cItem <> nil then
                for J := 0 to cItem.Data.Count - 1 do
                  vPregInfo.meDeliveryNotes.Lines.Add(Pieces(cItem.Data[J],U,3,9999));
            end;
          end;
      end;
    end;
  end;

  if pgPregnancy.PageCount > 0 then
  begin
    for I := pgPregnancy.PageCount - 1 downto 0 do
      if pgPregnancy.Pages[I].ControlCount > 0 then
        if pgPregnancy.Pages[I].Controls[0] is TfPreg then
        begin
          vPreg := TfPreg(pgPregnancy.Pages[I].Controls[0]);
          if vPreg.pgPreg.PageCount > 0 then
            vPreg.pgPreg.ActivePageIndex := 0;
        end;

    pgPregnancy.ActivePageIndex := 0;
  end;
end;

procedure TdlgPregHist.CtrlTab(Sender: TObject);
begin
  Navigate(True);
end;

procedure TdlgPregHist.CtrlShiftTab(Sender: TObject);
begin
  Navigate(False);
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

      vPregInfo.cbOutcome.Items.AddStrings(cbOutcome.Items);
      vPregInfo.cbAnesthesia.Items.AddStrings(cbAnesthesia.Items);
      vPregInfo.cbDeliveryPlace.Items.AddStrings(cbDeliveryPlace.Items);

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
  I,J,nPreg: Integer;
  vPreg: TfPreg;
  vPregInfo: TfPregInfo;
  PregID: string;
  cItem: TConfigItem;
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

  nPreg := 0;
  for I := 0 to pgPregnancy.PageCount - 1 do
    if pgPregnancy.Pages[I].ControlCount > 0 then
      if pgPregnancy.Pages[I].Controls[0] is TfPreg then
      begin
        vPreg := TfPreg(pgPregnancy.Pages[I].Controls[0]);
        TmpStrList.AddStrings(vPreg.GetText);

        inc(nPreg);
        if vPreg.PregnancyIEN < 1 then
          PregID := '+' + IntToStr(nPreg)
        else PregID := IntToStr(vPreg.PregnancyIEN);

        // Pregnancy Info
        cItem := Configuration.LookUp('L', PregID, '');
        if cItem = nil then
        begin
          cItem := TConfigItem.Create(Configuration);
          cItem.ID[0] := 'L';
          cItem.ID[1] := PregID;
          cItem.Data.Add('');
        end;
        cItem.Data[0] := vPreg.GetSavePregInfo(PregID);

        // Pregnancy Comments
        cItem := Configuration.LookUp('C', PregID, '');
        if cItem = nil then
        begin
          cItem := TConfigItem.Create(Configuration);
          cItem.ID[0] := 'C';
          cItem.ID[1] := PregID;
        end;
        cItem.Data.Clear;
        cItem.Data.AddStrings(vPreg.GetSavePregComments(PregID));

        // Baby Comments
        vPreg.GetSaveChildComments(PregID);
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

procedure TdlgPregHist.Navigate(Value: Boolean);
var
  wControl: TWinControl;

  procedure NavFrame(wControl: TWinControl);
  begin
    if wControl.Owner is TfPregInfo then
    begin
      if TfPregInfo(wControl.Owner).Owner is TTabSheet then
        TTabSheet(TfPregInfo(wControl.Owner).Owner).PageControl.SelectNextPage(Value);
    end else if wControl.Owner is TfChild then
    begin
      if TfChild(wControl.Owner).Owner is TTabSheet then
        TTabSheet(TfChild(wControl.Owner).Owner).PageControl.SelectNextPage(Value);
    end;
  end;

begin
  wControl := dlgPregHist.ActiveControl;
  if wControl <> nil then
  begin
    if wControl.InheritsFrom(TPageControl) then
      TPageControl(wControl).SelectNextPage(Value)
    else
      if wControl.Owner <> nil then
      begin
        if wControl.Owner = dlgPregHist then
          pgPregnancy.SelectNextPage(Value)
        else if (wControl.Owner is TfPregInfo) or (wControl.Owner is TfChild) then
          NavFrame(wControl)
        else if wControl.Owner is TRadioGroup then
          NavFrame(TWinControl(wControl.Owner));
      end;
  end;
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
