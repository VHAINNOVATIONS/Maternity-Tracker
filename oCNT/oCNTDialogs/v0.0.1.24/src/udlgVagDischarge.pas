unit udlgVagDischarge;

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
  TdlgVagDischarge = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leColor: TLabeledEdit;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgVagDischarge: TdlgVagDischarge;

implementation

{$R *.dfm}

procedure TdlgVagDischarge.bbtnOKClick(Sender: TObject);
begin
  if (leOnset.Text <> '') or (leColor.Text <> '') or (CheckBox1.Checked) or
     (CheckBox2.Checked) or (CheckBox3.Checked) or (CheckBox4.Checked) then
  begin
   TmpStrList.Add('Vaginal Discharge:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if leColor.Text  <> '' then TmpStrList.Add('  Color: ' + leColor.Text);
   if CheckBox1.Checked then TmpStrList.Add('  Odor? Yes');
   if CheckBox2.Checked then TmpStrList.Add('  Odor? No');
   if CheckBox3.Checked then TmpStrList.Add('  Itching? Yes');
   if CheckBox4.Checked then TmpStrList.Add('  Itching? No');
  end;
end;

procedure TdlgVagDischarge.CheckBox1Click(Sender: TObject);
begin
 if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = TRUE) then
 begin   {cb6-9 - toggle 4 checkboxes}
   if (Sender as TCheckBox).Tag = 1 then
     CheckBox2.Checked := FALSE
   else if (Sender as TCheckBox).Tag = 2 then
     CheckBox1.Checked := FALSE
   else if (Sender as TCheckBox).Tag = 3 then
     CheckBox4.Checked := FALSE
   else if (Sender as TCheckBox).Tag = 4 then
     CheckBox3.Checked := FALSE;
  end;
end;

end.
