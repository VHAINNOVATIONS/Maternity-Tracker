unit udlgROS;

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
  Dialogs, StdCtrls, Buttons, ExtCtrls, uDialog, uExtndComBroker;

type
  TdlgROS = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    Label29: TLabel;
    LabeledEdit1: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
  private
    procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public
  end;

var
  dlgROS: TdlgROS;

implementation

{$R *.dfm}

procedure TdlgROS.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin   {Negative for all}
  for I := 0 to ComponentCount -1 do
  if (Components[I] is TCheckBox) then
  if Odd((TCheckBox(Components[I]).Tag)) = False then
  TCheckBox(Components[I]).Checked := True;
end;

procedure TdlgROS.CheckBox1Click(Sender: TObject);
begin
 if (Sender is TCheckBox) then
  case (Sender as TCheckBox).Tag of
     1: ToggleCB(CheckBox1,CheckBox2);
     2: ToggleCB(CheckBox2,CheckBox1);
     3: ToggleCB(CheckBox3,CheckBox4);
     4: ToggleCB(CheckBox4,CheckBox3);
     5: ToggleCB(CheckBox5,CheckBox6);
     6: ToggleCB(CheckBox6,CheckBox5);
     7: ToggleCB(CheckBox7,CheckBox8);
     8: ToggleCB(CheckBox8,CheckBox7);
     9: ToggleCB(CheckBox9,CheckBox10);
    10: ToggleCB(CheckBox10,CheckBox9);
    11: ToggleCB(CheckBox11,CheckBox12);
    12: ToggleCB(CheckBox12,CheckBox11);
    13: ToggleCB(CheckBox13,CheckBox14);
    14: ToggleCB(CheckBox14,CheckBox13);
    15: ToggleCB(CheckBox15,CheckBox16);
    16: ToggleCB(CheckBox16,CheckBox15);
    17: ToggleCB(CheckBox17,CheckBox18);
    18: ToggleCB(CheckBox18,CheckBox17);
    19: ToggleCB(CheckBox19,CheckBox20);
    20: ToggleCB(CheckBox20,CheckBox19);
    21: ToggleCB(CheckBox21,CheckBox22);
    22: ToggleCB(CheckBox22,CheckBox21);
    23: ToggleCB(CheckBox23,CheckBox24);
    24: ToggleCB(CheckBox24,CheckBox23);
    25: ToggleCB(CheckBox25,CheckBox26);
    26: ToggleCB(CheckBox26,CheckBox25);
  end;
end;

procedure TdlgROS.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
  cb2.Checked := False;
end;

procedure TdlgROS.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I: integer;
  TmpStr: string;

  function Check4True: Boolean;
  {Check for at least 1 checkbox = True }
  var
    J: Integer;
  begin
    for J := 0 to ComponentCount - 1 do
    begin
      if (Components[J] is TCheckBox) and ((Components[J] as TCheckBox).Checked = True) then
      begin
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  if Check4True then
  begin
    TmpStrList.Add('Review of Symptoms since Last Menstrual Period:');

    for I := 0 to ComponentCount - 1 do
    if (Components[I] is TCheckBox) and ((Components[I] as TCheckBox).Checked = True) then
    begin
      TmpStr := '';
      case (Components[I] as TCheckBox).Tag of
         1: begin TmpStr := '  Mood: Yes'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
         2: begin TmpStr := '  Mood: No'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
         3: begin TmpStr := '  Headaches: Yes'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
         4: begin TmpStr := '  Headaches: No'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
         5: begin TmpStr := '  Weight Loss (-) / Weight Gain (+): Yes'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
         6: begin TmpStr := '  Weight Loss (-) / Weight Gain (+): No'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
         7: begin TmpStr := '  Visual Changes: Yes'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
         8: begin TmpStr := '  Visual Changes: No'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
         9: begin TmpStr := '  Ears/Nose/Throat: Abnormal'; if Edit5.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
        10: begin TmpStr := '  Ears/Nose/Throat: Normal'; if Edit5.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
        11: begin TmpStr := '  Chest Pain / Palpitation: Yes'; if Edit6.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
        12: begin TmpStr := '  Chest Pain / Palpitation: No'; if Edit6.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
        13: begin TmpStr := '  Dyspnea / Cough / Hemoptysis: Yes'; if Edit7.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
        14: begin TmpStr := '  Dyspnea / Cough / Hemoptysis: No'; if Edit7.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
        15: begin TmpStr := '  GI Symptoms: Nausea / Vomiting: Yes'; if Edit8.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
        16: begin TmpStr := '  GI Symptoms: Nausea / Vomiting: No'; if Edit8.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
        17: begin TmpStr := '  GU Symptoms: Burning / Pain / Blood: Yes'; if Edit9.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
        18: begin TmpStr := '  GU Symptoms: Burning / Pain / Blood: No'; if Edit9.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
        19: begin TmpStr := '  Bone or Joint Pain / Joint Swelling: Yes'; if Edit10.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
        20: begin TmpStr := '  Bone or Joint Pain / Joint Swelling: No'; if Edit10.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
        21: begin TmpStr := '  Vaginal Bleeding / Discharge: Yes'; if Edit11.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
        22: begin TmpStr := '  Vaginal Bleeding / Discharge: No'; if Edit11.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
        23: begin TmpStr := '  Skin Rash / Itch: Yes'; if Edit12.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
        24: begin TmpStr := '  Skin Rash / Itch: No'; if Edit12.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
        25: begin TmpStr := '  Heat / Cold Intolerance: Yes'; if Edit13.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
        26: begin TmpStr := '  Heat / Cold Intolerance: No'; if Edit13.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
      end;
      TmpStrList.Add(TmpStr);
    end;

    if Trim(LabeledEdit1.Text) <> '' then
    TmpStrList.Add('  Other: ' + LabeledEdit1.Text);
  end;
end;

end.
