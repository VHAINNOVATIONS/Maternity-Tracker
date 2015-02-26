unit udlgInfectHist;

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
  StdCtrls, ExtCtrls, Buttons, oCNTBase, uExtndComBroker;

type
  TdlgInfectHist = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    CheckBox1: TCheckBox;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private                                        { Private declarations }
    Procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public                                         { Public declarations }
  end;

var
  dlgInfectHist: TdlgInfectHist;

implementation

{$R *.dfm}

procedure TdlgInfectHist.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  CompChecked, I : Integer;
begin
   CompChecked := 0;
  {check Checkboxes}
  for I := 0 to ComponentCount -1 do
    if (Components[I] is TCheckBox) then
      if (TCheckBox(Components[I]).Checked = TRUE) then
         Inc(CompChecked); {total checked}
    if (CompChecked > 0) or (LabeledEdit1.Text <> '') then
      TmpStrList.Add('Infection History: ');

  if CheckBox1.Checked then
  begin
    TmpStrList.Add('  No history of infection');
  end
  else
  begin
    if CheckBox2.Checked = True then TmpStrList.Add('  Live with someone exposed to TB? YES');
    if CheckBox3.Checked = True then TmpStrList.Add('  Live with someone exposed to TB? NO');
    if CheckBox4.Checked = True then TmpStrList.Add('  Patient or Partner has history of Genital Herpes? YES');
    if CheckBox5.Checked = True then TmpStrList.Add('  Patient or Partner has history of Genital Herpes? NO');
    if CheckBox8.Checked = True then TmpStrList.Add('  Rash or Viral Illness since last Menstrual Period? YES');
    if CheckBox9.Checked = True then TmpStrList.Add('  Rash or Viral Illness since last Menstrual Period? NO');
    if CheckBox10.Checked = True then begin
      TmpStrList.Add('  History of STI, Gonorrhea, Chlamydia, HIV, HPV, Syphilis? YES');
      if LabeledEdit2.Text <> '' then TmpStrList.Add('    ' + LabeledEdit2.Text);
    end;
    if CheckBox11.Checked = True then TmpStrList.Add('  History of STI, Gonorrhea, Chlamydia, HIV, HPV, Syphilis? NO');
    if LabeledEdit1.Text  <> '' then  TmpStrList.Add('  ' + LabeledEdit1.Text);
  end;
end;

Procedure TdlgInfectHist.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
    cb2.Checked := False;
end;

procedure TdlgInfectHist.CheckBox2Click(Sender: TObject);
begin
 if (Sender is TCheckBox) then
  case (Sender as TCheckBox).Tag of
    1: ToggleCB(CheckBox2,CheckBox3);
    2: ToggleCB(CheckBox3,CheckBox2);
    3: ToggleCB(CheckBox4,CheckBox5);
    4: ToggleCB(CheckBox5,CheckBox4);
    5: ToggleCB(CheckBox8,CheckBox9);
    6: ToggleCB(CheckBox9,CheckBox8);
    7: ToggleCB(CheckBox10,CheckBox11);
    8: ToggleCB(CheckBox11,CheckBox10);
  end;
end;

procedure TdlgInfectHist.CheckBox1Click(Sender: TObject);
var
  I : Integer;
begin
  if CheckBox1.Checked then
  begin
    Panel3.Visible := FALSE;
    for I := 0 to Panel3.ControlCount - 1 do
      if Panel3.Controls[I] is TCheckbox then TCheckBox(Panel3.Controls[I]).Checked := FALSE;
    LabeledEdit1.Text := '';
  end
  else
  begin
    Panel3.Visible := TRUE;
  end;
end;

end.
