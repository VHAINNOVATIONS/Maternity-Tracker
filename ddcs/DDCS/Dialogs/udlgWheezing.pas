unit udlgWheezing;

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
  TdlgWheezing = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leAssocSym: TLabeledEdit;
    leDur: TLabeledEdit;
    Label3: TLabel;
    cbSOBY: TCheckBox;
    cbSOBN: TCheckBox;
    amgrMain: TVA508AccessibilityManager;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbSOBYClick(Sender: TObject);
  private
  public
  end;

var
  dlgWheezing: TdlgWheezing;

implementation

{$R *.dfm}

procedure TdlgWheezing.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I : Integer;
begin
  if (leOnset.Text <> '') or (cbSOBY.Checked) or (cbSOBN.Checked) or
     (leDur.Text <> '') or (leAssocSym.Text <> '') then
  begin
   TmpStrList.Add('Wheezing:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cbSOBY.Checked then TmpStrList.Add('  Shortness of breath: Yes');
   if cbSOBN.Checked then TmpStrList.Add('  Shortness of breath: No');
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
   if leAssocSym.Text  <> '' then TmpStrList.Add('  Associated symptoms: ' + leAssocSym.Text);
 end;
end;

procedure TdlgWheezing.cbSOBYClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin {Yes}
    if (Sender as TCheckBox).Checked = TRUE then
    begin
      cbSOBN.Checked := FALSE;
      cbSOBY.Checked := TRUE;
      leDur.Visible := TRUE;
      leDur.SetFocus;
    end
    else
    begin
      leDur.Visible := FALSE;
      leDur.Clear;
    end;
  end
  else
  begin
    cbSOBY.Checked := FALSE;
    leDur.Visible := FALSE;
    leDur.Clear;
  end;
end;

end.
