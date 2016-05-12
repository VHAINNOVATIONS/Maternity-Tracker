unit udlgGenetic;

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
  StdCtrls, ExtCtrls, Buttons, StrUtils, uDialog, uExtndComBroker,
  VA508AccessibilityManager;

type
  TdlgGenetic = class(TDDCSDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label3: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label2: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Label4: TLabel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Label5: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Label7: TLabel;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Label8: TLabel;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Label9: TLabel;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Label10: TLabel;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    Label11: TLabel;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    Label12: TLabel;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    Label13: TLabel;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    Label14: TLabel;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    Label15: TLabel;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    Label16: TLabel;
    Label17: TLabel;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    Label18: TLabel;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    Edit1: TEdit;
    Label19: TLabel;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    Label20: TLabel;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    Label21: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    Procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public
    procedure PopulateGeneticValuesStrList;
  end;

var
  dlgGenetic: TdlgGenetic;

implementation

{$R *.dfm}

Procedure TdlgGenetic.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked then
  cb2.Checked := False;
end;

procedure TdlgGenetic.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  i: integer;
begin
  PopulateGeneticValuesStrList;
//  sl.Clear;
//  for i := 0 to self.ComponentCount -1 do
//  begin
//    if self.Components[i] is TCheckBox then
//    begin
//      if (self.Components[i] as TCheckBox).Checked then
//        sl.Add(IntToStr((self.Components[i] as TCheckBox).Tag));
//    end
//    else if self.Components[i] is TEdit then
//    begin
//      if (self.Components[i] as TEdit).Text <> '' then
//        sl.Add('-999e^' + (self.Components[i] as TEdit).Text);
//    end
//    else if self.Components[i] is TLabeledEdit then
//    begin
//      if (self.Components[i] as TLabeledEdit).Text <> '' then
//        sl.Add('-999l^' + (self.Components[i] as TLabeledEdit).Text);
//    end;
//  end;
end;

procedure TdlgGenetic.CheckBox1Click(Sender: TObject);
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
//------------------------------------------
    25: begin {YES}
          ToggleCB(CheckBox25,CheckBox26);
          if CheckBox25.Checked then
          begin
            Label15.Visible := TRUE;
            CheckBox27.Visible := TRUE;
            CheckBox28.Visible := TRUE;
          end
          else
          begin
            Label15.Visible := FALSE;
            CheckBox27.Visible := FALSE;
            CheckBox28.Visible := FALSE;
            CheckBox27.Checked := FALSE;
            CheckBox28.Checked := FALSE;
          end;
        end;
    26: begin {NO}
          ToggleCB(CheckBox26,CheckBox25);
          if CheckBox26.Checked then
          begin
            Label15.Visible := FALSE;
            CheckBox27.Visible := FALSE;
            CheckBox28.Visible := FALSE;
            CheckBox27.Checked := FALSE;
            CheckBox28.Checked := FALSE;
          end;
        end;
//--------------
    27: ToggleCB(CheckBox27,CheckBox28);
    28: ToggleCB(CheckBox28,CheckBox27);

    29: ToggleCB(CheckBox29,CheckBox30);
    30: ToggleCB(CheckBox30,CheckBox29);

    31: ToggleCB(CheckBox31,CheckBox32);
    32: ToggleCB(CheckBox30,CheckBox31);
//---------------
    33: begin {YES}
          ToggleCB(CheckBox33,CheckBox34);
          if CheckBox33.Checked then
          begin
            Edit1.Visible := TRUE;
            Edit1.SetFocus;
          end
          else
          begin
            Edit1.Visible := FALSE;
            Edit1.Clear;
          end;
        end;
    34: begin {NO}
         ToggleCB(CheckBox34,CheckBox33);
          if CheckBox34.Checked then
          begin
            Edit1.Visible := FALSE;
            Edit1.Clear;
          end;
        end;
//----------------
    35: ToggleCB(CheckBox35,CheckBox36);
    36: ToggleCB(CheckBox36,CheckBox35);
    37: ToggleCB(CheckBox37,CheckBox38);
    38: ToggleCB(CheckBox38,CheckBox37);
    39: ToggleCB(CheckBox39,CheckBox40);
    40: ToggleCB(CheckBox40,CheckBox39);
    end;
end;

procedure TdlgGenetic.BitBtn1Click(Sender: TObject);
var
  I,CompChecked : Integer;
begin   {Negative for all}
  // x mod 2 = 0 then even
  for I := 0 to ComponentCount -1 do
    if (Components[I] is TCheckBox) then
      if Odd((TCheckBox(Components[I]).Tag)) = FALSE then
         TCheckBox(Components[I]).Checked := TRUE;
  CheckBox28.Checked := False;
end;

procedure TdlgGenetic.PopulateGeneticValuesStrList;
var
  TmpStr: string;
  CompChecked,I: Integer;
begin
  TmpStr := '';

  CompChecked := 0;
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TCheckBox) then
    if (TCheckBox(Components[I]).Checked) then
    begin
      Inc(CompChecked); {total checked}
      Break;  //since only one has to be checked let's move on
    end;
  end;

  if CompChecked > 0 then
  begin
    TmpStrList.Add('Genetic Screening:');
    TmpStrList.Add('  Includes patient, baby''s father, or anyone in either family with:');
    for I := 0 to ComponentCount - 1 do
    begin
      if (Components[I] is TCheckBox) then
      if TCheckBox(Components[I]).Checked then
      begin
        TmpStrList.Add('    ' + ((Components[I] as TCheckBox).Hint));

        if (Components[I] as TCheckBox).Name = 'Checkbox33' then
        if Edit1.Text <> '' then TmpStrList.Add('      ' + Edit1.Text);
      end;
    end;

    if LabeledEdit1.Text <> '' then  {Other}
    TmpStrList.Add('    ' + LabeledEdit1.Text)
  end;
end;

end.
