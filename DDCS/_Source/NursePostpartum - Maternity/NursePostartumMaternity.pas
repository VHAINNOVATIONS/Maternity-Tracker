unit NursePostartumMaternity;

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
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, oCNTBase, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ofrm1: ToForm;
    oPage1: ToPage;
    CK_BREAST_MILK: TCheckBox;
    CB_CONTRACEPTIVE_METHOD: TComboBox;
    CK_FORMULA: TCheckBox;
    CK_PRE_ECLAMPSIA: TCheckBox;
    CK_INFECTION: TCheckBox;
    CK_POSTPARTUM_HEMORRHAGE: TCheckBox;
    CK_NONE: TCheckBox;
    ED_MATERNAL_OTHER: TLabeledEdit;
    ED_ONGOING_OTHER: TLabeledEdit;
    CK_HYPERTENSION: TCheckBox;
    CK_DIABETES: TCheckBox;
    CK_ASTHMA: TCheckBox;
    ED_CONTRACEPTIVE_OTHER: TLabeledEdit;
    CK_BOTTLE: TCheckBox;
    MO_NARRATIVE: TMemo;
    LB_FEEDING_METHOD: TLabel;
    LB_ONGOING_CHRONIC_MEDICAL_CONDITIONS: TLabel;
    LB_MATERNAL_COMPLICATIONS: TLabel;
    LB_CONTRACEPTIVE_METHOD: TLabel;
    LB_COMMENTS: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CK_POSTPARTUM_HEMORRHAGEClick(Sender: TObject);
    procedure CK_NONEClick(Sender: TObject);
  private
    fRecursiveChecking: boolean;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  fRecursiveChecking := False;
end;

procedure TForm1.CK_POSTPARTUM_HEMORRHAGEClick(Sender: TObject);
begin
  if fRecursiveChecking then
    Exit;

  fRecursiveChecking := True;
  if CK_POSTPARTUM_HEMORRHAGE.Checked or CK_INFECTION.Checked or
    CK_HYPERTENSION.Checked or (Trim(ED_MATERNAL_OTHER.text) <> '') then
  begin
    CK_NONE.Checked := False;
    CK_NONE.Visible := False;
  end else
    CK_NONE.Visible := True;

  fRecursiveChecking := False;
end;

procedure TForm1.CK_NONEClick(Sender: TObject);
begin
  if fRecursiveChecking then
    Exit;

  fRecursiveChecking := True;
  if CK_NONE.Checked then
  begin
    CK_POSTPARTUM_HEMORRHAGE.Checked := False;
    CK_PRE_ECLAMPSIA.Checked := False;
    CK_INFECTION.Checked := False;
    ED_MATERNAL_OTHER.Text := '';
  end;

  CK_POSTPARTUM_HEMORRHAGE.Visible := not CK_NONE.Checked;
  CK_PRE_ECLAMPSIA.Visible := not CK_NONE.Checked;
  CK_INFECTION.Visible := not CK_NONE.Checked;
  ED_MATERNAL_OTHER.Visible := not CK_NONE.Checked;
  fRecursiveChecking := False;
end;

end.
