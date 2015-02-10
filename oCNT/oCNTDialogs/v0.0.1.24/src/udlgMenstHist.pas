unit udlgMenstHist;

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
  StdCtrls, ExtCtrls, Vcl.ComCtrls, Buttons, oCNTBase, uExtndComBroker;

type
  TdlgMenstHist = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label1: TLabel;
    ckMensesNo: TCheckBox;
    sbtnGetDate1: TSpeedButton;
    edtFrequency: TLabeledEdit;
    edtLMP: TLabeledEdit;
    Label2: TLabel;
    edtMenarche: TLabeledEdit;
    Label3: TLabel;
    Label4: TLabel;
    ckAmountNo: TCheckBox;
    Label5: TLabel;
    ckContraceptionYes: TCheckBox;
    ckContraceptionNo: TCheckBox;
    edthcg: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    Label8: TLabel;
    ckDurationNo: TCheckBox;
    memLMP: TMemo;
    btnHistory: TButton;
    Label6: TLabel;
    ckAmountYes: TCheckBox;
    ckDurationYes: TCheckBox;
    ckMensesYes: TCheckBox;
    Label7: TLabel;
    edtContraceptionType: TComboBox;
    procedure sbtnGetDate1Click(Sender: TObject);
    procedure ckMensesYesClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLMPChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ToggleCB(cb1: TCheckBox; cb2: TCheckBox);
  public
    function GetTmpStrList: TStringList;
    procedure UpdateLMP(val: string);
  end;

var
  dlgMenstHist: TdlgMenstHist;

implementation

uses
   udlgDATE, udlgEstDelivDate;

{$R *.dfm}

procedure TdlgMenstHist.UpdateLMP(val: string);
begin
  edtLMP.Text := val;
  ckMensesYes.Checked := False;
  ckMensesNo.Checked := False;
  edtFrequency.Text := '';
  ckAmountYes.Checked := False;
  ckAmountNo.Checked := False;
  ckDurationYes.Checked := False;
  ckDurationNo.Checked := False;
  ckContraceptionYes.Checked := False;
  ckContraceptionNo.Checked := False;
  edtContraceptionType.Text := '';
  edthcg.Text := '';
  memLMP.Clear;
end;

function TdlgMenstHist.GetTmpStrList;
var
  CompChecked,I: Integer;

begin
  TmpStrList.Clear;
  Result := TmpStrList;

  CompChecked := 0;
  {check Checkboxes}
  for I := 0 to ComponentCount - 1 do
  if (Components[I] is TCheckBox) then
  if (TCheckBox(Components[I]).Checked = TRUE) then
  Inc(CompChecked); {total checked}

  {check LabelEdit}
  for I := 0 to ComponentCount - 1 do
  if (Components[I] is TLabeledEdit) then
  if (TLabeledEdit(Components[I]).Text <> '') then
  Inc(CompChecked); {total checked}

  if CompChecked > 0 then
  begin
    TmpStrList.Add('MENSTRUAL HISTORY: ');
    if edtLMP.Text  <> '' then TmpStrList.Add('  LMP: ' + edtLMP.Text);
    if ckMensesYes.Checked = True then TmpStrList.Add('  Menses Regular: YES');
    if ckMensesNo.Checked = True then TmpStrList.Add('  Menses Regular: NO');
    if edtFrequency.Text  <> '' then TmpStrList.Add('  Frequency Q: ' + edtFrequency.Text + ' days');
    if edtMenarche.Text  <> '' then TmpStrList.Add('  Menarche: ' + edtMenarche.Text + ' years old');
    if ckAmountYes.Checked = True then TmpStrList.Add('  Normal Amount: YES');
    if ckAmountNo.Checked = True then TmpStrList.Add('  Normal Amount: NO');
    if ckDurationYes.Checked = True then TmpStrList.Add('  Normal Duration: YES');
    if ckDurationNo.Checked = True then TmpStrList.Add('  Normal Duration: NO');
    if ckContraceptionYes.Checked = True then TmpStrList.Add('  On Contraception: YES');
    if ckContraceptionNo.Checked = True then TmpStrList.Add('  On Contraception: NO');
    if edtContraceptionType.Text <> '' then
    TmpStrList.Add('  Contraception using: ' + edtContraceptionType.Text);

    if edthcg.Text  <> '' then TmpStrList.Add('  hCG+: ' + edthcg.Text);

    if memLMP.Lines.Count > 0 then
    begin
      TmpStrList.Add(' Menstrual Narrative:');
      for I := 0 to memLMP.Lines.Count - 1 do
      TmpStrList.Add('  ' + memLMP.Lines[I]);
    end;
  end;
end;

procedure TdlgMenstHist.FormCreate(Sender: TObject);
begin
  // Needed for embedding
  Self.OnGetTmpStrList := GetTmpStrList;
end;

procedure TdlgMenstHist.FormShow(Sender: TObject);
begin
  Width := Width + 1;
  Width := Width - 1;
end;

procedure TdlgMenstHist.bbtnOKClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.AddStrings(GetTmpStrList);
  finally
    sl.Free;
  end;
end;

procedure TdlgMenstHist.sbtnGetDate1Click(Sender: TObject);
var
  dlgGetDate: TdlgDate;

begin
  try
    dlgGetDate := TdlgDate.Create( Nil );
    dlgGetDate.ShowModal;
    if dlgGetDate.ModalResult = mrOK then
    begin    // choices by tag
    if(dlgGetDate.calMonth.Date) >  Now then
      showmessage('No future dates')
    else
      case (Sender as TSpeedButton).Tag of
        1 : edtLMP.Text := FormatDateTime('MM/dd/yyyy', dlgGetDate.calMonth.Date);
        2 : edthcg.Text := FormatDateTime('MM/dd/yyyy', dlgGetDate.calMonth.Date);
      end;
    end;
  finally
    dlgGetDate.Free;
  end;
end;

Procedure TdlgMenstHist.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
  cb2.Checked := False;
end;

procedure TdlgMenstHist.ckMensesYesClick(Sender: TObject);
{toggle check boxes }
begin
  if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = True) then
  case (Sender as TCheckBox).Tag of
    1: ToggleCB(ckMensesYes,ckMensesNo);
    2: ToggleCB(ckMensesNo,ckMensesYes);
    3: ToggleCB(ckAmountYes,ckAmountNo);
    4: ToggleCB(ckAmountNo,ckAmountYes);
    5: ToggleCB(ckContraceptionYes,ckContraceptionNo);
    6: ToggleCB(ckContraceptionNo,ckContraceptionYes);
    7: ToggleCB(ckDurationYes,ckDurationNo);
    8: ToggleCB(ckDurationNo,ckDurationYes);
  end;
end;

procedure TdlgMenstHist.edtLMPChange(Sender: TObject);
var
  I,J: Integer;
  testDT: TDateTime;
begin
  if not TryStrToDate(edtLMP.Text,testDT) then
  begin
    edtLMP.Text := '';
    Exit;
  end;

  if Parent.ClassName = 'TTabSheet' then
  begin
    for I := 0 to TTabSheet(Parent).PageControl.PageCount - 1 do
    begin
      for J := 0 to TTabSheet(Parent).PageControl.Pages[I].ControlCount - 1 do
      if TTabSheet(Parent).PageControl.Pages[I].Controls[J].ClassName = 'TdlgEstDelivDate' then
      if TdlgEstDelivDate(TTabSheet(Parent).PageControl.Pages[I].Controls[J]).dtLMP.Date <> StrToDate(edtLMP.Text) then
      begin
        TdlgEstDelivDate(TTabSheet(Parent).PageControl.Pages[I].Controls[J]).dtLMP.Date := StrToDate(edtLMP.Text);
        TdlgEstDelivDate(TTabSheet(Parent).PageControl.Pages[I].Controls[J]).UpdateLMP;
      end;
    end;
  end;
end;

end.
