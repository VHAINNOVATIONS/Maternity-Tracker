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
  uDialog, uCommon, uExtndComBroker;

type
  TdlgPregHist = class(ToCNTDialog)
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
    lblMultipleBirths: TLabel;
    lblLiveBirths: TLabel;
    lblFullTerm: TLabel;
    lblPremature: TLabel;
    edtAbInduced: TSpinEdit;
    edtAbSpont: TSpinEdit;
    edtTotPreg: TSpinEdit;
    edtEctopic: TSpinEdit;
    PregListView: TListView;
    procedure FormDestroy(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure edtTotPregChange(Sender: TObject);
    procedure pgcPregnancyChange(Sender: TObject);
    procedure pgcPregnancyChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
  private
    slPregs: TStringList;
    function GetForm(pg: Integer): TControl;
  protected
  public
    procedure IncPregCount;
    procedure DecPregCount;
    procedure SetMultpregs(MultCount: Integer);
    procedure ModifyLiveBirthCount(NmbrChldrn: Integer);
    procedure SetLiveBirthCount(NmbrChldrn: Integer);
    procedure ModifyBirthTypes;
  end;

var
  dlgPregHist: TdlgPregHist;
  MultPregCount,LiveBirths,iFullTerm,iPremature: Integer;
  rPreg: Integer;

implementation

uses
  udlgDATE, fPregHist, fChildHist, udlgModTotPregs;

{$R *.dfm}

procedure TdlgPregHist.IncPregCount;
begin
  Inc(MultPregCount);
  lblMultipleBirths.Caption := IntToStr(MultPregCount);
end;

procedure TdlgPregHist.DecPregCount;
begin
  Dec(MultPregCount);
  lblMultipleBirths.Caption := IntToStr(MultPregCount);
end;

procedure TdlgPregHist.SetMultpregs(MultCount: Integer);
begin
  MultPregCount := MultCount;
  lblMultipleBirths.Caption := IntToStr(MultPregCount);
end;

procedure TdlgPregHist.ModifyLiveBirthCount(NmbrChldrn: Integer);
begin
  LiveBirths := LiveBirths + NmbrChldrn;
  lblLiveBirths.Caption := IntToStr(LiveBirths);
end;

procedure TdlgPregHist.SetLiveBirthCount(NmbrChldrn: Integer);
begin
  LiveBirths := NmbrChldrn;
  lblLiveBirths.Caption := IntToStr(LiveBirths);
end;

procedure TdlgPregHist.ModifyBirthTypes;
var
  ptr: Integer;
  iItemIndex: Integer;
begin
  iFullTerm := 0;
  iPremature := 0;
  
  for ptr := 0 to slPregs.Count - 1 do
  begin
    iItemIndex := TfrmPregHist(slPregs.Objects[ptr]).cxRadioGroup_PretermLabor.ItemIndex;
    if iItemIndex = 0 then
      Inc(iPremature)
    else if iItemIndex = 1 then
      Inc(iFullTerm);
  end;
  
  lblFullTerm.Caption := IntToStr(iFullTerm);
  lblPremature.Caption := IntToStr(iPremature);
end;

function TdlgPregHist.GetForm(pg: Integer): TControl;
var
  I: Integer;
begin
  Result := nil;
  
  if pg < 0 then 
    Exit;

  for I := 0 to pgcPregnancy.Pages[pg].ControlCount - 1 do
  begin
    if pgcPregnancy.Pages[pg].Controls[I] is TfrmPregHist then
    begin
      Result := pgcPregnancy.Pages[pg].Controls[I];
      Break;
    end;
  end;
end;

procedure TdlgPregHist.FormShow(Sender: TObject);
var
  I,J,T: Integer;
  pg: TfrmPregHist;
  pgChild: TfrmChildHist;
  val: string;
  flg: Boolean;
begin
  slPregs := TStringList.Create;

  edtTotPreg.OnChange   := nil;
  edtAbInduced.OnChange := nil;
  edtAbSpont.OnChange   := nil;
  edtEctopic.OnChange   := nil;
  try
    MultPregCount := 0;
    edtTotPreg.Value := 0;
    edtAbInduced.Value := 0;
    edtAbSpont.Value := 0;
    edtEctopic.Value := 0;

    //  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
    //    EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
    //    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE AT DELIVERY^LENGTH OF DELIVERY^
    //    TYPE OF DELIVERY^EPIDERAL/SPINAL^PRETERM LABOR^BIRTH TYPE^IEN;BABY |IEN;BABY^
    //    COMPLICATION
    //  C^IEN^COMMENT

    for I := 0 to PregListView.Items.Count - 1 do
      for J := PregListView.Items.Item[I].SubItems.Count - 1 to 18 do
        PregListView.Items.Item[I].SubItems.Add('');

    for I := 0 to PregListView.Items.Count - 1 do
    begin
      if PregListView.Items.Item[I].Caption = 'L' then
      begin
        if PregListView.Items.Item[I].SubItems[18] = 'E' then
        begin
          edtEctopic.Value := edtEctopic.Value + 1;
          edtTotPreg.Value := edtTotPreg.Value + 1;
        end else if PregListView.Items.Item[I].SubItems[18] = 'AI' then
        begin
            edtAbInduced.Value := edtAbInduced.Value + 1;
            edtTotPreg.Value := edtTotPreg.Value + 1;
        end else if PregListView.Items.Item[I].SubItems[18] = 'AS' then
        begin
            edtAbSpont.Value := edtAbSpont.Value + 1;
            edtTotPreg.Value := edtTotPreg.Value + 1;
        end else
        begin
          edtTotPreg.Value := edtTotPreg.Value + 1;
          rPreg := rPreg + 1;
          edtTotPregChange(Sender);
          edtTotPreg.OnChange   := nil;
          edtAbInduced.OnChange := nil;
          edtAbSpont.OnChange   := nil;
          edtEctopic.OnChange   := nil;

          pg := TfrmPregHist(GetForm(pgcPregnancy.PageCount - 1));
          if pg <> nil then
          begin
            for J := 0 to PregListView.Items.Item[I].SubItems.Count - 1 do
            begin
              val := PregListView.Items.Item[I].SubItems[J];
              if val <> '' then
              case J of
                0 : pg.FPregIEN := val;                                     //IEN
                1 : ;                                                       //DATE RECORDED
                2 : ;                                                       //EDC
                3 : ;                                                       //DFN|PATIENT
                4 : ;                                                       //STATUS
                5 : ;                                                       //FOF|(IEN OR IDENTIFIER)
                6 : ;                                                       //EDD
                7 : pg.edtDateOfDelivery.Text := val;                       //PREGNANCY END
                8 : ;                                                       //OB IEN|OB
                9 : pg.CB_PlaceofDelivery.Text := Piece(val,'|',2);         //FACILITY IEN|FACILITY
               10 : ;                                                       //UPDATED BY IEN|UPDATED BY
               11 : pg.E_GestationalAgeAtDelivery.Text := val;              //GESTATIONAL AGE AT DELIVERY
               12 : pg.E_LengthofLabor.Text := val;                         //LENGTH OF DELIVERY
               13 : begin                                                   //TYPE OF DELIVERY
                      flg := False;
                      for T := 0 to pg.E_TypeofDelivery.Items.Count do
                        if AnsiCompareText(pg.E_TypeofDelivery.Items[T],val) = 0 then
                        begin
                          pg.E_TypeofDelivery.ItemIndex := T;
                          flg := True;
                          Break;
                        end;

                      if not flg then
                      begin
                        pg.E_TypeofDelivery.Items.Add(val);
                        pg.E_TypeofDelivery.ItemIndex := pg.E_TypeofDelivery.Items.Count - 1;
                      end;
                    end;
               14 : begin                                                   //EPIDERAL/SPINAL
                      if val = '1' then
                        pg.cxRadioGroup_Anesthesia.ItemIndex := 1
                      else if val = '0' then
                        pg.cxRadioGroup_Anesthesia.ItemIndex := 0;
                    end;
               15 : begin                                                   //PRETERM LABOR
                      if val = '1' then
                        pg.cxRadioGroup_PretermLabor.ItemIndex := 1
                      else if val = '0' then
                        pg.cxRadioGroup_PretermLabor.ItemIndex := 0;
                    end;
               16 : ;                                                       //BIRTH TYPE
               17 : begin                                                   //IEN;BABY#;SEX;WEIGHT;STILLBORN|
                      for T := 1 to SubCount(val,'|') + 1 do
                      begin
                        if T > 1 then
                        begin
                          pg.cxRadioGroupBirthType.ItemIndex := 1;

                          if T > 2 then
                            pg.JvSpinEdit1.Value := pg.JvSpinEdit1.Value + 1;
                        end;

                        pgChild := TfrmChildHist(pg.GetChildForm(T));
                        if pgChild <> nil then
                        begin
                          if Piece(Piece(val,'|',T),';',1) <> '' then
                            pgChild.FBabyIEN :=  Piece(Piece(val,'|',T),';',1);

                          if Piece(Piece(val,'|',T),';',3) = 'M' then
                            pgChild.rgbxChildGender.ItemIndex := 0
                          else if Piece(Piece(val,'|',T),';',3) = 'F' then
                            pgChild.rgbxChildGender.ItemIndex := 1;

                          pgChild.edtBirthWeight.Text := Piece(Piece(val,'|',T),';',4);

                          if UpperCase(Piece(Piece(val,'|',T),';',5)) = '1' then
                            pgChild.cntcbxStillBorn.Checked := True;
                        end;
                      end;
                    end;
              end;
            end;
          end;
        end;
      end else if PregListView.Items.Item[I].Caption = 'C' then
      begin
        for J := 0 to pgcPregnancy.PageCount - 1 do
        begin
          pg := TfrmPregHist(GetForm(J));
          if ((pg <> nil) and (pg.FPregIEN = PregListView.Items.Item[I].SubItems[0])) then
          begin
            pg.MO_CommentComplication.Lines.Add(PregListView.Items.Item[I].SubItems[1]);
            Break;
          end;
        end;
      end;
    end;
  finally
    edtTotPreg.OnChange   := edtTotPregChange;
    edtAbInduced.OnChange := edtTotPregChange;
    edtAbSpont.OnChange   := edtTotPregChange;
    edtEctopic.OnChange   := edtTotPregChange;
  end;
end;

procedure TdlgPregHist.FormDestroy(Sender: TObject);
begin
  try
    try
      while slPregs.Count > 0 do
      begin
       TfrmPregHist(slPregs.Objects[0]).Free;
       slPregs.Delete(0);
      end;
    except
    end;
  finally
    slPregs.Free;
  end;
end;

procedure TdlgPregHist.pgcPregnancyChange(Sender: TObject);
begin
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

  procedure CleanLv(Lv: TListView);
  var
    I: Integer;
  begin
    for I := 0 to Lv.Items.Count - 1 do
      if ((Lv.Items[I].Caption = 'L') and (Lv.Items[I].SubItems[18] = '')) or (Lv.Items[I].Caption = 'C') then
      begin
        PregListView.Items[I].Delete;
        CleanLv(Lv);
        Break;
      end;
  end;

begin
  vPregValidateStr :='';
  bNotAllPregsViewed := False;

  for I := 1 to slPregs.Count - 1 do
  begin
    if TfrmPregHist(slPregs.Objects[I]).bNotViewed then
    begin
      bNotAllPregsViewed := true;
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
  TmpStrList.Add('  Full Term: ' + lblFullTerm.Caption);
  TmpStrList.Add('  Premature: ' + lblPremature.Caption);
  TmpStrList.Add('  Ab. Induced: ' + edtAbInduced.Text);
  TmpStrList.Add('  Ab. Spontaneous: ' + edtAbSpont.Text);
  TmpStrList.Add('  Ectopics: ' + edtEctopic.Text);
  TmpStrList.Add('  Multiple Births: ' + lblMultipleBirths.Caption);
  TmpStrList.Add('  Living: ' + lblLiveBirths.Caption);

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

  CleanLv(PregListView);

  for I := 0 to pgcPregnancy.PageCount - 1 do
  begin
    pg := TfrmPregHist(GetForm(I));
    if pg <> nil then
    begin
      lvitem := PregListView.Items.Add;
      lvitem.Caption := 'L';
      for J := 0 to 18 do
        lvitem.SubItems.Add('');

      lvitem.SubItems[0] := pg.FPregIEN;

      for J := 0 to pg.ComponentCount - 1 do
      begin
        if pg.Components[J].Name = 'edtDateOfDelivery' then
          lvitem.SubItems[7] := pg.edtDateOfDelivery.Text;                               //PREGNANCY END

        if pg.Components[J].Name = 'pgcChildNumber' then                                 //IEN;BABY#;SEX;WEIGHT;STILLBORN|
        begin
          str := '';
          for K := 0 to pg.pgcChildNumber.PageCount - 1 do
          begin
            pgChild := TfrmChildHist(pg.GetChildForm(K+1));
            
            if str <> '' then 
              str := str + '|';

            str := str + pgChild.FBabyIEN + ';' + IntToStr(K+1) + ';';

            if pgChild.rgbxChildGender.ItemIndex = 0 then 
              str := str + 'M;'
            else if pgChild.rgbxChildGender.ItemIndex = 1 then
              str := str + 'F;';
            
            str := str + pgChild.edtBirthWeight.Text + ';';

            if pgChild.cntcbxStillBorn.Checked then
              str := str + '1';
          end;
          lvitem.SubItems[17] := str;
        end;

        if pg.Components[J].Name = 'E_GestationalAgeAtDelivery' then                     //GESTATIONAL AGE AT DELIVERY
          lvitem.SubItems[11] := pg.E_GestationalAgeAtDelivery.Text;

        if pg.Components[J].Name = 'E_LengthofLabor' then                                //LENGTH OF LABOR
          lvitem.SubItems[12] := pg.E_LengthofLabor.Text;

        if pg.Components[J].Name = 'E_TypeofDelivery' then                               //TYPE OF DELIVERY
          lvitem.SubItems[13] := pg.E_TypeofDelivery.Text;

        if pg.Components[J].Name = 'cxRadioGroup_Anesthesia' then                        //EPIDERAL/SPINAL
        begin
          if pg.cxRadioGroup_Anesthesia.ItemIndex <> -1 then
            lvitem.SubItems[14] := IntToStr(pg.cxRadioGroup_Anesthesia.ItemIndex);
        end;

        if pg.Components[J].Name = 'CB_PlaceofDelivery' then                             //PLACE OF DELIVERY
          lvitem.SubItems[9] := '|' + pg.CB_PlaceofDelivery.Text;

        if pg.Components[J].Name = 'cxRadioGroup_PretermLabor' then                      //PRETERM LABOR
        begin
          if pg.cxRadioGroup_PretermLabor.ItemIndex <> -1 then
            lvitem.SubItems[15] := IntToStr(pg.cxRadioGroup_PretermLabor.ItemIndex);
        end;

        if pg.Components[J].Name = 'MO_CommentComplication' then                         //COMMENTS
        begin
          for K := 0 to pg.MO_CommentComplication.Lines.Count - 1 do
          begin
            lvitemc := PregListView.Items.Add;
            lvitemc.Caption := 'C';
            lvitemc.SubItems.Add(pg.FPregIEN);
            lvitemc.SubItems.Add(pg.MO_CommentComplication.Lines[K]);
          end;
        end;
      end;
    end;
  end;

  ModalResult := mrOK;
end;

procedure TdlgPregHist.edtTotPregChange(Sender: TObject);
var
  I,J,iTmpTotPreg,iTmpAbSpon,iTmpAbInduce,iTmpEctopic: Integer;
  iMultBirths,iCalcBirths: Integer;
  tabControl: TTabSheet;
  frmTmpPregHist: TfrmPregHist;
  dlgModTotPregs: TdlgModTotPregs;
  lvitem: TListItem;
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
    iTmpTotPreg  := StrToIntDef(edtTotPreg.Text,0);
    iTmpAbSpon   := StrToIntDef(edtAbSpont.Text,0);
    iTmpAbInduce := StrToIntDef(edtAbInduced.Text,0);
    iTmpEctopic  := StrToIntDef(edtEctopic.Text,0);

    if (iTmpTotPreg < (iTmpAbSpon + iTmpAbInduce + iTmpEctopic)) then
    begin
      iTmpTotPreg := iTmpAbSpon + iTmpAbInduce + iTmpEctopic;
      edtTotPreg.Text := IntToStr(iTmpTotPreg);
    end;

    if (iTmpTotPreg - iTmpAbSpon - iTmpAbInduce - iTmpEctopic) < slPregs.Count then
    begin
      dlgModTotPregs := TdlgModTotPregs.Create(Self);
      try
        if dlgModTotPregs.ShowModal <> mrOK then
          TSpinEdit(Sender).Value := TSpinEdit(Sender).Value - 1
        else
        begin
          frmTmpPregHist := TfrmPregHist(GetForm(dlgModTotPregs.deletepage - 1));
          if frmTmpPregHist <> nil then
          begin
            if frmTmpPregHist.FPregIEN <> '' then
              for I := 0 to PregListView.Items.Count - 1 do
                if PregListView.Items.Item[I].Caption = 'L' then
                  if PregListView.Items.Item[I].SubItems[0] = frmTmpPregHist.FPregIEN then
                  begin
                    PregListView.Items.Item[I].SubItems[18] := TSpinEdit(Sender).Hint;

                    if TSpinEdit(Sender).Hint = '' then
                    begin
                      if AnsiContainsText(frmTmpPregHist.FPregIEN,'+') then
                      begin
                        PregListView.Items.Item[I].Free;
                        for J := 0 to PregListView.Items.Count - 1 do
                          if PregListView.Items.Item[J].SubItems[0] = frmTmpPregHist.FPregIEN then
                            PregListView.Items.Item[J].Free;
                      end else
                        PregListView.Items.Item[I].SubItems[0] := frmTmpPregHist.FPregIEN + '-';
                        // Setting the Comments to - won't matter at this point as it is intended that
                        // VistA will delete the Pregnancy Log
                    end;

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
      for I := slPregs.Count to (iTmpTotPreg - iTmpAbSpon - iTmpAbInduce - iTmpEctopic) - 1 do
      begin
        tabControl := TTabSheet.Create(nil);
        tabControl.PageControl := pgcPregnancy;
        tabControl := pgcPregnancy.Pages[I];
        tabControl.Name := 'tsht' + IntToStr(I+1);
        tabControl.Caption := 'Pregnancy #' + IntToStr(I+1);
        frmTmpPregHist := TfrmPregHist.Create(tabControl, @RPCBrokerV, False, '');
        frmTmpPregHist.Parent := tabControl;
        InsertComponent(frmTmpPregHist);
        frmTmpPregHist.Left := 0;
        frmTmpPregHist.Top := 0;
        frmTmpPregHist.BorderStyle := bsNone;
        frmTmpPregHist.Position := poDefault;
        frmTmpPregHist.FormStyle := fsNormal;
        frmTmpPregHist.Align := alClient;
        frmTmpPregHist.Visible := True;
        rPreg := rPreg + 1;
        if frmTmpPregHist.FPregIEN = '' then
          frmTmpPregHist.FPregIEN := IntToStr(rPreg) + '+';

        slPregs.AddObject(tabControl.Caption,frmTmpPregHist);

        lvitem := PregListView.Items.Add;
        lvitem.Caption := 'L';
        for J := 0 to 18 do
          lvitem.SubItems.Add('');
        lvitem.SubItems[0] := frmTmpPregHist.FPregIEN;
      end;
    end;

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
    SetMultpregs(iMultBirths);
    ModifyBirthTypes;
  finally
    edtTotPreg.OnChange   := edtTotPregChange;
    edtAbInduced.OnChange := edtTotPregChange;
    edtAbSpont.OnChange   := edtTotPregChange;
    edtEctopic.OnChange   := edtTotPregChange;
  end;
end;

end.
