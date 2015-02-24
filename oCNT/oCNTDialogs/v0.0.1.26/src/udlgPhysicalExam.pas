unit udlgPhysicalExam;

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
  Dialogs, StdCtrls, Buttons, ExtCtrls, oCNTBase, uExtndComBroker;

type
  TdlgPhysicalExam = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Edit13: TEdit;
    Edit12: TEdit;
    Edit11: TEdit;
    Edit10: TEdit;
    Edit9: TEdit;
    Edit8: TEdit;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    Label29: TLabel;
    LabeledEdit1: TLabeledEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
  private
    procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public
  end;

var
  dlgPhysicalExam: TdlgPhysicalExam;

implementation

{$R *.dfm}

procedure TdlgPhysicalExam.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin   {Negative for all}
  for I := 0 to ComponentCount -1 do
  if (Components[I] is TCheckBox) then
  if Odd((TCheckBox(Components[I]).Tag)) = True then
  TCheckBox(Components[I]).Checked := True;
end;

procedure TdlgPhysicalExam.CheckBox1Click(Sender: TObject);
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
    27: ToggleCB(CheckBox27,CheckBox28);
    28: ToggleCB(CheckBox28,CheckBox27);
    29: ToggleCB(CheckBox29,CheckBox30);
    30: ToggleCB(CheckBox30,CheckBox29);
    31: ToggleCB(CheckBox31,CheckBox32);
    32: ToggleCB(CheckBox32,CheckBox31);
    33: ToggleCB(CheckBox33,CheckBox34);
    34: ToggleCB(CheckBox34,CheckBox33);
  end;
end;

procedure TdlgPhysicalExam.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
  cb2.Checked := False;
end;

procedure TdlgPhysicalExam.bbtnOKClick(Sender: TObject);
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
    TmpStrList.Add('Physical Exam:');

    for I := 0 to ComponentCount - 1 do
    if (Components[I] is TCheckBox) and ((Components[I] as TCheckBox).Checked = True) then
    begin
      TmpStr := '';
      case (Components[I] as TCheckBox).Tag of
         1: begin TmpStr := '  General: Normal'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
         2: begin TmpStr := '  General: Abnormal'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
         3: begin TmpStr := '  Psych: Normal'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
         4: begin TmpStr := '  Psych: Abnormal'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
         5: begin TmpStr := '  HEENT: Normal'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
         6: begin TmpStr := '  HEENT: Abnormal'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
         7: begin TmpStr := '  Fundi: Normal'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
         8: begin TmpStr := '  Fundi: Abnormal'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
         9: begin TmpStr := '  Teeth: Normal'; if Edit5.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
        10: begin TmpStr := '  Teeth: Abnormal'; if Edit5.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
        11: begin TmpStr := '  Thyroid: Normal'; if Edit6.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
        12: begin TmpStr := '  Thyroid: Abnormal'; if Edit6.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
        13: begin TmpStr := '  Neck: Normal'; if Edit7.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
        14: begin TmpStr := '  Neck: Abnormal'; if Edit7.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
        15: begin TmpStr := '  Breasts: Normal'; if Edit8.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
        16: begin TmpStr := '  Breasts: Abnormal'; if Edit8.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
        17: begin TmpStr := '  Thorax/Lungs: Normal'; if Edit9.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
        18: begin TmpStr := '  Thorax/Lungs: Abnormal'; if Edit9.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
        19: begin TmpStr := '  Heart: Normal'; if Edit10.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
        20: begin TmpStr := '  Heart: Abnormal'; if Edit10.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
        21: begin TmpStr := '  Cardiovascular: Normal'; if Edit11.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
        22: begin TmpStr := '  Cardiovascular: Abnormal'; if Edit11.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
        23: begin TmpStr := '  Abdomen: Normal'; if Edit12.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
        24: begin TmpStr := '  Abdomen: Abnormal'; if Edit12.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
        25: begin TmpStr := '  Back: Normal'; if Edit13.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
        26: begin TmpStr := '  Back: Abnormal'; if Edit13.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
        27: begin TmpStr := '  Pelvic Exam: Normal'; if Edit14.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit14.Text; end;
        28: begin TmpStr := '  Pelvic Exam: Abnormal'; if Edit14.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit14.Text; end;
        29: begin TmpStr := '  Extremities: Normal'; if Edit15.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit15.Text; end;
        30: begin TmpStr := '  Extremities: Abnormal'; if Edit15.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit15.Text; end;
        31: begin TmpStr := '  Skin: Normal'; if Edit16.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit16.Text; end;
        32: begin TmpStr := '  Skin: Abnormal'; if Edit16.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit16.Text; end;
        33: begin TmpStr := '  Lymph Nodes: Normal'; if Edit17.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit17.Text; end;
        34: begin TmpStr := '  Lymph Nodes: Abnormal'; if Edit17.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit17.Text; end;
      end;
      TmpStrList.Add(TmpStr);
    end;

    if Trim(LabeledEdit1.Text) <> '' then
    TmpStrList.Add('  Other: ' + LabeledEdit1.Text);
  end;
end;

end.
