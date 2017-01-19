unit udlgVagBleed;

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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ORCtrls, uDialog, uCommon,
  DDCSUtils, DDCSComBroker;

type
  TdlgVagBleed = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leAmt: TEdit;
    leDur: TEdit;
    lbassociated: TLabel;
    cbCrampY: TCheckBox;
    cbCrampN: TCheckBox;
    lbleakage: TLabel;
    cbLeakY: TCheckBox;
    cbLeakN: TCheckBox;
    lbamount: TLabel;
    lbdur: TLabel;
    lbonset: TLabel;
    pnlfooter: TPanel;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgVagBleed: TdlgVagBleed;

implementation

{$R *.dfm}

procedure TdlgVagBleed.FormCreate(Sender: TObject);
begin
  SayOnFocus(cbCrampY, 'Associated with cramping and or contractions?');
  SayOnFocus(cbCrampN, 'Associated with cramping and or contractions?');
  SayOnFocus( cbLeakY, 'Leakage of fluid?');
  SayOnFocus( cbLeakN, 'Leakage of fluid?');
end;

procedure TdlgVagBleed.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
   TmpStrList.Add('  Onset: ' + leOnset.Text);
  if leDur.Text  <> '' then
   TmpStrList.Add('  Duration: ' + leDur.Text);
  if leAmt.Text  <> '' then
   TmpStrList.Add('  Amount: ' + leAmt.Text);
  if cbCrampY.Checked then
   TmpStrList.Add('  Associated with cramping and or contractions? Yes');
  if cbCrampN.Checked then
   TmpStrList.Add('  Associated with cramping and or contractions? No');
  if cbLeakY.Checked then
   TmpStrList.Add('  Leakage of fluid? Yes');
  if cbLeakN.Checked then
   TmpStrList.Add('  Leakage of fluid? No');

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Vaginal Bleeding:');
end;

procedure TdlgVagBleed.checkboxClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    if (Sender as TCheckBox).Tag = 1 then
      cbCrampN.Checked := False
    else  if (Sender as TCheckBox).Tag = 2 then
      cbCrampY.Checked := False
    else if (Sender as TCheckBox).Tag = 3 then
      cbLeakN.Checked := False
    else  if (Sender as TCheckBox).Tag = 4 then
      cbLeakY.Checked := False;
  end;
end;

end.
