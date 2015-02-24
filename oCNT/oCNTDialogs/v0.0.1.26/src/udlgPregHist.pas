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
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Vcl.Samples.Spin, Mask,
  fChildHist, oCNTBase, uExtndComBroker;

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
    OpenedtsPreg1: boolean;
    OpenedtsPreg2: boolean;
    OpenedtsPreg3: boolean;
    OpenedtsPreg4: boolean;
    OpenedtsPreg5: boolean;
    OpenedtsPreg6: boolean;
    OpenedtsPreg7: boolean;
    OpenedtsPreg8: boolean;
    OpenedtsPreg9: boolean;
    OpenedtsPreg10: boolean;
    slPregs: TStringList;
    function GetForm(pg: Integer): TComponent;
  protected
    Ftextfile: TextFile;
  public
    procedure IncPregCount;
    procedure DecPregCount;
    procedure SetMultpregs(MultCount: integer);
    procedure ModifyLiveBirthCount(NmbrChldrn: integer);
    procedure SetLiveBirthCount(NmbrChldrn: integer);
    procedure ModifyBirthTypes;
  end;

var
  dlgPregHist: TdlgPregHist;
  MultPregCount: integer;
  LiveBirths: integer;
  iFullTerm: integer;
  iPremature: integer;

implementation

uses
  udlgDATE, fPregHist, udlgModTotPregs;

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

procedure TdlgPregHist.SetMultpregs(MultCount: integer);
begin
  MultPregCount := MultCount;
  lblMultipleBirths.Caption := IntToStr(MultPregCount);
end;

procedure TdlgPregHist.ModifyLiveBirthCount(NmbrChldrn: integer);
begin
  LiveBirths := LiveBirths + NmbrChldrn;
  lblLiveBirths.Caption := IntToStr(LiveBirths);
end;

procedure TdlgPregHist.SetLiveBirthCount(NmbrChldrn: integer);
begin
  LiveBirths := NmbrChldrn;
  lblLiveBirths.Caption := IntToStr(LiveBirths);
end;

procedure TdlgPregHist.ModifyBirthTypes;
var
  ptr: integer;
  iItemIndex: integer;
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

procedure TdlgPregHist.FormDestroy(Sender: TObject);
begin
  try
    while slPregs.Count > 0 do
    begin
     TfrmPregHist(slPregs.Objects[0]).Free;
     slPregs.Delete(0);
    end;
    slPregs.Free;
  except
  end;
end;

function TdlgPregHist.GetForm(pg: Integer): TComponent;
var
  I: Integer;
begin
  Result := nil;
  if pg < 0 then Exit;

  for I := 0 to pgcPregnancy.Pages[pg].ControlCount - 1 do
  begin
    if pgcPregnancy.Pages[pg].Controls[I] is TfrmPregHist then
    Result := pgcPregnancy.Pages[pg].Controls[I];
  end;
end;

procedure TdlgPregHist.FormShow(Sender: TObject);
var
  I,J,T,TP,AbI,Abs,E: Integer;
  pg: TfrmPregHist;
  pgChild: TfrmChildHist;  
  val: string;

  function CharCount(str: string; C: Char): Integer;
  var
    I: Integer;
  begin
    Result := 1;
    for I := 0 to Length(str) - 1 do
    begin
      if str[I] = C then
      inc(Result);
    end;
  end;
  
begin
  slPregs := TStringList.Create;
  MultPregCount := 0;

  TP := edtTotPreg.Value;
  edtTotPreg.Value := 0;
  AbI := edtAbInduced.Value;
  edtAbInduced.Value := 0;
  Abs := edtAbSpont.Value;
  edtAbSpont.Value := 0;
  E := edtEctopic.Value;
  edtEctopic.Value := 0;

  //"IEN^STRT^PATIENT^DFN^TYP^FOF^FOF IEN^EDD^END^OBP^OBP IEN^PFAC^PFAC IEN^"
  //"UPDATE BY^UPDATE BY IEN^BABY;IEN;GENDER;WEIGTH;STILLBORN|^"
  //"GESTATIONAL AGE AT DELIVERY^LENGTH OF LABOR^TYPE OF DELIVERY^"
  //"EPIDERAL/SPINAL^PLACE OF DELIVERY^PRETERM LABOR^BIRTH TYPE^COMMENTS"
  for I := 0 to PregListView.Items.Count - 1 do
  begin
    edtTotPreg.Value := edtTotPreg.Value + 1;
    edtTotPregChange(Sender);
    pg := TfrmPregHist(GetForm(pgcPregnancy.PageCount-1));
    if pg <> nil then 
    begin
      for J := 0 to PregListView.Items.Item[I].SubItems.Count - 1 do
      begin
        val := PregListView.Items.Item[I].SubItems[J]; 
        case j of
          0 : ;                                          //START
          1 : ;                                          //PATIENT  
          2 : ;                                          //DFN
          3 : ;                                          //TYP
          4 : ;                                          //FOF
          5 : ;                                          //FOF IEN
          6 : ;                                          //EDD
          7 : pg.edtDateOfDelivery.Text := val;          //END
          8 : ;                                          //OBP
          9 : ;                                          //OBP IEN
         10 : ;                                          //PFAC
         11 : ;                                          //PFAC IEN
         12 : ;                                          //UPDATE BY
         13 : ;                                          //UPDATE BY IEN
         14 : begin                                      //BABY;IEN;GENDER;WEIGTH;STILLBORN|
                for T := 0 to CharCount(val, '|') - 1 do
                begin
                  if T > 0 then
                  begin
                    pg.cxRadioGroupBirthType.ItemIndex := 1;
                    if T > 1 then
                    pg.JvSpinEdit1.Value := pg.JvSpinEdit1.Value + 1;
                  end;
                  pgChild := TfrmChildHist(pg.GetChildForm(T));
                  if pgChild <> nil then
                  begin
                    if Piece(Piece(val, '|', T),';',3) = 'M' then
                    pgChild.rgbxChildGender.ItemIndex := 0
                    else if Piece(Piece(val, '|', T),';',3) = 'F' then
                    pgChild.rgbxChildGender.ItemIndex := 1;
                                                              
                    pgChild.edtBirthWeight.Text := Piece(Piece(val, '|', T),';',4);
                    
                    if UpperCase(Piece(Piece(val, '|', T),';',5)) = 'YES' then
                    pgChild.cntcbxStillBorn.Checked := True;
                  end;
                end;  
              end;
         15 : pg.E_GestationalAgeAtDelivery.Text := val; //GESTATIONAL AGE AT DELIVERY
         16 : pg.E_LengthofLabor.Text := val;            //LENGTH OF LABOR
         17 : pg.E_TypeofDelivery.Text := val;           //TYPE OF DELIVERY
         18 : begin                                      //EPIDERAL/SPINAL
                if Uppercase(val) = 'YES' then
                pg.cxRadioGroup_Anesthesia.ItemIndex := 0
                else if Uppercase(val) = 'NO' then
                pg.cxRadioGroup_Anesthesia.ItemIndex := 1;
              end;
         19 : pg.CB_PlaceofDelivery.Text := val;         //PLACE OF DELIVERY
         20 : begin                                      //PRETERM LABOR
                if Uppercase(val) = 'YES' then
                pg.cxRadioGroup_PretermLabor.ItemIndex := 0
                else if Uppercase(val) = 'NO' then
                pg.cxRadioGroup_PretermLabor.ItemIndex := 1;   
              end;
         21 : ;                                          //BIRTH TYPE
         22 : pg.LE_CommentComplication.Text := val;     //COMMENTS
        end;
      end;
    end;
  end;

  edtTotPreg.Value := edtTotPreg.Value + AbI + Abs + E;
  edtAbInduced.Value := AbI;
  edtAbSpont.Value := Abs;
  edtEctopic.Value := E;
  
  edtTotPreg.OnChange := edtTotPregChange;
  edtAbInduced.OnChange := edtTotPregChange;
  edtAbSpont.OnChange := edtTotPregChange;
  edtEctopic.OnChange := edtTotPregChange;
end;

procedure TdlgPregHist.pgcPregnancyChange(Sender: TObject);
begin
 TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).edtDateOfDelivery.SetFocus;
 TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).bNotViewed := false;
end;

procedure TdlgPregHist.pgcPregnancyChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  Missed: string;
begin
  if TfrmPregHist(slPregs.Objects[pgcPregnancy.ActivePageIndex]).AllChildrenNotViewed(Missed) then
  begin
   if MessageDlg(Missed, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
   AllowChange := false;
  end;
end;

procedure TdlgPregHist.bbtnOKClick(Sender: TObject);
var
  CompChecked,I,J,T,TotPregs,TotMult,cntr: Integer;
  vPregValidateStr,str: string ;
  slTmp: TStringList;
  bNotAllPregsViewed: Boolean;
  pg: TfrmPregHist;
  pgChild: TfrmChildHist;  
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
  begin
    exit;
  end;  

  TmpStrList.Add('Pregnancy History: ');
  if edtTotPreg.Text <> '' then TmpStrList.Add('  ' + Label1.Caption + ': ' + edtTotPreg.Text);
  if iFullTerm <> 0 then TmpStrList.Add('  ' + Label2.Caption + ': ' + lblFullTerm.Caption);
  if iPreMature <> 0 then TmpStrList.Add('  ' + Label3.Caption + ': ' + lblPremature.Caption);
  if edtAbInduced.Text <> '' then TmpStrList.Add('  ' + Label4.Caption + ': ' + edtAbInduced.Text);
  if edtAbSpont.Text <> '' then TmpStrList.Add('  ' + Label5.Caption + ': ' + edtAbSpont.Text);
  if edtEctopic.Text <> '' then TmpStrList.Add('  ' + Label6.Caption + ': ' + edtEctopic.Text);
  if MultPregCount <> 0 then TmpStrList.Add('  ' + Label7.Caption + ': ' + lblMultipleBirths.Caption);
  if LiveBirths <> 0 then TmpStrList.Add('  ' + Label8.Caption + ': ' + lblLiveBirths.Caption);
  slTmp := TStringList.Create;
  for cntr := 0 to slPregs.Count - 1 do
  begin
    TmpStrList.Add(slPregs[cntr]);
    slTmp.Clear;
    TfrmPregHist(slPregs.Objects[cntr]).GetText(slTmp);
    TmpStrList.AddStrings(slTmp);
  end;
  slTmp.Free;

  //Update the DataList Control
  for I := 0 to pgcPregnancy.PageCount - 1 do
  begin
    pg := TfrmPregHist(GetForm(I));
    if pg <> nil then 
    begin
      if PregListView.Items.Item[I] = nil then
      begin
        PregListView.Items.Add;
        for J := 0 to 22 do
        PregListView.Items.Item[I].SubItems.Add('');          
      end;
      
      for J := 0 to pg.ComponentCount - 1 do
      begin  
        if pg.Components[J].Name = 'edtDateOfDelivery' then 
        PregListView.Items.Item[I].SubItems[7] := pg.edtDateOfDelivery.Text;           //END

        if pg.Components[J].Name = 'pgcChildNumber' then                               //BABY;IEN;GENDER;WEIGTH;STILLBORN|
        begin
          PregListView.Items.Item[I].SubItems[14] := ''; str := '';

          for T := 0 to pg.pgcChildNumber.PageCount - 1 do
          begin 
            pgChild := TfrmChildHist(pg.GetChildForm(T)); 
            
            if str <> '' then str := str + '|';

            str := str + IntToStr(T+1) + ';;';

            if pgChild.rgbxChildGender.ItemIndex = 0 then 
            str := str + 'M;'
            else if pgChild.rgbxChildGender.ItemIndex = 1 then
            str := str + 'F;';
            
            str := str + pgChild.edtBirthWeight.Text + ';';

            if pgChild.cntcbxStillBorn.Checked then
            str := str + 'YES';
          end;
          PregListView.Items.Item[I].SubItems[14] := str;
        end;

        if pg.Components[J].Name = 'E_GestationalAgeAtDelivery' then                   //GESTATIONAL AGE AT DELIVERY
        PregListView.Items.Item[I].SubItems[15] := pg.E_GestationalAgeAtDelivery.Text; 

        if pg.Components[J].Name = 'E_LengthofLabor' then                              //LENGTH OF LABOR
        PregListView.Items.Item[I].SubItems[16] := pg.E_LengthofLabor.Text;             
        
        if pg.Components[J].Name = 'E_TypeofDelivery' then                             //TYPE OF DELIVERY
        PregListView.Items.Item[I].SubItems[17] := pg.E_TypeofDelivery.Text;           

        if pg.Components[J].Name = 'cxRadioGroup_Anesthesia' then                      //EPIDERAL/SPINAL
        begin
          if pg.cxRadioGroup_Anesthesia.ItemIndex = 0 then
          PregListView.Items.Item[I].SubItems[18] :=  'YES'
          else if pg.cxRadioGroup_Anesthesia.ItemIndex = 1 then
          PregListView.Items.Item[I].SubItems[18] :=  'NO'
        end;

        if pg.Components[J].Name = 'CB_PlaceofDelivery' then                           //PLACE OF DELIVERY
        PregListView.Items.Item[I].SubItems[19] := pg.CB_PlaceofDelivery.Text;   
        
        if pg.Components[J].Name = 'cxRadioGroup_PretermLabor' then                    //PRETERM LABOR
        begin
          if pg.cxRadioGroup_PretermLabor.ItemIndex = 0 then
          PregListView.Items.Item[I].SubItems[20] :=  'YES'
          else if pg.cxRadioGroup_PretermLabor.ItemIndex = 1 then
          PregListView.Items.Item[I].SubItems[20] :=  'NO'
        end;

        if pg.Components[J].Name = 'LE_CommentComplication' then                       //COMMENTS
        PregListView.Items.Item[I].SubItems[22] := pg.LE_CommentComplication.Text;   
      end;
    end;
  end;

  ModalResult := mrOK;
end;

procedure TdlgPregHist.edtTotPregChange(Sender: TObject);
var
  I: Integer;
  iTmpTotPreg: integer;
  iTmpAbSpon: integer;
  iTmpAbInduce: integer;
  iTmpEctopic: integer;
  iMultBirths: integer;
  tabControl: TTabSheet;
  cntr: integer;
  frmTmpPregHist: TfrmPregHist;
  iCalcBirths: integer;
  iPotDelWData: integer;
  dlgModTotPregs: TdlgModTotPregs;
begin
  if TSpinEdit(Sender).Value < 0 then
  TSpinEdit(Sender).Value := 0;

  iTmpTotPreg := StrToIntDef(edtTotPreg.Text,0);
  iTmpAbSpon := StrToIntDef(edtAbSpont.Text,0);
  iTmpAbInduce := StrToIntDef(edtAbInduced.Text,0);
  iTmpEctopic := StrToIntDef(edtEctopic.Text,0);

  if (iTmpTotPreg < (iTmpAbSpon + iTmpAbInduce + iTmpEctopic)) then
  begin
   iTmpTotPreg := iTmpAbSpon + iTmpAbInduce + iTmpEctopic;
   edtTotPreg.Text := IntToStr(iTmpTotPreg);
  end;

  I := iTmpTotPreg - iTmpAbSpon - iTmpAbInduce - iTmpEctopic;
  if I < slPregs.Count then
  begin
    iPotDelWData := 0;
    for cntr := I to slPregs.Count - 1 do
    begin
      if not(TfrmPregHist(slPregs.Objects[cntr]).bNotViewed) then
      iPotDelWData := cntr + 1;
    end;
    if iPotDelWData <> 0 then
    begin
      dlgModTotPregs := TdlgModTotPregs.Create(nil);
      if dlgModTotPregs.ShowModal <> mrOK then
      begin
       iTmpTotPreg := iPotDelWData + iTmpAbSpon + iTmpAbInduce + iTmpEctopic;
       edtTotPreg.Text := IntToStr(iTmpTotPreg);
       I := iPotDelWData;
      end;
      dlgModTotPregs.Free;
    end;
  end;

  if  I > slPregs.Count then
  begin
    for cntr := slPregs.Count to I - 1 do
    begin
      tabControl := TTabSheet.Create(nil);
      tabControl.PageControl := pgcPregnancy;
      tabControl := pgcPregnancy.Pages[cntr];
      tabControl.Name := 'tsht' + IntToStr(cntr+1);
      tabControl.Caption := 'Pregnancy #' + IntToStr(cntr+1);
//      frmTmpPregHist := TfrmPregHist.CreateParented(tabControl.Handle);
      frmTmpPregHist := TfrmPregHist.Create(tabControl, @RPCBrokerV, False, '');
      frmTmpPregHist.Parent := tabControl;
      InsertComponent(frmTmpPregHist);
      frmTmpPregHist.Left := 0;
      frmTmpPregHist.Top := 0;
      frmTmpPregHist.BorderStyle := bsNone;
      frmTmpPregHist.Position := poDefault;
      frmTmpPregHist.FormStyle := fsNormal;
      frmTmpPregHist.Align := alClient;
      frmTmpPregHist.Visible := true;
      slPregs.AddObject(tabControl.Caption,frmTmpPregHist);
    end;
  end
  else
  begin
    for cntr := slPregs.Count - 1 downto I do
    begin
      frmTmpPregHist := TfrmPregHist(slPregs.Objects[cntr]);
      frmTmpPregHist.Free;
      slPregs.Delete(cntr);
      pgcPregnancy.Pages[cntr].Free;
    end;
  end;
  iCalcBirths := 0;
  iMultBirths := 0;
  for cntr := 0 to slPregs.Count - 1 do
  begin
    iCalcBirths := iCalcBirths + TfrmPregHist(slPregs.Objects[cntr]).GetLiveBirths;
    if (TfrmPregHist(slPregs.Objects[cntr]).cxRadioGroupBirthType.ItemIndex = 1) then
    Inc(iMultBirths);
  end;
  SetLiveBirthCount(iCalcBirths);
  SetMultpregs(iMultBirths);
  ModifyBirthTypes;
end;

end.
