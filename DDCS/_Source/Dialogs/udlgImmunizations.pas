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

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uDialog, uExtndComBroker;

type
  TdlgImmunizations = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Edit1: TEdit;
    LabeledEdit6: TLabeledEdit;
    SpeedButton6: TSpeedButton;
    Edit2: TEdit;
    LabeledEdit7: TLabeledEdit;
    SpeedButton7: TSpeedButton;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgImmunizations: TdlgImmunizations;

implementation

uses
   udlgDATE;

{$R *.dfm}

procedure TdlgImmunizations.bbtnOKClick(Sender: TObject);
begin
  if ((Edit1.Text <> '') and (LabeledEdit5.Text = '')) or
     ((Edit2.Text <> '') and (LabeledEdit6.Text = '')) or
     ((Edit3.Text <> '') and (LabeledEdit7.Text = '')) then
  begin
    ShowMessage('An Immunization must be associated with "OTHER" if a date is supplied.');
    Exit;
  end;

  if ((Edit1.Text = '') and (LabeledEdit5.Text <> '')) or
     ((Edit2.Text = '') and (LabeledEdit6.Text <> '')) or
     ((Edit3.Text = '') and (LabeledEdit7.Text <> '')) then
  begin
    ShowMessage('A date must be associated to a supplied "OTHER" immunization.');
    Exit;
  end;

  if LabeledEdit1.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit1.EditLabel.Caption + ' approx. date: ' + LabeledEdit1.Text);
  if LabeledEdit2.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit2.EditLabel.Caption + ' approx. date: ' + LabeledEdit2.Text);
  if LabeledEdit3.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit3.EditLabel.Caption + ' approx. date: ' + LabeledEdit3.Text);
  if LabeledEdit4.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit4.EditLabel.Caption + ' approx. date: ' + LabeledEdit4.Text);
  if Edit1.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit5.Text + ' approx. date: ' + Edit1.Text);
  if Edit2.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit6.Text + ' approx. date: ' + Edit2.Text);
  if Edit3.Text <> '' then
  TmpStrList.Add('  ' + LabeledEdit7.Text + ' approx. date: ' + Edit3.Text);

  if TmpStrList.Count > 0 then
  TmpStrList.Insert(0, 'Immunization History:');
end;

procedure TdlgImmunizations.SpeedButton1Click(Sender: TObject);
var
  TmpForm : TdlgDate;
begin
  try
    TmpForm := TdlgDate.Create(nil);
    TmpForm.ShowModal;
    if TmpForm.ModalResult = mrOK then
     begin
      if(TmpForm.calMonth.Date) >  Now then
      showmessage('No future dates')
      else
      case (Sender as TSpeedButton).Tag of
        1: LabeledEdit1.Text := DateToStr(TmpForm.calMonth.Date);
        2: LabeledEdit2.Text := DateToStr(TmpForm.calMonth.Date);
        3: LabeledEdit3.Text := DateToStr(TmpForm.calMonth.Date);
        4: LabeledEdit4.Text := DateToStr(TmpForm.calMonth.Date);
        5: Edit1.Text := DateToStr(TmpForm.calMonth.Date);
        6: Edit2.Text := DateToStr(TmpForm.calMonth.Date);
        7: Edit3.Text := DateToStr(TmpForm.calMonth.Date);
      end;
    end;
  finally
    TmpForm.Free;
  end;
end;

end.
