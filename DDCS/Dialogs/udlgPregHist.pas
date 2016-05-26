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
  uDialog, uCommon, uExtndComBroker;

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
    procedure TotPregChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    TotalPreg,TotalAI,TotalAS,TotalE: Integer;
    procedure PregHeaderChangeOff;
    procedure PregHeaderChangeOn;
  public
    procedure ModifyPreterm(Value: Integer);
    procedure ModifyFullTerm(Value: Integer);
    procedure DeletePregnancy(iIndex: Integer);
  end;

var
  dlgPregHist: TdlgPregHist;

implementation

{$R *.dfm}

uses
  frmPregHistPreg, frmPregHistPregInfo, frmPregHistChild;

procedure TdlgPregHist.FormCreate(Sender: TObject);
begin
  TotalPreg := 0;
  TotalAI   := 0;
  TotalAS   := 0;
  TotalE    := 0;

  dlgPregHist := Self;
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
      vTabSheet.Caption := '# '+ IntToStr(vTabSheet.PageIndex + 1);

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
      vPregInfo.rgPretermDelivery.OnEnter := DDCSForm.RadioGroupEnter;

      case TSpinEdit(Sender).Tag of
        1: vPreg.PregnancyType := ptN;
        2: vPreg.PregnancyType := ptAI;
        3: vPreg.PregnancyType := ptAS;
        4: vPreg.PregnancyType := ptE;
      end;
    end;
  finally
    PregHeaderChangeOn;
  end;
end;

procedure TdlgPregHist.btnOKClick(Sender: TObject);
var
  I: Integer;
  vPreg: TfPreg;
begin
  TmpStrList.Add('Pregnancy History: ');
  TmpStrList.Add('  Total Pregnancies: ' + edtTotPreg.Text);
  TmpStrList.Add('  Full Term: ' + lbFullTerm.Caption);
  TmpStrList.Add('  Premature: ' + lbPremature.Caption);
  TmpStrList.Add('  Induced Abortion: ' + edtAbInduced.Text);
  TmpStrList.Add('  Spontaneous Abortion: ' + edtAbSpont.Text);
  TmpStrList.Add('  Ectopic: ' + edtEctopic.Text);
  TmpStrList.Add('  Multiple Births: ' + lbMultipleBirths.Caption);
  TmpStrList.Add('  Living: ' + lbLiving.Caption);

  for I := 0 to pgPregnancy.PageCount - 1 do
    if pgPregnancy.Pages[I].ControlCount > 0 then
      if pgPregnancy.Pages[I].Controls[0] is TfPreg then
      begin
        vPreg := TfPreg(pgPregnancy.Pages[I].Controls[0]);

        TmpStrList.AddStrings(vPreg.GetText);
      end;

//  PregListView.Clear;
//
//  for I := 0 to pgcPregnancy.PageCount - 1 do
//  begin
//    pg := TfrmPregHist(slPregs.Objects[I]);
//    if pg <> nil then
//    begin
//      lvitem := PregListView.Items.Add;
//      lvitem.Caption := 'L';
//      for J := 0 to 19 do
//        lvitem.SubItems.Add('');
//
//      lvitem.SubItems[0] := pg.FPregIEN;                                              //IEN
//
//      if pg.lblStatus.Caption = '*** CURRENT ***' then                                //STATUS
//        lvitem.SubItems[4] := 'CURRENT'
//      else
//        lvitem.SubItems[4] := 'HISTORICAL';
//
//      lvitem.SubItems[7] := pg.edtDateOfDelivery.Text;                                //PREGNANCY END
//      lvitem.SubItems[9] := '|' + pg.CB_PlaceofDelivery.Text;                         //PLACE OF DELIVERY
//      lvitem.SubItems[11] := pg.SPN_GAWeeks.Text + 'W' + pg.SPN_GADays.Text + 'D';    //GESTATIONAL AGE #W#D
//      lvitem.SubItems[12] := pg.E_LengthofLabor.Text;                                 //LENGTH OF LABOR
//      lvitem.SubItems[13] := pg.E_TypeofDelivery.Text;                                //TYPE OF DELIVERY
//
//      if pg.cbAnesthesia.ItemIndex <> -1 then                                         //ANESTHESIA
//        lvitem.SubItems[14] := pg.cbAnesthesia.Items[pg.cbAnesthesia.ItemIndex];
//
//      if pg.cxRadioGroup_PretermLabor.ItemIndex <> -1 then                            //PRETERM LABOR
//        lvitem.SubItems[15] := IntToStr(pg.cxRadioGroup_PretermLabor.ItemIndex);
//
//      with pg.pgcChildNumber do                                                       //IEN;BABY#;SEX;WEIGHT;STILLBORN|
//      begin
//        str := '';
//        for K := 0 to pg.pgcChildNumber.PageCount - 1 do
//        begin
//          pgChild := TfrmChildHist(pg.GetChildForm(K+1));
//          if pgChild <> nil then
//          begin
//            if str <> '' then
//              str := str + '|';
//
//            str := str + pgChild.FBabyIEN + ';' + IntToStr(K+1) + ';';
//
//            if pgChild.rgbxChildGender.ItemIndex = 0 then
//              str := str + 'M;'
//            else if pgChild.rgbxChildGender.ItemIndex = 1 then
//              str := str + 'F;'
//            else
//              str := str + ';';
//
//            str := str + pgChild.spnBirthWeight.Text + ';';
//
//            if pgChild.cntcbxStillBorn.Checked then
//              str := str + '1';
//          end;
//        end;
//        lvitem.SubItems[17] := str;
//      end;
//
//      lvitem.SubItems[18] := pg.FType;                                               //COMPLICATION
//
//      for K := 0 to pg.MO_CommentComplication.Lines.Count - 1 do                     //COMMENTS
//      begin
//        lvitemc := PregListView.Items.Add;
//        lvitemc.Caption := 'C';
//        lvitemc.SubItems.Add(pg.FPregIEN);
//        lvitemc.SubItems.Add(pg.MO_CommentComplication.Lines[K]);
//      end;
//    end;
//  end;
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

//procedure TdlgPregHist.FormShow(Sender: TObject);
//var
//  I,J,T,tVal: Integer;
//  iTmpTotPreg,iTmpAbSpon,iTmpAbInduce,iTmpEctopic,iMultBirths,iCalcBirths: Integer;
//  pg: TfrmPregHist;
//  pgChild: TfrmChildHist;
//  val: string;
//
//  function SubCount(str: string; d: Char): Integer;
//  var
//    I: Integer;
//  begin
//    Result := 0;
//    for I := 0 to Length(str) - 1 do
//      if str[I] = d then
//        inc(Result);
//  end;
//
//  function getPregForm(iVal: string): TfrmPregHist;
//  var
//    I: Integer;
//  begin
//    Result := nil;
//
//    for I := 0 to slPregs.Count - 1 do
//      if TfrmPregHist(slPregs.Objects[I]).IEN = iVal then
//      begin
//        Result := TfrmPregHist(slPregs.Objects[I]);
//        Break;
//      end;
//  end;
//
//begin
//  slPregs := TStringList.Create(True);
//
//  edtTotPreg.OnChange   := nil;
//  edtAbInduced.OnChange := nil;
//  edtAbSpont.OnChange   := nil;
//  edtEctopic.OnChange   := nil;
//  try
//    edtTotPreg.Value := 0;
//    edtAbInduced.Value := 0;
//    edtAbSpont.Value := 0;
//    edtEctopic.Value := 0;
//
//    //  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
//    //    EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
//    //    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE^LENGTH OF DELIVERY^
//    //    TYPE OF DELIVERY^ANESTHESIA^PRETERM LABOR^BIRTH TYPE^IEN;BABY |IEN;BABY^
//    //    OUTCOME
//    //  C^IEN^COMMENT
//
//    for I := 0 to PregListView.Items.Count - 1 do
//      for J := PregListView.Items.Item[I].SubItems.Count - 1 to 19 do
//        PregListView.Items.Item[I].SubItems.Add('');
//
//    for I := 0 to PregListView.Items.Count - 1 do
//    begin
//      if PregListView.Items.Item[I].Caption = 'L' then
//      begin
//        edtTotPreg.Value := edtTotPreg.Value + 1;
//        rPreg := rPreg + 1;
//        pg := TfrmPregHist(AddPage(Sender,PregListView.Items.Item[I].SubItems[0]));
//
//        for J := 0 to PregListView.Items.Item[I].SubItems.Count - 1 do
//        begin
//          val := PregListView.Items.Item[I].SubItems[J];
//          if val <> '' then
//          case J of
//            0 : pg.FPregIEN := val;                                            //IEN
//            1 : ;                                                              //DATE RECORDED
//            2 : ;                                                              //EDC
//            3 : ;                                                              //DFN|PATIENT
//            4 : if val = 'CURRENT' then                                        //STATUS
//                begin
//                  pg.lblStatus.Caption := '*** CURRENT ***';
//
//                  for T := 0 to pg.ComponentCount - 1 do
//                    if pg.Components[T] is TWinControl then
//                      if ((pg.Components[T].ClassType <> TForm) and (pg.Components[T].ClassType <> TPanel) and
//                         (pg.Components[T].ClassType <> TMemo)) then
//                      TWinControl(pg.Components[T]).Enabled := False;
//                end;
//            5 : ;                                                              //FOF|(IEN OR IDENTIFIER)
//            6 : ;                                                              //EDD
//            7 : pg.edtDateOfDelivery.Text := val;                              //PREGNANCY END
//            8 : ;                                                              //OB IEN|OB
//            9 : pg.CB_PlaceofDelivery.Text := Piece(val,'|',2);                //FACILITY IEN|FACILITY
//           10 : ;                                                              //UPDATED BY IEN|UPDATED BY
//           11 : begin                                                          //GESTATIONAL AGE
//                  if TryStrToInt(Piece(val,'W',1),tVal) then
//                    pg.SPN_GAWeeks.Value := tVal;
//                  if TryStrToInt(Piece(Piece(val,'D',1),'W',2),tVal) then
//                    pg.SPN_GADays.Value := tVal;
//                end;
//           12 : pg.E_LengthofLabor.Text := val;                                //LENGTH OF DELIVERY
//           13 : begin                                                          //TYPE OF DELIVERY
//                  for T := 0 to pg.E_TypeofDelivery.Items.Count - 1 do
//                    if AnsiCompareText(pg.E_TypeofDelivery.Items[T],val) = 0 then
//                    begin
//                      pg.E_TypeofDelivery.ItemIndex := T;
//                      Break;
//                    end;
//
//                  if pg.E_TypeofDelivery.ItemIndex = -1 then
//                  begin
//                    pg.E_TypeofDelivery.Items.Add(val);
//                    pg.E_TypeofDelivery.ItemIndex := pg.E_TypeofDelivery.Items.Count - 1;
//                  end;
//                end;
//           14 : begin                                                          //ANESTHESIA
//                  for T := 0 to pg.cbAnesthesia.Items.Count - 1 do
//                    if UpperCase(pg.cbAnesthesia.Items[T]) = UpperCase(val) then
//                    begin
//                      pg.cbAnesthesia.ItemIndex := T;
//                      Break;
//                    end;
//
//                  if ((pg.cbAnesthesia.ItemIndex = -1) and (val <> '')) then
//                  begin
//                    pg.cbAnesthesia.Items.Add(val);
//                    pg.cbAnesthesia.ItemIndex := pg.cbAnesthesia.Items.Count - 1;
//                  end;
//                end;
//           15 : begin                                                          //PRETERM LABOR
//                  if val = '1' then
//                    pg.cxRadioGroup_PretermLabor.ItemIndex := 1
//                  else if val = '0' then
//                    pg.cxRadioGroup_PretermLabor.ItemIndex := 0;
//                end;
//           16 : ;                                                              //BIRTH TYPE
//           17 : begin                                                          //IEN;BABY#;SEX;WEIGHT;STILLBORN|
//                  for T := 1 to SubCount(val,'|') + 1 do
//                  begin
//                    if T > 1 then
//                    begin
//                      pg.cxRadioGroupBirthType.ItemIndex := 1;
//
//                      if T > 2 then
//                        pg.JvSpinEdit1.Value := pg.JvSpinEdit1.Value + 1;
//                    end else
//                    if ((T > 0) and (T < 2)) then
//                      pg.cxRadioGroupBirthType.ItemIndex := 0;
//
//                    pgChild := TfrmChildHist(pg.GetChildForm(T));
//                    if pgChild <> nil then
//                    begin
//                      if Piece(Piece(val,'|',T),';',1) <> '' then
//                        pgChild.FBabyIEN :=  Piece(Piece(val,'|',T),';',1);
//
//                      if Piece(Piece(val,'|',T),';',3) = 'M' then
//                        pgChild.rgbxChildGender.ItemIndex := 0
//                      else if Piece(Piece(val,'|',T),';',3) = 'F' then
//                        pgChild.rgbxChildGender.ItemIndex := 1;
//
//                      if Piece(Piece(val,'|',T),';',4) <> '' then
//                        pgChild.spnBirthWeight.Value := StrToFloat(Piece(Piece(val,'|',T),';',4));
//
//                      if Piece(Piece(val,'|',T),';',5) = '1' then
//                        pgChild.cntcbxStillBorn.Checked := True;
//                    end;
//                  end;
//                end;
//           18 : begin                                                            //OUTCOME
//                  pg.FType := val;
//
//                  if val = 'E' then
//                  begin
//                    edtEctopic.Value := edtEctopic.Value + 1;
//                    pg.lblStatus.Caption := '*** ECTOPIC ***';
//                  end else if val = 'AI' then
//                  begin
//                    edtAbInduced.Value := edtAbInduced.Value + 1;
//                    pg.lblStatus.Caption := '*** AB. INDUCED ***';
//                  end else if val = 'AS' then
//                  begin
//                    edtAbSpont.Value := edtAbSpont.Value + 1;
//                    pg.lblStatus.Caption := '*** AB. SPONTANEOUS ***';
//                  end;
//                end;
//          end;
//        end;
//
//        for J := 0 to PregListView.Items.Count - 1 do
//          if ((PregListView.Items.Item[J].Caption = 'C') and (PregListView.Items.Item[J].SubItems[0] = pg.FPregIEN)) then
//            pg.MO_CommentComplication.Lines.Add(PregListView.Items.Item[J].SubItems[1]);
//
//        val := '';
//        for J := 0 to pg.MO_CommentComplication.Lines.Count - 1 do
//          if Trim(pg.MO_CommentComplication.Lines[J]) <> '' then
//            val := '*';
//
//        if val = '' then
//          pg.MO_CommentComplication.Clear;
//
//      end;
//    end;
//  finally
//    spnTotPreg := edtTotPreg.Value;
//    spnAbInduced := edtAbInduced.Value;
//    spnAbSpont := edtAbSpont.Value;
//    spnEctopic := edtEctopic.Value;
//
//    for I := 0 to pgcPregnancy.PageCount - 1 do
//      pgcPregnancy.Pages[I].Caption := 'Pregnancy #' + IntToStr(I+1);
//
//    if pgcPregnancy.PageCount > 0 then
//      pgcPregnancy.ActivePageIndex := 0;
//
//    iCalcBirths := 0;
//    iMultBirths := 0;
//    for I := 0 to slPregs.Count - 1 do
//    begin
//      iCalcBirths := iCalcBirths + TfrmPregHist(slPregs.Objects[I]).GetLiveBirths;
//      if TfrmPregHist(slPregs.Objects[I]).cxRadioGroupBirthType.ItemIndex = 1 then
//        Inc(iMultBirths);
//    end;
//
//    SetLiveBirthCount(iCalcBirths);
//    ModifyBirthTypes;
//    CalculateMultiPregs;
//
//    edtTotPreg.OnChange   := edtTotPregChange;
//    edtAbInduced.OnChange := edtTotPregChange;
//    edtAbSpont.OnChange   := edtTotPregChange;
//    edtEctopic.OnChange   := edtTotPregChange;
//  end;
//end;

end.
