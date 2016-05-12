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

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Vcl.Samples.Spin, Mask, System.StrUtils,
  uDialog, uCommon, uExtndComBroker, VA508AccessibilityManager;

type
  TdlgPregHist = class(TDDCSDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pgcPregnancy: TPageControl;
    edtAbInduced: TSpinEdit;
    edtAbSpont: TSpinEdit;
    edtTotPreg: TSpinEdit;
    edtEctopic: TSpinEdit;
    PregListView: TListView;
    edLiveBirths: TEdit;
    edMultipleBirths: TEdit;
    edPremature: TEdit;
    edFullTerm: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtTotPregChange(Sender: TObject);
    procedure pgcPregnancyChange(Sender: TObject);
    procedure pgcPregnancyChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
  private
    slPregs: TStringList;
    spnTotPreg,spnAbInduced,spnAbSpont,spnEctopic: Integer;
    function AddPage(Sender: TObject; iIEN: string): TDDCSDialog;
  protected
  public
    procedure CalculateMultiPregs;
    procedure ModifyLiveBirthCount(NmbrChldrn: Integer);
    procedure SetLiveBirthCount(NmbrChldrn: Integer);
    procedure ModifyBirthTypes;
  end;

var
  dlgPregHist: TdlgPregHist;
  LiveBirths,iFullTerm,iPremature: Integer;
  rPreg: Integer;

implementation

uses
  VAUtils, fPregHist, fChildHist, udlgModTotPregs;

{$R *.dfm}

procedure TdlgPregHist.CalculateMultiPregs;
var
  I,J: Integer;
  pg: TfrmPregHist;
begin
  J := 0;

  for I := 0 to slPregs.Count - 1 do
  begin
    pg := TfrmPregHist(slPregs.Objects[I]);

    if pg.cxRadioGroupBirthType.ItemIndex = 1 then
      Inc(J);
  end;

  edMultipleBirths.Text := IntToStr(J);
end;

procedure TdlgPregHist.ModifyLiveBirthCount(NmbrChldrn: Integer);
begin
  LiveBirths := LiveBirths + NmbrChldrn;
  edLiveBirths.Text := IntToStr(LiveBirths);
end;

procedure TdlgPregHist.SetLiveBirthCount(NmbrChldrn: Integer);
begin
  LiveBirths := NmbrChldrn;
  edLiveBirths.Text := IntToStr(LiveBirths);
end;

procedure TdlgPregHist.ModifyBirthTypes;
var
  I: Integer;
  pg: TfrmPregHist;
begin
  iFullTerm := 0;
  iPremature := 0;
  
  for I := 0 to slPregs.Count - 1 do
  begin
    pg := TfrmPregHist(slPregs.Objects[I]);
    if pg.cxRadioGroupBirthType.ItemIndex <> -1 then
    begin
      if pg.cxRadioGroup_PretermLabor.ItemIndex = 1 then
        Inc(iPremature)
      else if pg.cxRadioGroup_PretermLabor.ItemIndex = 0 then
        Inc(iFullTerm);
    end;
  end;

  edFullTerm.Text := IntToStr(iFullTerm);
  edPremature.Text := IntToStr(iPremature);
end;

procedure TdlgPregHist.FormShow(Sender: TObject);
var
  I,J,T,tVal: Integer;
  iTmpTotPreg,iTmpAbSpon,iTmpAbInduce,iTmpEctopic,iMultBirths,iCalcBirths: Integer;
  pg: TfrmPregHist;
  pgChild: TfrmChildHist;
  val: string;

  function SubCount(str: string; d: Char): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to Length(str) - 1 do
      if str[I] = d then
        inc(Result);
  end;

  function getPregForm(iVal: string): TfrmPregHist;
  var
    I: Integer;
  begin
    Result := nil;

    for I := 0 to slPregs.Count - 1 do
      if TfrmPregHist(slPregs.Objects[I]).IEN = iVal then
      begin
        Result := TfrmPregHist(slPregs.Objects[I]);
        Break;
      end;
  end;

begin
  slPregs := TStringList.Create(True);

  edtTotPreg.OnChange   := nil;
  edtAbInduced.OnChange := nil;
  edtAbSpont.OnChange   := nil;
  edtEctopic.OnChange   := nil;
  try
    edtTotPreg.Value := 0;
    edtAbInduced.Value := 0;
    edtAbSpont.Value := 0;
    edtEctopic.Value := 0;

    //  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
    //    EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
    //    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE^LENGTH OF DELIVERY^
    //    TYPE OF DELIVERY^ANESTHESIA^PRETERM LABOR^BIRTH TYPE^IEN;BABY |IEN;BABY^
    //    OUTCOME
    //  C^IEN^COMMENT

    for I := 0 to PregListView.Items.Count - 1 do
      for J := PregListView.Items.Item[I].SubItems.Count - 1 to 19 do
        PregListView.Items.Item[I].SubItems.Add('');

    for I := 0 to PregListView.Items.Count - 1 do
    begin
      if PregListView.Items.Item[I].Caption = 'L' then
      begin
        edtTotPreg.Value := edtTotPreg.Value + 1;
        rPreg := rPreg + 1;
        pg := TfrmPregHist(AddPage(Sender,PregListView.Items.Item[I].SubItems[0]));

        for J := 0 to PregListView.Items.Item[I].SubItems.Count - 1 do
        begin
          val := PregListView.Items.Item[I].SubItems[J];
          if val <> '' then
          case J of
            0 : pg.FPregIEN := val;                                            //IEN
            1 : ;                                                              //DATE RECORDED
            2 : ;                                                              //EDC
            3 : ;                                                              //DFN|PATIENT
            4 : if val = 'CURRENT' then                                        //STATUS
                begin
                  pg.lblStatus.Caption := '*** CURRENT ***';

                  for T := 0 to pg.ComponentCount - 1 do
                    if pg.Components[T] is TWinControl then
                      if ((pg.Components[T].ClassType <> TForm) and (pg.Components[T].ClassType <> TPanel) and
                         (pg.Components[T].ClassType <> TMemo)) then
                      TWinControl(pg.Components[T]).Enabled := False;
                end;
            5 : ;                                                              //FOF|(IEN OR IDENTIFIER)
            6 : ;                                                              //EDD
            7 : pg.edtDateOfDelivery.Text := val;                              //PREGNANCY END
            8 : ;                                                              //OB IEN|OB
            9 : pg.CB_PlaceofDelivery.Text := Piece(val,'|',2);                //FACILITY IEN|FACILITY
           10 : ;                                                              //UPDATED BY IEN|UPDATED BY
           11 : begin                                                          //GESTATIONAL AGE
                  if TryStrToInt(Piece(val,'W',1),tVal) then
                    pg.SPN_GAWeeks.Value := tVal;
                  if TryStrToInt(Piece(Piece(val,'D',1),'W',2),tVal) then
                    pg.SPN_GADays.Value := tVal;
                end;
           12 : pg.E_LengthofLabor.Text := val;                                //LENGTH OF DELIVERY
           13 : begin                                                          //TYPE OF DELIVERY
                  for T := 0 to pg.E_TypeofDelivery.Items.Count - 1 do
                    if AnsiCompareText(pg.E_TypeofDelivery.Items[T],val) = 0 then
                    begin
                      pg.E_TypeofDelivery.ItemIndex := T;
                      Break;
                    end;

                  if pg.E_TypeofDelivery.ItemIndex = -1 then
                  begin
                    pg.E_TypeofDelivery.Items.Add(val);
                    pg.E_TypeofDelivery.ItemIndex := pg.E_TypeofDelivery.Items.Count - 1;
                  end;
                end;
           14 : begin                                                          //ANESTHESIA
                  for T := 0 to pg.cbAnesthesia.Items.Count - 1 do
                    if UpperCase(pg.cbAnesthesia.Items[T]) = UpperCase(val) then
                    begin
                      pg.cbAnesthesia.ItemIndex := T;
                      Break;
                    end;

                  if ((pg.cbAnesthesia.ItemIndex = -1) and (val <> '')) then
                  begin
                    pg.cbAnesthesia.Items.Add(val);
                    pg.cbAnesthesia.ItemIndex := pg.cbAnesthesia.Items.Count - 1;
                  end;
                end;
           15 : begin                                                          //PRETERM LABOR
                  if val = '1' then
                    pg.cxRadioGroup_PretermLabor.ItemIndex := 1
                  else if val = '0' then
                    pg.cxRadioGroup_PretermLabor.ItemIndex := 0;
                end;
           16 : ;                                                              //BIRTH TYPE
           17 : begin                                                          //IEN;BABY#;SEX;WEIGHT;STILLBORN|
                  for T := 1 to SubCount(val,'|') + 1 do
                  begin
                    if T > 1 then
                    begin
                      pg.cxRadioGroupBirthType.ItemIndex := 1;

                      if T > 2 then
                        pg.JvSpinEdit1.Value := pg.JvSpinEdit1.Value + 1;
                    end else
                    if ((T > 0) and (T < 2)) then
                      pg.cxRadioGroupBirthType.ItemIndex := 0;

                    pgChild := TfrmChildHist(pg.GetChildForm(T));
                    if pgChild <> nil then
                    begin
                      if Piece(Piece(val,'|',T),';',1) <> '' then
                        pgChild.FBabyIEN :=  Piece(Piece(val,'|',T),';',1);

                      if Piece(Piece(val,'|',T),';',3) = 'M' then
                        pgChild.rgbxChildGender.ItemIndex := 0
                      else if Piece(Piece(val,'|',T),';',3) = 'F' then
                        pgChild.rgbxChildGender.ItemIndex := 1;

                      if Piece(Piece(val,'|',T),';',4) <> '' then
                        pgChild.spnBirthWeight.Value := StrToFloat(Piece(Piece(val,'|',T),';',4));

                      if Piece(Piece(val,'|',T),';',5) = '1' then
                        pgChild.cntcbxStillBorn.Checked := True;
                    end;
                  end;
                end;
           18 : begin                                                            //OUTCOME
                  pg.FType := val;

                  if val = 'E' then
                  begin
                    edtEctopic.Value := edtEctopic.Value + 1;
                    pg.lblStatus.Caption := '*** ECTOPIC ***';
                  end else if val = 'AI' then
                  begin
                    edtAbInduced.Value := edtAbInduced.Value + 1;
                    pg.lblStatus.Caption := '*** AB. INDUCED ***';
                  end else if val = 'AS' then
                  begin
                    edtAbSpont.Value := edtAbSpont.Value + 1;
                    pg.lblStatus.Caption := '*** AB. SPONTANEOUS ***';
                  end;
                end;
          end;
        end;

        for J := 0 to PregListView.Items.Count - 1 do
          if ((PregListView.Items.Item[J].Caption = 'C') and (PregListView.Items.Item[J].SubItems[0] = pg.FPregIEN)) then
            pg.MO_CommentComplication.Lines.Add(PregListView.Items.Item[J].SubItems[1]);

        val := '';
        for J := 0 to pg.MO_CommentComplication.Lines.Count - 1 do
          if Trim(pg.MO_CommentComplication.Lines[J]) <> '' then
            val := '*';

        if val = '' then
          pg.MO_CommentComplication.Clear;

      end;
    end;
  finally
    spnTotPreg := edtTotPreg.Value;
    spnAbInduced := edtAbInduced.Value;
    spnAbSpont := edtAbSpont.Value;
    spnEctopic := edtEctopic.Value;

    for I := 0 to pgcPregnancy.PageCount - 1 do
      pgcPregnancy.Pages[I].Caption := 'Pregnancy #' + IntToStr(I+1);

    if pgcPregnancy.PageCount > 0 then
      pgcPregnancy.ActivePageIndex := 0;

    iCalcBirths := 0;
    iMultBirths := 0;
    for I := 0 to slPregs.Count - 1 do
    begin
      iCalcBirths := iCalcBirths + TfrmPregHist(slPregs.Objects[I]).GetLiveBirths;
      if TfrmPregHist(slPregs.Objects[I]).cxRadioGroupBirthType.ItemIndex = 1 then
        Inc(iMultBirths);
    end;

    SetLiveBirthCount(iCalcBirths);
    ModifyBirthTypes;
    CalculateMultiPregs;

    edtTotPreg.OnChange   := edtTotPregChange;
    edtAbInduced.OnChange := edtTotPregChange;
    edtAbSpont.OnChange   := edtTotPregChange;
    edtEctopic.OnChange   := edtTotPregChange;
  end;
end;

procedure TdlgPregHist.FormDestroy(Sender: TObject);
begin
  if Assigned(slPregs) then
    slPregs.Free;
end;

procedure TdlgPregHist.pgcPregnancyChange(Sender: TObject);
begin
  if TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).edtDateOfDelivery.Enabled then
    TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).edtDateOfDelivery.SetFocus;

  TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).bNotViewed := False;
end;

procedure TdlgPregHist.pgcPregnancyChanging(Sender: TObject; var AllowChange: Boolean);
var
  Missed: string;
begin
  if TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).AllChildrenNotViewed(Missed) then
    if MessageDlg(Missed, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      AllowChange := False;
end;

procedure TdlgPregHist.bbtnOKClick(Sender: TObject);
var
  CompChecked,I,J,K,TotPregs,TotMult,cntr: Integer;
  vPregValidateStr,str: string;
  slTmp: TStringList;
  bNotAllPregsViewed: Boolean;
  pg: TfrmPregHist;
  pgChild: TfrmChildHist;
  lvitem,lvitemc: TListItem;
begin
  vPregValidateStr :='';
  bNotAllPregsViewed := False;

  for I := 0 to slPregs.Count - 1 do
  begin
    if TfrmPregHist(slPregs.Objects[I]).bNotViewed then
    begin
      bNotAllPregsViewed := True;
      if vPregValidateStr <> '' then
        vPregValidateStr := vPregValidateStr + ', ' + IntToStr(I+1)
      else
        vPregValidateStr := IntToStr(I+1);
    end;
  end;

  if bNotAllPregsViewed then
    if MessageDlg('You have not visited all of the Past Pregnacy Tab(s).' + #10#13 +
                  'You have missed Tab(s) ' +  vPregValidateStr + '.' + #10#13 +
                  'Would you like to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;

  TmpStrList.Add('Pregnancy History: ');
  TmpStrList.Add('  Total Pregnancies: ' + edtTotPreg.Text);
  TmpStrList.Add('  Full Term: ' + edFullTerm.Text);
  TmpStrList.Add('  Premature: ' + edPremature.Text);
  TmpStrList.Add('  Ab. Induced: ' + edtAbInduced.Text);
  TmpStrList.Add('  Ab. Spontaneous: ' + edtAbSpont.Text);
  TmpStrList.Add('  Ectopics: ' + edtEctopic.Text);
  TmpStrList.Add('  Multiple Births: ' + edMultipleBirths.Text);
  TmpStrList.Add('  Living: ' + edLiveBirths.Text);

  slTmp := TStringList.Create;
  try
    for cntr := 0 to slPregs.Count - 1 do
    begin
      TmpStrList.Add(slPregs[cntr]);
      slTmp.Clear;
      TfrmPregHist(slPregs.Objects[cntr]).GetText(slTmp);
      TmpStrList.AddStrings(slTmp);
    end;
  finally
    slTmp.Free;
  end;

  PregListView.Clear;

  for I := 0 to pgcPregnancy.PageCount - 1 do
  begin
    pg := TfrmPregHist(slPregs.Objects[I]);
    if pg <> nil then
    begin
      lvitem := PregListView.Items.Add;
      lvitem.Caption := 'L';
      for J := 0 to 19 do
        lvitem.SubItems.Add('');

      lvitem.SubItems[0] := pg.FPregIEN;                                              //IEN

      if pg.lblStatus.Caption = '*** CURRENT ***' then                                //STATUS
        lvitem.SubItems[4] := 'CURRENT'
      else
        lvitem.SubItems[4] := 'HISTORICAL';

      lvitem.SubItems[7] := pg.edtDateOfDelivery.Text;                                //PREGNANCY END
      lvitem.SubItems[9] := '|' + pg.CB_PlaceofDelivery.Text;                         //PLACE OF DELIVERY
      lvitem.SubItems[11] := pg.SPN_GAWeeks.Text + 'W' + pg.SPN_GADays.Text + 'D';    //GESTATIONAL AGE #W#D
      lvitem.SubItems[12] := pg.E_LengthofLabor.Text;                                 //LENGTH OF LABOR
      lvitem.SubItems[13] := pg.E_TypeofDelivery.Text;                                //TYPE OF DELIVERY

      if pg.cbAnesthesia.ItemIndex <> -1 then                                         //ANESTHESIA
        lvitem.SubItems[14] := pg.cbAnesthesia.Items[pg.cbAnesthesia.ItemIndex];

      if pg.cxRadioGroup_PretermLabor.ItemIndex <> -1 then                            //PRETERM LABOR
        lvitem.SubItems[15] := IntToStr(pg.cxRadioGroup_PretermLabor.ItemIndex);

      with pg.pgcChildNumber do                                                       //IEN;BABY#;SEX;WEIGHT;STILLBORN|
      begin
        str := '';
        for K := 0 to pg.pgcChildNumber.PageCount - 1 do
        begin
          pgChild := TfrmChildHist(pg.GetChildForm(K+1));
          if pgChild <> nil then
          begin
            if str <> '' then
              str := str + '|';

            str := str + pgChild.FBabyIEN + ';' + IntToStr(K+1) + ';';

            if pgChild.rgbxChildGender.ItemIndex = 0 then
              str := str + 'M;'
            else if pgChild.rgbxChildGender.ItemIndex = 1 then
              str := str + 'F;'
            else
              str := str + ';';

            str := str + pgChild.spnBirthWeight.Text + ';';

            if pgChild.cntcbxStillBorn.Checked then
              str := str + '1';
          end;
        end;
        lvitem.SubItems[17] := str;
      end;

      lvitem.SubItems[18] := pg.FType;                                               //COMPLICATION

      for K := 0 to pg.MO_CommentComplication.Lines.Count - 1 do                     //COMMENTS
      begin
        lvitemc := PregListView.Items.Add;
        lvitemc.Caption := 'C';
        lvitemc.SubItems.Add(pg.FPregIEN);
        lvitemc.SubItems.Add(pg.MO_CommentComplication.Lines[K]);
      end;
    end;
  end;

  ModalResult := mrOK;
end;

function TdlgPregHist.AddPage(Sender: TObject; iIEN: string): TDDCSDialog;
var
  tabControl: TTabSheet;
  lvitem: TListItem;
  I: Integer;
begin
  tabControl := TTabSheet.Create(nil);
  tabControl.PageControl := pgcPregnancy;
  tabControl.Name := 'tsht' + IntToStr(pgcPregnancy.PageCount);
  tabControl.Caption := 'Pregnancy #' + IntToStr(pgcPregnancy.PageCount);

  Result := TfrmPregHist.Create(tabControl, @RPCBrokerV, False, '');
  Result.Parent := tabControl;
  InsertComponent(Result);
  Result.Left := 0;
  Result.Top := 0;
  Result.BorderStyle := bsNone;
  Result.Position := poDefault;
  Result.FormStyle := fsNormal;
  Result.Align := alClient;
  Result.Visible := True;
  TfrmPregHist(Result).FPregIEN := iIEN;
  TfrmPregHist(Result).FType := TSpinEdit(Sender).Hint;

  slPregs.AddObject(tabControl.Caption,Result);

  if AnsiContainsStr(iIEN,'+') then
  begin
    lvitem := PregListView.Items.Add;
    lvitem.Caption := 'L';
    for I := 0 to 19 do
      lvitem.SubItems.Add('');

    lvitem.SubItems[0] := TfrmPregHist(Result).FPregIEN;
    lvitem.SubItems[18] := TfrmPregHist(Result).FType;

    if lvitem.SubItems[18] = 'E' then
      TfrmPregHist(Result).lblStatus.Caption := '*** ECTOPIC ***'
    else if lvitem.SubItems[18] = 'AI' then
      TfrmPregHist(Result).lblStatus.Caption := '*** AB. INDUCED ***'
    else if lvitem.SubItems[18] = 'AS' then
      TfrmPregHist(Result).lblStatus.Caption := '*** AB. SPONTANEOUS ***';
  end;

  pgcPregnancy.ActivePageIndex := tabControl.PageIndex;
end;

procedure TdlgPregHist.edtTotPregChange(Sender: TObject);
var
  I,J: Integer;
  iTmpTotPreg,iTmpAbSpon,iTmpAbInduce,iTmpEctopic,iMultBirths,iCalcBirths: Integer;
  frmTmpPregHist: TfrmPregHist;
  dlgModTotPregs: TdlgModTotPregs;
begin
  if TSpinEdit(Sender).Value < 0 then
  begin
    TSpinEdit(Sender).Value := 0;
    Exit;
  end;

  edtTotPreg.OnChange   := nil;
  edtAbInduced.OnChange := nil;
  edtAbSpont.OnChange   := nil;
  edtEctopic.OnChange   := nil;
  try
    if ((TSpinEdit(Sender) = edtAbInduced) and (TSpinEdit(Sender).Value > spnAbInduced)) or
       ((TSpinEdit(Sender) = edtAbSpont) and (TSpinEdit(Sender).Value > spnAbSpont)) or
       ((TSpinEdit(Sender) = edtEctopic) and (TSpinEdit(Sender).Value > spnEctopic))
    then
      edtTotPreg.Value := edtTotPreg.Value + 1
    else if ((TSpinEdit(Sender) = edtAbInduced) and (TSpinEdit(Sender).Value < spnAbInduced)) or
            ((TSpinEdit(Sender) = edtAbSpont) and (TSpinEdit(Sender).Value < spnAbSpont)) or
            ((TSpinEdit(Sender) = edtEctopic) and (TSpinEdit(Sender).Value < spnEctopic))
         then
           edtTotPreg.Value := edtTotPreg.Value - 1;

    iTmpTotPreg  := StrToIntDef(edtTotPreg.Text,0);
    iTmpAbSpon   := StrToIntDef(edtAbSpont.Text,0);
    iTmpAbInduce := StrToIntDef(edtAbInduced.Text,0);
    iTmpEctopic  := StrToIntDef(edtEctopic.Text,0);

    if iTmpTotPreg < slPregs.Count then
    begin
      dlgModTotPregs := TdlgModTotPregs.Create(Self);
      try
        if dlgModTotPregs.ShowModal <> mrOk then
        begin
          if TSpinEdit(Sender) = edtTotPreg then
            TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1
          else begin
            edtTotPreg.Value := edtTotPreg.Value + 1;
            TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1;
          end;
        end else begin
          frmTmpPregHist := TfrmPregHist(slPregs.Objects[dlgModTotPregs.deletepage - 1]);
          if frmTmpPregHist <> nil then
          begin
            if frmTmpPregHist.FType <> TSpinEdit(Sender).Hint then
            begin
              if TSpinEdit(Sender) = edtTotPreg then
                TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1
              else begin
                edtTotPreg.Value := edtTotPreg.Value + 1;
                TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1;
              end;

              if MessageDlg('You must choose a pregnacy of the same selection type.',mtInformation,[mbOK],0) = mrOk then
                Exit
              else Exit;
            end;
            if frmTmpPregHist.lblStatus.Caption = '*** CURRENT ***' then
            begin
              if TSpinEdit(Sender) = edtTotPreg then
                TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1
              else begin
                edtTotPreg.Value := edtTotPreg.Value + 1;
                TSpinEdit(Sender).Value := TSpinEdit(Sender).Value + 1;
              end;

              if MessageDlg('Cannot DELETE the ACTIVE pregnancy.',mtInformation,[mbOK],0) = mrOk then
                Exit
              else Exit;
            end;

            if frmTmpPregHist.FPregIEN <> '' then
              for I := 0 to PregListView.Items.Count - 1 do
                if PregListView.Items.Item[I].Caption = 'L' then
                  if PregListView.Items.Item[I].SubItems[0] = frmTmpPregHist.FPregIEN then
                  begin
                    PregListView.Items.Item[I].SubItems[18] := TSpinEdit(Sender).Hint;

                    if AnsiContainsText(frmTmpPregHist.FPregIEN,'+') then
                    begin
                      PregListView.Items.Item[I].Free;
                      for J := 0 to PregListView.Items.Count - 1 do
                        if PregListView.Items.Item[J].SubItems[0] = frmTmpPregHist.FPregIEN then
                          PregListView.Items.Item[J].Free;
                    end else
                      PregListView.Items.Item[I].SubItems[0] := frmTmpPregHist.FPregIEN + '-';

                    Break;
                  end;

            frmTmpPregHist.Free;
            slPregs.Delete(dlgModTotPregs.deletepage - 1);
            pgcPregnancy.Pages[dlgModTotPregs.deletepage - 1].Free;
          end;
        end;
      finally
        dlgModTotPregs.Free;
      end;
    end else
    begin
      for I := pgcPregnancy.PageCount to iTmpTotPreg - 1 do
      begin
        inc(rPreg);
        AddPage(Sender, IntToStr(rPreg) + '+');
      end;
    end;
  finally
    spnTotPreg := edtTotPreg.Value;
    spnAbInduced := edtAbInduced.Value;
    spnAbSpont := edtAbSpont.Value;
    spnEctopic := edtEctopic.Value;

    for I := 0 to pgcPregnancy.PageCount - 1 do
      pgcPregnancy.Pages[I].Caption := 'Pregnancy #' + IntToStr(I+1);

    iCalcBirths := 0;
    iMultBirths := 0;
    for I := 0 to slPregs.Count - 1 do
    begin
      iCalcBirths := iCalcBirths + TfrmPregHist(slPregs.Objects[I]).GetLiveBirths;
      if TfrmPregHist(slPregs.Objects[I]).cxRadioGroupBirthType.ItemIndex = 1 then
        Inc(iMultBirths);
    end;

    SetLiveBirthCount(iCalcBirths);
    ModifyBirthTypes;

    edtTotPreg.OnChange   := edtTotPregChange;
    edtAbInduced.OnChange := edtTotPregChange;
    edtAbSpont.OnChange   := edtTotPregChange;
    edtEctopic.OnChange   := edtTotPregChange;
  end;
end;

end.
