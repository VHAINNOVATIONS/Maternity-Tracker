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

   v2.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ORCtrls, uDialog, uCommon, uExtndComBroker;

type
  TdlgVisualChanges = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    cmbChar: TComboBox;
    lbchar: TLabel;
    cmbLoc: TComboBox;
    lbloc: TLabel;
    lbonset: TLabel;
    pnlfooter: TPanel;
    leDur: TEdit;
    lbdur: TLabel;
    Panel1: TPanel;
    leAssociatedSymp: TEdit;
    lbsymptoms: TLabel;
    procedure bbtnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgVisualChanges: TdlgVisualChanges;

implementation

{$R *.dfm}

procedure TdlgVisualChanges.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if cmbChar.Text  <> '' then
    TmpStrList.Add('  Character: ' + cmbChar.Text);
  if cmbLoc.Text  <> '' then
    TmpStrList.Add('  Location: ' + cmbLoc.Text);
  if leDur.Text  <> '' then
    TmpStrList.Add('  Duration: ' + leDur.Text);
  if leAssociatedSymp.Text <> '' then
  begin
   TmpStrList.Add('  Associated Symptoms:');
   TmpStrList.Add('    ' + leAssociatedSymp.Text);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Visual Changes:');
end;

end.
