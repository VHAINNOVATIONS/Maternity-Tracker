unit udlgHeadache;

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
  TdlgHeadache = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leChar: TEdit;
    leLocat: TEdit;
    leDur: TEdit;
    lbonset: TLabel;
    lbchar: TLabel;
    lbloc: TLabel;
    lbdur: TLabel;
    Panel1: TPanel;
    leWhat: TEdit;
    cbTreatNo: TCheckBox;
    cbTreatYes: TCheckBox;
    leAssoc: TEdit;
    lbtreatments: TLabel;
    lbsymptoms: TLabel;
    lbWhat: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbTreatYesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgHeadache: TdlgHeadache;

implementation

{$R *.dfm}

procedure TdlgHeadache.FormCreate(Sender: TObject);
begin
  SayOnFocus(cbTreatYes, 'Treatments?');
  SayOnFocus( cbTreatNo, 'Treatments?');
  SayOnFocus(   leAssoc, 'Associated Symptoms?');
  SayOnFocus(    leWhat, 'What was used? What was the effectiveness?');
end;

procedure TdlgHeadache.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if leChar.Text  <> '' then
    TmpStrList.Add('  Character: ' + leChar.Text);
  if leLocat.Text  <> '' then
    TmpStrList.Add('  Localization: ' + leLocat.Text);
  if leDur.Text  <> '' then
    TmpStrList.Add('  Duration: ' + leDur.Text);
  if leAssoc.Text  <> '' then
  begin
    TmpStrList.Add('  Associated Symptoms:');
    TmpStrList.Add('    ' + leAssoc.Text);
  end;
  if cbTreatYes.Checked  then
  begin
    TmpStrList.Add('  Treatments? Yes');
    if leWhat.Text  <> '' then TmpStrList.Add('  What was used? What was the effectiveness? ' + leWhat.Text);
  end else if cbTreatNo.Checked then
    TmpStrList.Add('  Treatments? No');

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Headaches:');
end;

procedure TdlgHeadache.cbTreatYesClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin
    if (Sender as TCheckBox).Checked then
    begin
      cbTreatNo.OnClick := nil;
      cbTreatNo.Checked := False;
      cbTreatNo.OnClick := cbTreatYesClick;

      lbWhat.Visible := True;
      leWhat.Visible := True;
    end else
    begin
      lbWhat.Visible := False;
      leWhat.Clear;
      leWhat.Visible := False;
    end;
  end else if (Sender as TCheckBox).Tag = 2 then
  begin
    cbTreatYes.OnClick := nil;
    cbTreatYes.Checked := False;
    cbTreatYes.OnClick := cbTreatYesClick;

    lbWhat.Visible := False;
    leWhat.Clear;
    leWhat.Visible := False;
  end;
end;

end.
