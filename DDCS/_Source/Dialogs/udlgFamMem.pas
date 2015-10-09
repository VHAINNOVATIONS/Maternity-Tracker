unit udlgFamMem;

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
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, oCNTBase, uExtndComBroker;

type
  TdlgFamMem = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    lblInstructions: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label1: TLabel;
    cobfammem: TComboBox;
    cblive: TCheckBox;
    cbdead: TCheckBox;
    cobdx: TComboBox;
    Label2: TLabel;
    leddate: TLabeledEdit;
    ledcomments: TLabeledEdit;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbliveClick(Sender: TObject);
    procedure cbdeadClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgFamMem: TdlgFamMem;

implementation

uses
   udlgDATE;

{$R *.dfm}

procedure TdlgFamMem.bbtnOKClick(Sender: TObject);
var
  I: Integer;
{ User pressed OK. }
begin
{precheck fam member}
  if cobfammem.Text = '' then
    begin
     MessageDlg('You must enter a family member.',mtinformation,[mbok],0);
     ModalResult := mrnone;
     exit;
    end;
{create TmpStrList}
  TmpStrList.Add(cobfammem.Text);
  if cblive.Checked = True  then TmpStrList.Add('  ' + cblive.Caption);
  if cbdead.Checked = True  then TmpStrList.Add('  ' + cbdead.Caption);

  for I := 0 to ListBox1.Count - 1 do
  TmpStrList.Add('  Diagnosis: ' + ListBox1.Items[I]);

  if leddate.Text     <> '' then TmpStrList.Add('  Date: ' + leddate.Text);
  if ledcomments.Text <> ''  then TmpStrList.Add('Comments: ' + ledcomments.Text)
end;

procedure TdlgFamMem.cbliveClick(Sender: TObject);
{living}
begin
   if cblive.Checked = True then
     cbdead.Visible := False
   else
     cbdead.Visible := True;  
end;

procedure TdlgFamMem.Button1Click(Sender: TObject);
begin
  if cobdx.Text = '' then Exit;

  if ListBox1.Items.IndexOf(cobdx.Text) = -1 then
  ListBox1.Items.Add(cobdx.Text);
end;

procedure TdlgFamMem.Button2Click(Sender: TObject);
begin
  if ListBox1.ItemIndex = -1 then Exit;

  ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TdlgFamMem.cbdeadClick(Sender: TObject);
{deceased}
begin
  if cbdead.Checked = True then
    cblive.Visible := False
  else
    cblive.Visible := True;
end;

procedure TdlgFamMem.SpeedButton2Click(Sender: TObject);
var
  TmpForm : TdlgDate;
begin
  try
    TmpForm := TdlgDate.Create( Nil );
    TmpForm.ShowModal;
    if TmpForm.ModalResult = mrOK then
     begin
      if(TmpForm.calMonth.Date) >  Now then
        showmessage('No future dates')
      else
        leddate.Text := DateToStr(TmpForm.calMonth.Date);

    end;
  finally
    TmpForm.Free;
  end;
end;

end.
