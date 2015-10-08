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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, uDialog, uExtndComBroker;

type
  TdlgVagBleed = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leAmt: TLabeledEdit;
    leDur: TLabeledEdit;
    Label3: TLabel;
    cbCrampY: TCheckBox;
    cbCrampN: TCheckBox;
    Label1: TLabel;
    cbLeakY: TCheckBox;
    cbLeakN: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbCrampYClick(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgVagBleed: TdlgVagBleed;

implementation

{$R *.dfm}

procedure TdlgVagBleed.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
begin
  if (leOnset.Text <> '') or (leDur.Text <> '') or (leAmt.Text <> '') or
     (cbCrampY.Checked) or (cbCrampN.Checked) or
     (cbLeakY.Checked) or (cbLeakN.Checked) then
  begin
   TmpStrList.Add('Vaginal bleeding:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
   if leAmt.Text  <> '' then TmpStrList.Add('  Amount: ' + leAmt.Text);
   if cbCrampY.Checked then TmpStrList.Add('  Associated with cramping/contractions? Yes');
   if cbCrampN.Checked then TmpStrList.Add('  Associated with cramping/contractions? No');
   if cbLeakY.Checked then TmpStrList.Add('  Leakage of fluid? Yes');
   if cbLeakN.Checked then TmpStrList.Add('  Leakage of fluid? No');
  end;
end;

procedure TdlgVagBleed.cbCrampYClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked = TRUE then
  begin
    if (Sender as TCheckBox).Tag = 1 then
      cbCrampN.Checked := FALSE
    else  if (Sender as TCheckBox).Tag = 2 then
      cbCrampY.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 3 then
      cbLeakN.Checked := FALSE
    else  if (Sender as TCheckBox).Tag = 4 then
      cbLeakY.Checked := FALSE;
  end;
end;

end.
