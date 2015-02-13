unit udlgMaternal;

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
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin, oCNTBase, uExtndComBroker;

type
  TdlgMaternal = class(ToCNTDialog)
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    chkFeedBreast: TCheckBox;
    chkFeedBottle: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCntrOther: TLabeledEdit;
    Label4: TLabel;
    chkSDAsthma: TCheckBox;
    chkSDDiabetes: TCheckBox;
    chkSDHypertension: TCheckBox;
    edtSDOther: TEdit;
    Label6: TLabel;
    edtMCOther: TLabeledEdit;
    chkMCNone: TCheckBox;
    chkMCHemorrhage: TCheckBox;
    chkMCInfection: TCheckBox;
    chkMCHypertension: TCheckBox;
    lblSDOther: TLabel;
    Panel3: TPanel;
    lbltitle: TLabel;
    ckFeedFormula: TCheckBox;
    cbContraceptives: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure chkMCNoneClick(Sender: TObject);
    procedure chkMCHemorrhageClick(Sender: TObject);
  private
    { Private declarations }
    fRecursiveChecking: boolean;
  public
  end;

var
  dlgMaternal: TdlgMaternal;

implementation

{$R *.dfm}

procedure TdlgMaternal.bbtnOKClick(Sender: TObject);
var
  tmpstr: string;
begin
  tmpStrlist.Clear;

  tmpstr:='';
  if chkFeedBreast.Checked then
  tmpStr:= 'Breast Milk';
  if chkFeedBottle.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + 'Bottle';
  end;
  if ckFeedFormula.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + 'Formula';
  end;
  if tmpstr <> '' then
  begin
    tmpstr := '  Feeding Method: ' +tmpstr;
    TmpStrList.Add(tmpstr);
  end;

  tmpstr:='';
  if (Trim(cbContraceptives.Text) <> '') then
  tmpStr := cbContraceptives.Text;
  if (Trim(edtCntrOther.Text) <> '') then
  begin
    TmpStrList.Add('  Contraceptives: ');
    if tmpstr <> '' then
    TmpStrList.Add('   ' + tmpstr);

    TmpStrList.Add('   ' + edtCntrOther.Text);
  end else
  begin
    if tmpstr <> '' then
    begin
      TmpStrList.Add('  Contraceptives: ');
      TmpStrList.Add('   ' + tmpstr);
    end;
  end;

  tmpstr:='';
  if chkSDAsthma.Checked then
  tmpStr:= 'Asthma';
  if chkSDDiabetes.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + 'Diabetes';
  end;
  if chkSDHypertension.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ' ;
    tmpStr := tmpstr + 'Hypertension';
  end;
  if (Trim(edtSDOther.Text) <> '') then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + edtSDOther.Text;
  end;
  if tmpstr <> '' then
  begin
    tmpstr := '  Ongoing Chronic Medical Conditions: ' + tmpstr;
    TmpStrList.Add(tmpstr);
  end;

  tmpstr:='';
  if chkMCNone.Checked then
  tmpStr:= 'None';
  if chkMCHemorrhage.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + 'Hemorrhage';
  end;
  if chkMCInfection.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + 'Infection';
  end;
  if chkMCHypertension.Checked then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + 'Pre-eclampsia';
  end;
  if  (Trim(edtMCOther.Text) <> '') then
  begin
    if tmpstr <> '' then
    tmpstr := tmpstr + ', ';
    tmpStr := tmpstr + edtMCOther.Text;
  end;
  if tmpstr <> '' then
  begin
    tmpstr := '  Maternal Complications: ' + tmpstr;
    TmpStrList.Add(tmpstr);
  end;

  if TmpStrList.Count > 0 then
  Tmpstrlist.Insert(0, 'Maternal Information:');
end;

procedure TdlgMaternal.chkMCHemorrhageClick(Sender: TObject);
begin
  if fRecursiveChecking then
  exit;

  fRecursiveChecking := True;
  if chkMCHemorrhage.Checked or chkMCInfection.Checked or chkMCHypertension.Checked or (Trim(edtMCOther.text) <> '') then
  begin
    chkMCNone.Checked := False;
    chkMCNone.Visible := False;
  end
  else
  chkMCNone.Visible := True;

  fRecursiveChecking := False;
end;

procedure TdlgMaternal.chkMCNoneClick(Sender: TObject);
begin
  if fRecursiveChecking then
  exit;

  fRecursiveChecking := True;
  if chkMCNone.Checked then
  begin
    chkMCHemorrhage.Checked :=False;
    chkMCInfection.Checked := False;
    chkMCHypertension.Checked := False;
    edtMCOther.Text := '';
  end;

  chkMCHemorrhage.Visible := not chkMCNone.Checked;
  chkMCInfection.Visible := not chkMCNone.Checked;
  chkMCHypertension.Visible := not chkMCNone.Checked;
  edtMCOther.Visible := not chkMCNone.Checked;
  fRecursiveChecking := False;
end;

procedure TdlgMaternal.FormCreate(Sender: TObject);
begin
  fRecursiveChecking := False;
end;

end.
