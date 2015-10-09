unit udlgNausea;

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
  TdlgNausea = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leLocal: TLabeledEdit;
    leDur: TLabeledEdit;
    leDur1: TLabeledEdit;
    Label3: TLabel;
    cbSolidY: TCheckBox;
    cbSolidN: TCheckBox;
    Label4: TLabel;
    cbLiquidY: TCheckBox;
    cbLiquidN: TCheckBox;
    Label5: TLabel;
    cbFeverY: TCheckBox;
    cbFeverN: TCheckBox;
    Label6: TLabel;
    cbAbdomY: TCheckBox;
    cbAbdomN: TCheckBox;
    Label1: TLabel;
    cbContY: TCheckBox;
    cbContN: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbSolidYClick(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgNausea: TdlgNausea;

implementation

{$R *.dfm}

procedure TdlgNausea.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
begin
  if (leOnset.Text <> '') or (cbSolidY.Checked) or (cbSolidN.Checked) or
     (cbLiquidY.Checked) or (cbLiquidN.Checked) or (leDur.Text <> '') or
     (cbFeverY.Checked) or (cbFeverN.Checked) or
     (cbAbdomY.Checked) or (cbAbdomN.Checked) or
     (cbContY.Checked) or (cbContN.Checked) then
  begin
   TmpStrList.Add('Nausea/vomiting/diarrhea:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cbSolidY.Checked then TmpStrList.Add('  Can tolerate solids? Yes')
   else if cbSolidN.Checked then TmpStrList.Add('  Can tolerate solids? No');
   if cbLiquidY.Checked then TmpStrList.Add('  Can tolerate liquids? Yes')
   else if cbLiquidN.Checked then TmpStrList.Add('  Can tolerate liquids? No');
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
   if cbFeverY.Checked then TmpStrList.Add('  Fever/chills? Yes')
   else if cbFeverN.Checked then TmpStrList.Add('  Fever/chills? No');
   if cbAbdomY.Checked then
   begin
     TmpStrList.Add('  Abdominal pain? Yes');
     if leLocal.Text  <> '' then TmpStrList.Add('    Localization: ' + leLocal.Text);
     if leDur1.Text  <> '' then TmpStrList.Add('    Duration: ' + leDur1.Text);
     leLocal.SetFocus;
   end
   else if cbAbdomN.Checked then
   begin
     TmpStrList.Add('  Abdominal pain? No');
     leLocal.Clear;
     leDur1.Clear;
   end;
   if cbContY.Checked then TmpStrList.Add('  Contractions? Yes')
   else if cbContN.Checked then TmpStrList.Add('  Contractions? No');
 end;
end;

procedure TdlgNausea.cbSolidYClick(Sender: TObject);
begin
//  if (Sender as TCheckBox).Checked = TRUE then
//  begin
    if ((Sender as TCheckBox).Tag = 1) and ((Sender as TCheckBox).Checked = TRUE) then
      cbSolidN.Checked := FALSE
    else  if ((Sender as TCheckBox).Tag = 2) and ((Sender as TCheckBox).Checked = TRUE) then
      cbSolidY.Checked := FALSE
    else if ((Sender as TCheckBox).Tag = 3) and ((Sender as TCheckBox).Checked = TRUE) then
      cbLiquidN.Checked := FALSE
    else  if ((Sender as TCheckBox).Tag = 4) and ((Sender as TCheckBox).Checked = TRUE) then
      cbLiquidY.Checked := FALSE
    else if ((Sender as TCheckBox).Tag = 5) and ((Sender as TCheckBox).Checked = TRUE) then
      cbFeverN.Checked := FALSE
    else  if ((Sender as TCheckBox).Tag = 6) and ((Sender as TCheckBox).Checked = TRUE) then
      cbFeverY.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 7 then
    begin {Yes}
      if (Sender as TCheckBox).Checked = TRUE then
      begin
        cbAbdomN.Checked := FALSE;
        cbAbdomY.Checked := TRUE;
        leLocal.Visible := TRUE;
        leDur1.Visible := TRUE;
        leLocal.SetFocus;
      end
      else
      begin
        leLocal.Visible := FALSE;
        leDur1.Visible := FALSE;
        leLocal.Clear;
        leDur1.Clear;
      end;
    end
    else  if (Sender as TCheckBox).Tag = 8 then
    begin {No}
      cbAbdomY.Checked := FALSE;
      leLocal.Visible := FALSE;
      leDur1.Visible := FALSE;
      leLocal.Clear;
      leDur1.Clear;
    end
    else if ((Sender as TCheckBox).Tag = 9) and ((Sender as TCheckBox).Checked = TRUE) then
      cbContN.Checked := FALSE
    else  if ((Sender as TCheckBox).Tag = 10) and ((Sender as TCheckBox).Checked = TRUE) then
      cbContY.Checked := FALSE;
end;

end.
