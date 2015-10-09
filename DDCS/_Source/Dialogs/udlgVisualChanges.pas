unit udlgVisualChanges;

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
  TdlgVisualChanges = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leOther: TLabeledEdit;
    leDur: TLabeledEdit;
    cmbChar: TComboBox;
    Label2: TLabel;
    cmbLoc: TComboBox;
    Label3: TLabel;
    Label1: TLabel;
    cbVisCh: TCheckBox;
    cbNaus: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgVisualChanges: TdlgVisualChanges;

implementation

{$R *.dfm}

procedure TdlgVisualChanges.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I : Integer;
begin
  if (leOnset.Text <> '') or (cmbChar.Text <> '') or (cmbLoc.Text <> '') or
    (cbVisCh.Checked) or (cbNaus.Checked) or (leOther.Text <> '') or
    (leDur.Text <> '') then
  begin
   TmpStrList.Add('Visual changes:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cmbChar.Text  <> '' then TmpStrList.Add('  Character: ' + cmbChar.Text);
   if cmbLoc.Text  <> '' then TmpStrList.Add('  Location: ' + cmbLoc.Text);
   if (cbVisCh.Checked) or (cbNaus.Checked) or (leOther.Text  <> '' ) then
   begin
     TmpStrList.Add('  Associated Symptoms:');
     if cbVisCh.Checked then TmpStrList.Add('    Visual Changes');
     if cbNaus.Checked then TmpStrList.Add('    Nausea');
     if leOther.Text  <> '' then TmpStrList.Add('    Other: ' + leOther.Text);
   end;
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
 end;
end;

end.
