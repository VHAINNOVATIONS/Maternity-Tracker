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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, ORCtrls, uDialog, DDCSComBroker;

type
  TdlgAbdomPain = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leLocat: TEdit;
    leFreq: TEdit;
    leDur: TEdit;
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
    lbonset: TLabel;
    lbFreq: TLabel;
    lbDur: TLabel;
    lbloc: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbContYesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgAbdomPain: TdlgAbdomPain;

implementation

{$R *.dfm}

procedure TdlgAbdomPain.FormCreate(Sender: TObject);
begin
  SayOnFocus(cbContYes, 'Contractions?');
  SayOnFocus( cbContNo, 'Contractions?');
  SayOnFocus(cbNausYes, 'Nausea, Vomiting, and or Diarrhea?');
  SayOnFocus( cbNausNo, 'Nausea, Vomiting, and or Diarrhea?');
  SayOnFocus( cbAppYes, 'Appetite?');
  SayOnFocus(  cbAppNo, 'Appetite?');
  SayOnFocus( cbFevYes, 'Fever and or Chills?');
  SayOnFocus(  cbFevNo, 'Fever and or Chills?');
end;

procedure TdlgAbdomPain.bbtnOKClick(Sender: TObject);
begin
 if leOnset.Text  <> '' then
   TmpStrList.Add('  Onset: ' + leOnset.Text);

 if cbContYes.Checked then
 begin
   TmpStrList.Add('  Contractions? Yes');
   if leFreq.Text <> '' then
     TmpStrList.Add('    Frequency:' + leFreq.Text);
   if leDur.Text  <> '' then
     TmpStrList.Add('    Duration:' + leDur.Text);
 end else if cbContNo.Checked then
   TmpStrList.Add('  Contractions? No');

 if cbNausYes.Checked then
   TmpStrList.Add('  Nausea, Vomiting, Diarrhea? Yes');
 if cbNausNo.Checked then
   TmpStrList.Add('  Nausea, Vomiting, Diarrhea? No');
 if cbAppYes.Checked then
   TmpStrList.Add('  Appetite? Yes');
 if cbAppNo.Checked then
   TmpStrList.Add('  Appetite? No');
 if cbFevYes.Checked then
   TmpStrList.Add('  Fever and or Chills? Yes');
 if cbFevNo.Checked then
   TmpStrList.Add('  Fever and or Chills? No');
 if leLocat.Text  <> '' then
   TmpStrList.Add('  Location: ' + leLocat.Text);

 if TmpStrList.Count > 0 then
   TmpStrList.Insert(0, 'Abdominal Pain and Cramping:');
end;

procedure TdlgAbdomPain.cbContYesClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin
    if (Sender as TCheckBox).Checked then
    begin
      cbContNo.OnClick := nil;
      cbContNo.Checked := False;
      cbContNo.OnClick := cbContYesClick;

      lbFreq.Visible := True;
      leFreq.Visible := True;
      lbDur.Visible := True;
      leDur.Visible := True;
    end else
    begin
      leFreq.Clear;
      lbFreq.Visible := False;
      leFreq.Visible := False;
      leDur.Clear;
      lbDur.Visible := False;
      leDur.Visible := False;
    end;
  end else if (Sender as TCheckBox).Tag = 2 then
  begin
    cbContYes.OnClick := nil;
    cbContYes.Checked := False;
    cbContYes.OnClick := cbContYesClick;

    leFreq.Clear;
    lbFreq.Visible := False;
    leFreq.Visible := False;
    leDur.Clear;
    lbDur.Visible := False;
    leDur.Visible := False;
  end
  else if ((Sender as TCheckBox).Tag = 3) and ((Sender as TCheckBox).Checked) then
    cbNausNo.Checked := False
  else if ((Sender as TCheckBox).Tag = 4) and ((Sender as TCheckBox).Checked) then
    cbNausYes.Checked := False
  else if ((Sender as TCheckBox).Tag = 5) and ((Sender as TCheckBox).Checked) then
    cbAppNo.Checked := False
  else if ((Sender as TCheckBox).Tag = 6) and ((Sender as TCheckBox).Checked) then
    cbAppYes.Checked := False
  else if ((Sender as TCheckBox).Tag = 7) and ((Sender as TCheckBox).Checked) then
    cbFevNo.Checked := False
  else if ((Sender as TCheckBox).Tag = 8) and ((Sender as TCheckBox).Checked) then
    cbFevYes.Checked := False;
end;

end.
