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
  Mask, uDialog, uExtndComBroker;

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
    MO_CommentComplication: TMemo;
    Comments: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxRadioGroupBirthTypeClick(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure pgcChildNumberChange(Sender: TObject);
    procedure cxRadioGroup_PretermLaborClick(Sender: TObject);
  private
    slChildHist: TStringList;
  public
    FPregIEN: string;
    bNotViewed: Boolean;
    function GetChildForm(b: Integer): TControl;
    function AllChildrenNotViewed(var Missed: string): Boolean;
    function GetLiveBirths: Integer;
    procedure GetText(slText: TStringList);
  end;

var
  frmPregHist: TfrmPregHist;

implementation

uses
  Math, udlgDATE, udlgPregHist;

{$R *.dfm}

function TfrmPregHist.GetChildForm(b: Integer): TControl;
var
  I: Integer;
begin
  Result := nil;

  if (b-1) < 0 then
    Exit;

  if (b-1) <= pgcChildNumber.PageCount - 1 then
  begin
    for I := 0 to pgcChildNumber.Pages[b-1].ControlCount - 1 do
    begin
      if pgcChildNumber.Pages[b-1].Controls[I] is TfrmChildHist then
      begin
        Result := pgcChildNumber.Pages[b-1].Controls[I];
        Break;
      end;
    end;
  end;
end;

function TfrmPregHist.AllChildrenNotViewed(var Missed: string): boolean;
var
  cntr: Integer;
begin
  Result := False;

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

procedure TfrmPregHist.cxRadioGroupBirthTypeClick(Sender: TObject);
begin
  if (cxRadioGroupBirthType.ItemIndex = 0) then
  begin
    JvSpinEdit1.Value := 2;
    JvSpinEdit1.Visible := False;
    Label289.Visible := False;
    TdlgPregHist(Owner).DecPregCount;
  end else
  begin
    JvSpinEdit1.Value := 2;
    JvSpinEdit1.Visible := True;;
    Label289.Visible := True;
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

  frmTmpChildHist := TfrmChildHist.Create(tsht1, @RPCBrokerV, False, '');
  frmTmpChildHist.Parent := tsht1;
  InsertComponent(frmTmpChildHist);
  frmTmpChildHist.Left := 0;
  frmTmpChildHist.Top := 0;
  frmTmpChildHist.BorderStyle := bsNone;
  frmTmpChildHist.Position := poDefault;
  frmTmpChildHist.FormStyle := fsNormal;
  frmTmpChildHist.Align := alClient;
  frmTmpChildHist.Visible := True;
  if frmTmpChildHist.FBabyIEN = '' then
    frmTmpChildHist.FBabyIEN := IntToStr(pgcChildNumber.PageCount) + '+';
  slChildHist.AddObject('1',frmTmpChildHist);

  JvSpinEdit1.Visible := False;
  Label289.Visible := False;
  bNotViewed := True;
end;

procedure TfrmPregHist.FormDestroy(Sender: TObject);
var
  frmTmpChildHist: TfrmChildHist;
begin
  try
    try
      while slChildHist.Count > 0 do
      begin
        frmTmpChildHist := TfrmChildHist(slChildHist.Objects[0]);
        frmTmpChildHist.Free;
        slChildHist.Delete(0);
      end;
    except
    end;
  finally
    slChildHist.Free;
  end;
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
  iCurLiveBirths := 0;
  for cntr := 0 to slChildHist.Count - 1 do
    if not(TfrmChildHist(slChildHist.Objects[cntr]).cntcbxStillBorn.Checked) then
      inc(iCurLiveBirths);

  if cxRadioGroupBirthType.ItemIndex = 0 then
    iSize := 1
  else
    iSize := Floor(JvSpinEdit1.Value);

  if  iSize > slChildHist.Count then
  begin
    for cntr := slChildHist.Count to iSize - 1 do
    begin
      tabControl := TTabSheet.Create(nil);
      tabControl.PageControl := pgcChildNumber;
      tabControl := pgcChildNumber.Pages[cntr];
      tabControl.Name := 'tsht' + IntToStr(cntr+1);
      tabControl.Caption := IntToStr(cntr+1);
      frmTmpChildHist := TfrmChildHist.Create(tabControl, @RPCBrokerV, False, '');
      frmTmpChildHist.Parent := tabControl;
      InsertComponent(frmTmpChildHist);
      frmTmpChildHist.Left := 0;
      frmTmpChildHist.Top := 0;
      frmTmpChildHist.BorderStyle := bsNone;
      frmTmpChildHist.Position := poDefault;
      frmTmpChildHist.FormStyle := fsNormal;
      frmTmpChildHist.Align := alClient;
      frmTmpChildHist.Visible := True;
      if frmTmpChildHist.FBabyIEN = '' then
        frmTmpChildHist.FBabyIEN := IntToStr(pgcChildNumber.PageCount) + '+';
      slChildHist.AddObject(IntToStr(cntr+1),frmTmpChildHist);
    end;
  end else if iSize < slChildHist.Count then
  begin
    for cntr := slChildHist.Count - 1 downto iSize do
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
    dlgGetDate := TdlgDate.Create(nil);
    dlgGetDate.ShowModal;
    if dlgGetDate.ModalResult = mrOK then
    begin
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
  I: Integer;
begin
  slTemp := TStringList.Create;
  try
    if Trim(edtDateOfDelivery.Text) <> '' then
      slText.Add('  ' + L_DateMonthYearOfDelivery.Caption + ' ' + Trim(edtDateOfDelivery.Text));

    if Trim(E_GestationalAgeAtDelivery.Text) <> '' then
      slText.Add('  ' + L_GestationalAgeAtDelivery.Caption + ' ' + Trim(E_GestationalAgeAtDelivery.Text));

    if Trim(E_LengthofLabor.Text) <> '' then
      slText.Add('  ' + L_LengthofLabor.Caption + ' ' + Trim(E_LengthofLabor.Text));

    if Trim(E_TypeofDelivery.Text) <> '' then
      slText.Add('  ' + L_TypeofDelivery.Caption + ' ' + Trim(E_TypeofDelivery.Text));

    if cxRadioGroupBirthType.ItemIndex = 0 then
    begin
      slText.Add('  Birth Type: Single');
      TfrmChildHist(slChildHist.Objects[0]).GetText(slTemp);
      slText.AddStrings(slTemp);
    end else
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

    if cxRadioGroup_Anesthesia.ItemIndex = 0 then
      slText.Add('  Epidural/Spinal: No')
    else if cxRadioGroup_Anesthesia.ItemIndex = 1 then
      slText.Add('  Epidural/Spinal: Yes');

    if Trim(CB_PlaceofDelivery.Text) <> '' then
      slText.Add('  ' + cxGroupBox_PlaceofDelivery.Caption + ': ' + Trim(CB_PlaceofDelivery.Text));

    if cxRadioGroup_PretermLabor.ItemIndex = 0 then
      slText.Add('  Preterm Labor: No')
    else if cxRadioGroup_PretermLabor.ItemIndex = 1 then
      slText.Add('  Preterm Labor: Yes');

    if MO_CommentComplication.Lines.Count > 0 then
    begin
      slText.Add('  Comments/Complications:');
      for I := 0 to MO_CommentComplication.Lines.Count - 1 do
        slText.Add('   ' + MO_CommentComplication.Lines[I]);
    end;
  finally
    slTemp.Free;
  end;
end;

end.
