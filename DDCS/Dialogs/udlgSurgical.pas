unit udlgSurgical;

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
  Dialogs, uDialog, uExtndComBroker, StdCtrls, ExtCtrls, Buttons,
  VA508AccessibilityManager;

type
  TdlgSurgical = class(TDDCSDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label24: TLabel;
    Memo1: TMemo;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    Edit24: TEdit;
    CheckBox43: TCheckBox;
    CheckBox44: TCheckBox;
    Edit25: TEdit;
    CheckBox45: TCheckBox;
    CheckBox46: TCheckBox;
    Edit26: TEdit;
    CheckBox47: TCheckBox;
    CheckBox48: TCheckBox;
    Edit27: TEdit;
    Edit18: TEdit;
    CheckBox40: TCheckBox;
    CheckBox39: TCheckBox;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    Edit19: TEdit;
    Label6: TLabel;
    Edit1: TEdit;
    CheckBox49: TCheckBox;
    CheckBox50: TCheckBox;
    BitBtn1: TBitBtn;
    Label7: TLabel;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label8: TLabel;
    Edit3: TEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label9: TLabel;
    Edit4: TEdit;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBox37Click(Sender: TObject);
  private
    procedure ToggleCB(cb1:TCheckBox; cb2:TCheckBox);
  public
  end;

var
  dlgSurgical: TdlgSurgical;

implementation

{$R *.dfm}

procedure TdlgSurgical.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin   {Negative for all}
  for I := 0 to ControlCount - 1 do
    if (Controls[I] is TCheckBox) then
      if Odd((TCheckBox(Controls[I]).Tag)) = False then
        TCheckBox(Controls[I]).Checked := True;
end;

procedure TdlgSurgical.CheckBox37Click(Sender: TObject);
begin
 if (Sender is TCheckBox) then
  case (Sender as TCheckBox).Tag of
    37: ToggleCB(CheckBox37,CheckBox38);
    38: ToggleCB(CheckBox38,CheckBox37);
    39: ToggleCB(CheckBox39,CheckBox40);
    40: ToggleCB(CheckBox40,CheckBox39);
    41: ToggleCB(CheckBox41,CheckBox42);
    42: ToggleCB(CheckBox42,CheckBox41);
    43: ToggleCB(CheckBox43,CheckBox44);
    44: ToggleCB(CheckBox44,CheckBox43);
    45: ToggleCB(CheckBox45,CheckBox46);
    46: ToggleCB(CheckBox46,CheckBox45);
    47: ToggleCB(CheckBox47,CheckBox48);
    48: ToggleCB(CheckBox48,CheckBox47);
    49: ToggleCB(CheckBox49,CheckBox50);
    50: ToggleCB(CheckBox50,CheckBox49);
    51: ToggleCB(CheckBox1,CheckBox2);
    52: ToggleCB(CheckBox2,CheckBox1);
    53: ToggleCB(CheckBox3,CheckBox4);
    54: ToggleCB(CheckBox4,CheckBox3);
    55: ToggleCB(CheckBox5,CheckBox6);
    56: ToggleCB(CheckBox6,CheckBox5);
  end;
end;

procedure TdlgSurgical.ToggleCB(cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
    cb2.Checked := False;
end;

procedure TdlgSurgical.bbtnOKClick(Sender: TObject);
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
    TmpStrList.Add('Surgical History:');

    for I := 0 to ComponentCount - 1 do
    if (Components[I] is TCheckBox) and ((Components[I] as TCheckBox).Checked = True) then
    begin
      TmpStr := '';
      case (Components[I] as TCheckBox).Tag of
        37 : begin TmpStr := '  Operations/Hospitalizations: POS'; if Edit19.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit19.Text; end;
        38 : begin TmpStr := '  Operations/Hospitalizations: NEG'; if Edit19.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit19.Text; end;
        39 : begin TmpStr := '  Anesthetic Complications: POS'; if Edit18.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit18.Text; end;
        40 : begin TmpStr := '  Anesthetic Complications: NEG'; if Edit18.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit18.Text; end;
        41 : begin TmpStr := '  Oophorectomy: POS'; if Edit24.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit24.Text; end;
        42 : begin TmpStr := '  Oophorectomy: NEG'; if Edit24.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit24.Text; end;
        43 : begin TmpStr := '  Cholecystectomy: POS'; if Edit25.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit25.Text; end;
        44 : begin TmpStr := '  Cholecystectomy: NEG'; if Edit25.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit25.Text; end;
        45 : begin TmpStr := '  Laparoscopy: POS'; if Edit26.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit26.Text; end;
        46 : begin TmpStr := '  Laparoscopy: NEG'; if Edit26.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit26.Text; end;
        47 : begin TmpStr := '  D&C: POS'; if Edit27.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit27.Text; end;
        48 : begin TmpStr := '  D&C: NEG'; if Edit27.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit27.Text; end;
        49 : begin TmpStr := '  C-Section: POS'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
        50 : begin TmpStr := '  C-Section: NEG'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
        51 : begin TmpStr := '  Appendectomy: POS'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
        52 : begin TmpStr := '  Appendectomy: NEG'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
        53 : begin TmpStr := '  Tonsils & Adenoids: POS'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
        54 : begin TmpStr := '  Tonsils & Adenoids: NEG'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
        55 : begin TmpStr := '  Additional Surgeries: POS'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
        56 : begin TmpStr := '  Additional Surgeries: NEG'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
      end;
      TmpStrList.Add(TmpStr);
    end;

    if Memo1.Lines.Count > 0 then
    begin
      TmpStrList.Add('  Surgical Narrative:');
      for I := 0 to Memo1.Lines.Count - 1  do
        TmpStrList.Add('   ' + Memo1.Lines[I]);
    end;
  end;
end;

end.
