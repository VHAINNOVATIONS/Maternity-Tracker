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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ORCtrls, uDialog, uCommon,
  DDCSUtils, DDCSComBroker;

type
  TdlgWheezing = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leAssocSym: TEdit;
    leDur: TEdit;
    lbbreath: TLabel;
    cbSOBY: TCheckBox;
    cbSOBN: TCheckBox;
    lbDur: TLabel;
    lbAssociatedSymp: TLabel;
    lbonset: TLabel;
    pnlfooter: TPanel;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgWheezing: TdlgWheezing;

implementation

{$R *.dfm}

procedure TdlgWheezing.FormCreate(Sender: TObject);
begin
  Height := Height - 32;

  SayOnFocus(cbSOBY, 'Shortness of breath?');
  SayOnFocus(cbSOBN, 'Shortness of breath?');
end;

procedure TdlgWheezing.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if cbSOBY.Checked then
    TmpStrList.Add('  Shortness of breath?: Yes');
  if cbSOBN.Checked then
    TmpStrList.Add('  Shortness of breath?: No');
  if leDur.Text  <> '' then
    TmpStrList.Add('  Duration: ' + leDur.Text);
  if leAssocSym.Text  <> '' then
  begin
    TmpStrList.Add('  Associated Symptoms:');
    TmpStrList.Add('    ' + leAssocSym.Text);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Wheezing:');
end;

procedure TdlgWheezing.checkboxClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin
    if (Sender as TCheckBox).Checked then
    begin
      cbSOBN.OnClick := nil;
      cbSOBN.Checked := False;
      cbSOBN.OnClick := checkboxClick;

      Height := Height + 32;

      lbDur.Visible := True;
      leDur.Visible := True;
    end else
    begin
      if lbDur.Visible then
      begin
        lbDur.Visible := False;
        leDur.Clear;
        leDur.Visible := False;

        Height := Height - 32;
      end;
    end;
  end else if (Sender as TCheckBox).Tag = 2 then
  begin
    cbSOBY.OnClick := nil;
    cbSOBY.Checked := False;
    cbSOBY.OnClick := checkboxClick;

    if lbDur.Visible then
    begin
      lbDur.Visible := False;
      leDur.Clear;
      leDur.Visible := False;

      Height := Height - 32;
    end;
  end;
end;

end.
