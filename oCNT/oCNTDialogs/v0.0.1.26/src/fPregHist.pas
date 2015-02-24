unit fPregHist;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExMask, JvSpin, StdCtrls, ExtCtrls, ComCtrls, Buttons, fChildHist,
  Mask, oCNTBase, uExtndComBroker;

type
  TfrmPregHist = class(ToCNTDialog)
    Panel_Pregnancy: TPanel;
    L_DateMonthYearOfDelivery: TLabel;
    L_GestationalAgeAtDelivery: TLabel;
    L_LengthofLabor: TLabel;
    L_TypeofDelivery: TLabel;
    SpeedButton11: TSpeedButton;
    Label287: TLabel;
    edtDateOfDelivery: TEdit;
    E_GestationalAgeAtDelivery: TEdit;
    E_LengthofLabor: TEdit;
    E_TypeofDelivery: TComboBox;
    Panel41: TPanel;
    Panel42: TPanel;
    LE_CommentComplication: TLabeledEdit;
    Panel43: TPanel;
    Label290: TLabel;
    Bevel12: TBevel;
    pgcChildNumber: TPageControl;
    tsht1: TTabSheet;
    cxRadioGroupBirthType: TRadioGroup;
    cxRadioGroup_Anesthesia: TRadioGroup;
    cxGroupBox_PlaceofDelivery: TGroupBox;
    CB_PlaceofDelivery: TComboBox;
    cxRadioGroup_PretermLabor: TRadioGroup;
    JvSpinEdit1: TJvSpinEdit;
    Label289: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxRadioGroupBirthTypeClick(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure pgcChildNumberChange(Sender: TObject);
    procedure cxRadioGroup_PretermLaborClick(Sender: TObject);
  private
    { Private declarations }
    slChildHist: TStringList;
  public
    { Public declarations }
    bNotViewed: boolean;
    procedure GetText(slText: TStringList);
    function AllChildrenNotViewed(var Missed: string): Boolean;
    function GetLiveBirths: Integer;
    function GetChildForm(pg: Integer): TComponent;
  end;

var
  frmPregHist: TfrmPregHist;

implementation

uses
  Math, udlgDATE, udlgPregHist;

{$R *.dfm}

function TfrmPregHist.GetChildForm(pg: Integer): TComponent;
var
  I: Integer;
begin
  Result := nil;
  if pg < 0 then Exit;
  if pg > pgcChildNumber.PageCount - 1 then
  JvSpinEdit1Change(Self);

  if pgcChildNumber.Pages[pg] = nil then Exit;

  for I := 0 to pgcChildNumber.Pages[pg].ControlCount - 1 do
  begin
    if pgcChildNumber.Pages[pg].Controls[I].ClassName = 'TfrmChildHist' then
    Result := pgcChildNumber.Pages[pg].Controls[I];
  end;
end;

procedure TfrmPregHist.cxRadioGroupBirthTypeClick(Sender: TObject);
begin
  if (cxRadioGroupBirthType.ItemIndex = 0) then
  begin
    JvSpinEdit1.Value := 1;
    JvSpinEdit1.Visible := false;
    Label289.Visible := false;
    TdlgPregHist(Owner).DecPregCount;
  end
  else
  begin
    JvSpinEdit1.Value := 2;
    JvSpinEdit1.Visible := true;;
    Label289.Visible := true;
    TdlgPregHist(Owner).IncPregCount;
  end;
  JvSpinEdit1Change(Sender);
end;

procedure TfrmPregHist.cxRadioGroup_PretermLaborClick(Sender: TObject);
begin
  TdlgPregHist(Owner).ModifyBirthTypes;
end;

procedure TfrmPregHist.FormCreate(Sender: TObject);
var
  frmTmpChildHist: TfrmChildHist;
begin
  slChildHist := TStringList.Create;
  slChildHist.Sorted := true;
//  frmTmpChildHist := TfrmChildHist.CreateParented(tsht1.Handle);
  frmTmpChildHist := TfrmChildHist.Create(tsht1, @RPCBrokerV, False, '');
  frmTmpChildHist.Parent := tsht1;
  InsertComponent(frmTmpChildHist);
  frmTmpChildHist.Left := 0;
  frmTmpChildHist.Top := 0;
  frmTmpChildHist.BorderStyle := bsNone;
  frmTmpChildHist.Position := poDefault;
  frmTmpChildHist.FormStyle := fsNormal;
  frmTmpChildHist.Align := alClient;
  frmTmpChildHist.Visible := true;
  slChildHist.AddObject('1',frmTmpChildHist);
  JvSpinEdit1.Visible := false;
  Label289.Visible := false;
  bNotViewed := true;
end;

procedure TfrmPregHist.FormDestroy(Sender: TObject);
var
  frmTmpChildHist: TfrmChildHist;
begin
  while slChildHist.Count > 0 do
  begin
    frmTmpChildHist := TfrmChildHist(slChildHist.Objects[0]);
    frmTmpChildHist.Free;
    slChildHist.Delete(0);
  end;
  slChildHist.Free;
end;

procedure TfrmPregHist.JvSpinEdit1Change(Sender: TObject);
var
  frmTmpChildHist: TfrmChildHist;
  tabControl: TTabSheet;
  cntr: integer;
  iSize: integer;
  iNumBirthChange: integer;
  iCurLiveBirths: integer;
  iNewLiveBirths: integer;
begin
  if (cxRadioGroupBirthType.ItemIndex = 1) and (JvSpinEdit1.Value = 1) then
  cxRadioGroupBirthType.ItemIndex := 0;

  iCurLiveBirths := 0;
  for cntr := 0 to slChildHist.Count - 1 do
  if not(TfrmChildHist(slChildHist.Objects[cntr]).cntcbxStillBorn.Checked) then
  inc(iCurLiveBirths);

  iSize := Floor(JvSpinEdit1.Value);
  if  iSize > slChildHist.Count then
  begin
    for cntr := slChildHist.Count to iSize -1 do
    begin
      tabControl := TTabSheet.Create(nil);
      tabControl.PageControl := pgcChildNumber;
      tabControl := pgcChildNumber.Pages[cntr];
      tabControl.Name := 'tsht' + IntToStr(cntr+1);
      tabControl.Caption := IntToStr(cntr+1);
//      frmTmpChildHist := TfrmChildHist.CreateParented(tabControl.Handle);
      frmTmpChildHist := TfrmChildHist.Create(tabControl, @RPCBrokerV, False, '');
      frmTmpChildHist.Parent := tabControl;
      InsertComponent(frmTmpChildHist);
      frmTmpChildHist.Left := 0;
      frmTmpChildHist.Top := 0;
      frmTmpChildHist.BorderStyle := bsNone;
      frmTmpChildHist.Position := poDefault;
      frmTmpChildHist.FormStyle := fsNormal;
      frmTmpChildHist.Align := alClient;
      frmTmpChildHist.Visible := true;
      slChildHist.AddObject(IntToStr(cntr+1),frmTmpChildHist);
    end;
  end
  else
  begin
    for cntr := slChildHist.Count-1 downto iSize do
    begin
      frmTmpChildHist := TfrmChildHist(slChildHist.Objects[cntr]);
      frmTmpChildHist.Free;
      slChildHist.Delete(cntr);
      pgcChildNumber.Pages[cntr].Free;
    end;
  end;
  iNewLiveBirths := 0;
  for cntr := 0 to slChildHist.Count - 1 do
  if not(TfrmChildHist(slChildHist.Objects[cntr]).cntcbxStillBorn.Checked) then
  inc(iNewLiveBirths);

  iNumBirthChange := iNewLiveBirths - iCurLiveBirths;
  TdlgPregHist(Owner).ModifyLiveBirthCount(iNumBirthChange);
end;

procedure TfrmPregHist.pgcChildNumberChange(Sender: TObject);
begin
  TfrmChildHist(slChildHist.Objects[pgcChildNumber.ActivePageIndex]).rgbxChildGender.SetFocus;
  TfrmChildHist(slChildHist.Objects[pgcChildNumber.ActivePageIndex]).bNotViewed := False;
end;

procedure TfrmPregHist.SpeedButton11Click(Sender: TObject);
var
  dlgGetDate : TdlgDate;
begin
  try
    dlgGetDate := TdlgDate.Create( Nil );
    dlgGetDate.ShowModal;
    if dlgGetDate.ModalResult = mrOK then
    begin    // choices by tag
      if(dlgGetDate.calMonth.Date) >  Now then
      showmessage('No future dates')
      else
      edtDateOfDelivery.Text := DateToStr(dlgGetDate.calMonth.Date);
    end;
  finally
    dlgGetDate.Free;
  end;
end;

procedure TfrmPregHist.GetText(slText: TStringList);
var
  cntr: Integer;
  slTemp: TStringList;
begin
  slTemp := TStringList.Create;
  if trim(edtDateOfDelivery.Text) <> '' then
  slText.Add('  ' + L_DateMonthYearOfDelivery.Caption + ' ' +
             Trim(edtDateOfDelivery.Text));
  if trim(E_GestationalAgeAtDelivery.Text) <> '' then
  slText.Add('  ' + L_GestationalAgeAtDelivery.Caption + ' ' +
             Trim(E_GestationalAgeAtDelivery.Text));
  if trim(E_LengthofLabor.Text) <> '' then
  slText.Add('  ' + L_LengthofLabor.Caption + ' ' + Trim(E_LengthofLabor.Text));
  if trim(E_TypeofDelivery.Text) <> '' then
  slText.Add('  ' + L_TypeofDelivery.Caption + ' ' + Trim(E_TypeofDelivery.Text));

  if (cxRadioGroupBirthType.ItemIndex = 0) then
  begin  {Single}
    slText.Add('  Birth Type: Single');
    TfrmChildHist(slChildHist.Objects[0]).GetText(slTemp);
    slText.AddStrings(slTemp);
  end
  else
  begin
    slText.Add('  Birth Type: Multiple');
    slText.Add('  Number of Births: ' + JvSpinEdit1.Text);
    for cntr := 0 to slChildHist.Count - 1 do
    begin
      slTemp.Clear;
      slText.Add('   Child ' + IntToStr(cntr+1));
      TfrmChildHist(slChildHist.Objects[cntr]).GetText(slTemp);
      slText.AddStrings(slTemp);
    end;
  end;
  if (cxRadioGroup_Anesthesia.ItemIndex = 0) then
  slText.Add('  Epidural/Spinal: Yes')
  else if (cxRadioGroup_Anesthesia.ItemIndex = 1) then
  slText.Add('  Epidural/Spinal: No');
  if (Trim(CB_PlaceofDelivery.Text) <> '') then
  slText.Add('  ' + cxGroupBox_PlaceofDelivery.Caption + ': ' +
             Trim(CB_PlaceofDelivery.Text));
  if (cxRadioGroup_PretermLabor.ItemIndex = 0) then
  slText.Add('  Preterm Labor: Yes')
  else if (cxRadioGroup_PretermLabor.ItemIndex = 1) then
  slText.Add('  Preterm Labor: No');
  if (Trim(LE_CommentComplication.Text) <> '') then
  slText.Add('  Comments/Complications: ' + Trim(LE_CommentComplication.Text));

  slTemp.Free;
end;

function TfrmPregHist.AllChildrenNotViewed(var Missed: string): boolean;
var
  cntr: integer;
begin
  Result := false;
  Missed := '';
  for cntr := 1 to slChildHist.Count - 1 do
  begin
    if TfrmChildHist(slChildHist.Objects[cntr]).bNotViewed then
    begin
      Result := True;
      if Missed <> '' then
      Missed := Missed + ', ' + IntToStr(cntr+1)
      else
      Missed := IntToStr(cntr+1);
    end;
  end;
  Missed := 'You have not visited the tabs for the following children: ' + Missed + '.' + #10#13 +
            'Would  you like to continue?';
end;

function TfrmPregHist.GetLiveBirths(): integer;
var
  ptr: integer;
begin
  Result := 0;
  for ptr := 0 to slChildHist.Count - 1 do
  begin
    if not(TfrmChildHist(slChildHist.Objects[ptr]).cntcbxStillBorn.Checked) then
    Inc(Result);
  end;
end;


end.
