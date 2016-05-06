unit udlgBackPain;

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
  StdCtrls, ExtCtrls, Buttons, uDialog, uExtndComBroker,
  VA508AccessibilityManager;

type
  TdlgBackPain = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leChar: TLabeledEdit;
    leLocat: TLabeledEdit;
    leDur: TLabeledEdit;
    leUrin: TLabeledEdit;
    Label3: TLabel;
    cbDysY: TCheckBox;
    cbDysN: TCheckBox;
    Label1: TLabel;
    cbFeverY: TCheckBox;
    cbFeverN: TCheckBox;
    amgrMain: TVA508AccessibilityManager;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbDysYClick(Sender: TObject);
  private
  public
  end;

var
  dlgBackPain: TdlgBackPain;

implementation

{$R *.dfm}

procedure TdlgBackPain.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
begin
   if (leOnset.Text <> '') or (leDur.Text <> '') or (leLocat.Text <> '') or
     (leChar.Text <> '') or (leUrin.Text <> '') or
     (cbDysY.Checked) or (cbDysN.Checked) or
     (cbFeverY.Checked) or (cbFeverN.Checked) then
  begin
   TmpStrList.Add('Back pain:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
   if leLocat.Text  <> '' then TmpStrList.Add('  Location: ' + leLocat.Text);
   if leChar.Text  <> '' then TmpStrList.Add('  Character: ' + leChar.Text);
   if leUrin.Text  <> '' then TmpStrList.Add('  Urinary frequency/urgency: ' + leUrin.Text);
   if cbDysY.Checked then TmpStrList.Add('  Dysuria? Yes');
   if cbDysN.Checked then TmpStrList.Add('  Dysuria? No');
   if cbFeverY.Checked then TmpStrList.Add('  Fever/chills? Yes');
   if cbFeverN.Checked then TmpStrList.Add('  Fever/chills? No');
  end;
end;

procedure TdlgBackPain.cbDysYClick(Sender: TObject);
begin
 if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = TRUE) then
 begin   {cb6-9 - toggle 4 checkboxes}
   if (Sender as TCheckBox).Tag = 1 then
     cbDysN.Checked := FALSE
   else if (Sender as TCheckBox).Tag = 2 then
     cbDysY.Checked := FALSE
   else if (Sender as TCheckBox).Tag = 3 then
     cbFeverN.Checked := FALSE
   else if (Sender as TCheckBox).Tag = 4 then
     cbFeverY.Checked := FALSE;
  end;
end;

end.
