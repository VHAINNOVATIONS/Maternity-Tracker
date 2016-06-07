unit udlgImmunizations;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ORDtTm, uDialog, uExtndComBroker;

type
  TdlgImmunizations = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    lbInformation: TStaticText;
    lbTDAP: TLabel;
    dtTDAP: TORDateBox;
    dtInfluenza: TORDateBox;
    lbInfluenza: TLabel;
    dtMMR: TORDateBox;
    lbMMR: TLabel;
    dtVaricella: TORDateBox;
    lbVaricella: TLabel;
    edTDAP: TEdit;
    edInfluenza: TEdit;
    edMMR: TEdit;
    edVaricella: TEdit;
    dtOther1: TORDateBox;
    edOther1: TEdit;
    lbOther1: TLabel;
    dtOther2: TORDateBox;
    edOther2: TEdit;
    lbOther2: TLabel;
    dtOther3: TORDateBox;
    edOther3: TEdit;
    lbOther3: TLabel;
    dtOther4: TORDateBox;
    edOther4: TEdit;
    lbOther4: TLabel;
    edLabelOther1: TEdit;
    edLabelOther2: TEdit;
    edLabelOther3: TEdit;
    edLabelOther4: TEdit;
    procedure bbtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgImmunizations: TdlgImmunizations;

implementation

{$R *.dfm}

procedure TdlgImmunizations.FormCreate(Sender: TObject);
begin
   SayOnFocus(edTDAP, 'T D A P or T D');
   SayOnFocus( edMMR, 'M M R');
end;

procedure TdlgImmunizations.bbtnOKClick(Sender: TObject);
begin
  if dtTDAP.Text <> '' then
  begin
    TmpStrList.Add('  ' + lbTDAP.Caption + ' approx. date: ' + dtTDAP.Text);
    if edTDAP.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edTDAP.Text);
  end;
  if dtInfluenza.Text <> '' then
  begin
    TmpStrList.Add('  ' + lbInfluenza.Caption + ' approx. date: ' + dtInfluenza.Text);
    if edInfluenza.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edInfluenza.Text);
  end;
  if dtMMR.Text <> '' then
  begin
    TmpStrList.Add('  ' + lbMMR.Caption + ' approx. date: ' + dtMMR.Text);
    if edMMR.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edMMR.Text);
  end;
  if dtVaricella.Text <> '' then
  begin
    TmpStrList.Add('  ' + lbVaricella.Caption + ' approx. date: ' + dtVaricella.Text);
    if edVaricella.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edVaricella.Text);
  end;

  if ((Trim(edLabelOther1.Text) <> '') and (dtOther1.Text <> '')) then
  begin
    TmpStrList.Add('  ' + edLabelOther1.Text + ' approx. date: ' + dtOther1.Text);
    if edOther1.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edOther1.Text);
  end;
  if ((Trim(edLabelOther2.Text) <> '') and (dtOther2.Text <> '')) then
  begin
    TmpStrList.Add('  ' + edLabelOther2.Text + ' approx. date: ' + dtOther2.Text);
    if edOther2.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edOther2.Text);
  end;
  if ((Trim(edLabelOther3.Text) <> '') and (dtOther3.Text <> '')) then
  begin
    TmpStrList.Add('  ' + edLabelOther3.Text + ' approx. date: ' + dtOther3.Text);
    if edOther3.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edOther3.Text);
  end;
  if ((Trim(edLabelOther4.Text) <> '') and (dtOther4.Text <> '')) then
  begin
    TmpStrList.Add('  ' + edLabelOther4.Text + ' approx. date: ' + dtOther4.Text);
    if edOther4.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edOther4.Text);
  end;

  if TmpStrList.Count > 0 then
  TmpStrList.Insert(0, 'Immunization History:');
end;

end.
