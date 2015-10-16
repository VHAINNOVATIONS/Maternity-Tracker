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
  StdCtrls, ExtCtrls, Buttons, uDialog, uExtndComBroker;

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
    LabeledEdit2: TLabeledEdit;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    memNarrative: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Label8: TLabel;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    Label9: TLabel;
    Label10: TLabel;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    Procedure ToggleCB(cb1,cb2,cb3: TCheckBox);
  public
  end;

var
  dlgInfectHist: TdlgInfectHist;

implementation

{$R *.dfm}

procedure TdlgInfectHist.bbtnOKClick(Sender: TObject);
var
  CompChecked,I: Integer;

  function Response(ck1,ck2,ck3: TCheckBox): string;
  begin
    if ck1.Checked then
      Result := 'Yes'
    else if ck2.Checked then
      Result := 'No'
    else if ck3.Checked then
      Result := 'Not Known'
    else Result := '';
  end;

begin
  CompChecked := 0;

  for I := 0 to ComponentCount -1 do
    if (Components[I] is TCheckBox) then
      if (TCheckBox(Components[I]).Checked) then
        Inc(CompChecked);

  if not (CompChecked > 0) and (not memNarrative.Lines.Count > 0) then
  begin
    ShowMessage('Form must have entries checked or Comments to complete.');
    Exit;
  end;

  TmpStrList.Add('Infection History: ');

  if CheckBox1.Checked then
    TmpStrList.Add('  No history of infection.')
  else begin
    TmpStrList.Add('  Live with someone exposed to TB? ' + Response(CheckBox2,CheckBox3,CheckBox13));
    TmpStrList.Add('  Patient or Partner has history of Genital Herpes? ' + Response(CheckBox4,CheckBox5,CheckBox12));
    TmpStrList.Add('  Rash or Viral Illness since last Menstrual Period? ' + Response(CheckBox8,CheckBox9,CheckBox7));
    TmpStrList.Add('  History of STI, Gonorrhea, Chlamydia, HIV, HPV, Syphilis? ' + Response(CheckBox10,CheckBox11,CheckBox6));
    if Trim(LabeledEdit2.Text) <> '' then
      TmpStrList.Add('   STI Comment: ' + LabeledEdit2.Text);
    TmpStrList.Add('  Prior GBS-Infected child? ' + Response(CheckBox14,CheckBox15,CheckBox16));
    TmpStrList.Add('  Live in a house with cats (toxoplasmosis)? ' + Response(CheckBox17,CheckBox18,CheckBox19));
    TmpStrList.Add('  Lived or stationed overseas? ' + Response(CheckBox20,CheckBox22,CheckBox24));
    TmpStrList.Add('  Born outside the US? ' + Response(CheckBox21,CheckBox23,CheckBox25));

    if memNarrative.Lines.Count > 0 then
    begin
      TmpStrList.Add('  Comments:');
      for I := 0 to memNarrative.Lines.Count - 1 do
        TmpStrList.Add('   ' + memNarrative.Lines[I]);
    end;
  end;
end;

Procedure TdlgInfectHist.ToggleCB(cb1,cb2,cb3: TCheckBox);
begin
  if cb1.Checked = True then
  begin
    cb2.Checked := False;
    cb3.Checked := False;
  end else if cb2.Checked then
  begin
    cb1.Checked := False;
    cb3.Checked := False;
  end else if cb3.Checked then
  begin
    cb1.Checked := False;
    cb2.Checked := False;
  end;
end;

procedure TdlgInfectHist.CheckBox2Click(Sender: TObject);
begin
  if (Sender is TCheckBox) then
  case (Sender as TCheckBox).Tag of
    1: ToggleCB(CheckBox2,CheckBox3,CheckBox13);
    2: ToggleCB(CheckBox3,CheckBox2,CheckBox13);
    3: ToggleCB(CheckBox13,CheckBox2,CheckBox3);
    4: ToggleCB(CheckBox4,CheckBox5,checkbox12);
    5: ToggleCB(CheckBox5,CheckBox4,CheckBox12);
    6: ToggleCB(CheckBox12,CheckBox4,CheckBox5);
    7: ToggleCB(CheckBox8,CheckBox9,CheckBox7);
    8: ToggleCB(CheckBox9,CheckBox8,CheckBox7);
    9: ToggleCB(CheckBox7,CheckBox8,CheckBox9);
   10: ToggleCB(CheckBox10,CheckBox11,CheckBox6);
   11: ToggleCB(CheckBox11,CheckBox10,CheckBox6);
   12: ToggleCB(CheckBox6,CheckBox10,CheckBox11);
   13: ToggleCB(CheckBox14,CheckBox15,CheckBox16);
   14: ToggleCB(CheckBox15,CheckBox14,CheckBox16);
   15: ToggleCB(CheckBox16,CheckBox14,CheckBox15);
   16: ToggleCB(CheckBox17,CheckBox18,CheckBox19);
   17: ToggleCB(CheckBox18,CheckBox17,CheckBox19);
   18: ToggleCB(CheckBox19,CheckBox17,CheckBox18);
   19: ToggleCB(CheckBox20,CheckBox22,CheckBox24);
   20: ToggleCB(CheckBox22,CheckBox20,CheckBox24);
   21: ToggleCB(CheckBox24,CheckBox20,CheckBox22);
   22: ToggleCB(CheckBox21,CheckBox23,CheckBox25);
   23: ToggleCB(CheckBox23,CheckBox21,CheckBox25);
   24: ToggleCB(CheckBox25,CheckBox21,CheckBox23);
  end;
end;

procedure TdlgInfectHist.CheckBox1Click(Sender: TObject);
var
  I: Integer;
begin
  if CheckBox1.Checked then
  begin
    Panel3.Visible := False;
    for I := 0 to Panel3.ControlCount - 1 do
      if Panel3.Controls[I] is TCheckbox then TCheckBox(Panel3.Controls[I]).Checked := False;

    LabeledEdit2.Text := '';
    memNarrative.Clear;
  end else
    Panel3.Visible := True;
end;

end.
