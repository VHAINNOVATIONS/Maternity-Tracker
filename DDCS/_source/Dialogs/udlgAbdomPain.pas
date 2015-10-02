unit udlgAbdomPain;

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
  TdlgAbdomPain = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leLocat: TLabeledEdit;
    leFreq: TLabeledEdit;
    leDur: TLabeledEdit;
    Label3: TLabel;
    cbContYes: TCheckBox;
    cbContNo: TCheckBox;
    Label1: TLabel;
    cbNausYes: TCheckBox;
    cbNausNo: TCheckBox;
    Label4: TLabel;
    cbAppYes: TCheckBox;
    cbAppNo: TCheckBox;
    Label5: TLabel;
    cbFevYes: TCheckBox;
    cbFevNo: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbContYesClick(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgAbdomPain: TdlgAbdomPain;

implementation

{$R *.dfm}

procedure TdlgAbdomPain.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I : Integer;
begin
  if (leOnset.Text <> '') or (cbContYes.Checked) or (cbContNo.Checked) or
     (leFreq.Text <> '') or (leDur.Text <> '') or (cbNausYes.Checked) or
     (cbNausNo.Checked) or (cbAppYes.Checked) or (cbAppNo.Checked) or
     (cbFevYes.Checked) or (cbFevNo.Checked) or (leLocat.Text <> '')
     then
  begin
   TmpStrList.Add('Abdominal Pain/Cramping:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cbContYes.Checked  then
   begin
     TmpStrList.Add('  Contractions? Yes');
     if leFreq.Text  <> '' then
       TmpStrList.Add('    Frequency:' + leFreq.Text);
     if leDur.Text  <> '' then
       TmpStrList.Add('    Duration:' + leDur.Text);
   end
   else if cbContNo.Checked  then
     TmpStrList.Add('  Contractions? No');

   if cbNausYes.Checked then TmpStrList.Add('  Nausea/Vomiting/Diarrhea? Yes');
   if cbNausNo.Checked then TmpStrList.Add('  Nausea/Vomiting/Diarrhea? No');
   if cbAppYes.Checked then TmpStrList.Add('  Appetite? Yes');
   if cbAppNo.Checked then TmpStrList.Add('  Appetite? No');
   if cbFevYes.Checked then TmpStrList.Add('  Fever? Yes');
   if cbFevNo.Checked then TmpStrList.Add('  Fever? No');
   if leLocat.Text  <> '' then TmpStrList.Add('  Location: ' + leLocat.Text);
  end;
end;

procedure TdlgAbdomPain.cbContYesClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin  {Yes}
    if (Sender as TCheckBox).Checked = TRUE then
    begin  {Yes}
      cbContNo.Checked := FALSE;
      cbContYes.Checked := TRUE;
      leFreq.Visible := TRUE;
      leDur.Visible := TRUE;
      leFreq.SetFocus;
    end
    else if (Sender as TCheckBox).Checked = FALSE then
    begin  {Yes - unchecked}
      leFreq.Visible := FALSE;
      leDur.Visible := FALSE;
      leFreq.Clear;
      leDur.Clear;
    end;
  end
  else if (Sender as TCheckBox).Tag = 2 then
  begin   {No}
    cbContYes.Checked := FALSE;
    leFreq.Visible := FALSE;
    leDur.Visible := FALSE;
    leFreq.Clear;
    leDur.Clear;
  end
  else if ((Sender as TCheckBox).Tag = 3) and ((Sender as TCheckBox).Checked = TRUE) then
    cbNausNo.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 4) and ((Sender as TCheckBox).Checked = TRUE) then
    cbNausYes.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 5) and ((Sender as TCheckBox).Checked = TRUE) then
    cbAppNo.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 6) and ((Sender as TCheckBox).Checked = TRUE) then
    cbAppYes.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 7) and ((Sender as TCheckBox).Checked = TRUE) then
    cbFevNo.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 8) and ((Sender as TCheckBox).Checked = TRUE) then
    cbFevYes.Checked := FALSE;

end;

end.
