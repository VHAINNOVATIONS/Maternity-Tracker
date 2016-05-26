unit frmPregHistPregInfo;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, ORDtTm, ORCtrls;

type
  TfPregInfo = class(TFrame)
    lbOutcome: TLabel;
    lbPlaceDelivery: TLabel;
    lbLengthLabor: TLabel;
    lbGestationalAge: TLabel;
    lbGAWeeks: TLabel;
    lbGADays: TLabel;
    lbDateDelivery: TLabel;
    lbComments: TLabel;
    lbAnesthesia: TLabel;
    lbDaysHospital: TLabel;
    cbOutcome: TComboBox;
    spnGAWeeks: TSpinEdit;
    spnGADays: TSpinEdit;
    spnLaborLength: TSpinEdit;
    meDeliveryNotes: TCaptionMemo;
    dtDelivery: TORDateBox;
    cbAnesthesia: TComboBox;
    cbDeliveryPlace: TComboBox;
    lbStatus: TStaticText;
    pnlBirthCount: TPanel;
    spnBirthCount: TSpinEdit;
    rgPretermDelivery: TRadioGroup;
    edtDeliveryAt: TSpinEdit;
    lbBirthCount: TLabel;
    procedure SpinCheck(Sender: TObject);
    procedure rgPretermDeliveryClick(Sender: TObject);
    procedure spnGADaysChange(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetText: TStringList;
  end;

implementation

{$R *.dfm}

uses
  udlgPregHist;

procedure TfPregInfo.SpinCheck(Sender: TObject);
begin
  if TSpinEdit(Sender).Value < 0 then
  begin
    TSpinEdit(Sender).Value := 0;
    Exit;
  end;
end;

procedure TfPregInfo.rgPretermDeliveryClick(Sender: TObject);
begin
  if rgPretermDelivery.ItemIndex = 0 then
  begin
    dlgPregHist.ModifyFullTerm(1);
    dlgPregHist.ModifyPreterm(-1);
  end else if rgPretermDelivery.ItemIndex = 1 then
  begin
    dlgPregHist.ModifyFullTerm(-1);
    dlgPregHist.ModifyPreterm(1);
  end;
end;

procedure TfPregInfo.spnGADaysChange(Sender: TObject);
begin
  if spnGADays.Value < 0 then
  begin
    spnGADays.Value := 0;
    Exit;
  end;

  if spnGADays.Value > 6 then
  begin
    spnGAWeeks.Value := spnGAWeeks.Value + 1;
    spnGADays.Value := 0;
  end;
end;

// Public ----------------------------------------------------------------------

constructor TfPregInfo.Create(AOwner: TComponent);
begin
  inherited;

  dlgPregHist.ModifyFullTerm(1);
end;

destructor TfPregInfo.Destroy;
begin
  if rgPretermDelivery.ItemIndex = 0 then
    dlgPregHist.ModifyFullTerm(-1)
  else if  rgPretermDelivery.ItemIndex = 1 then
    dlgPregHist.ModifyPreterm(-1);

  inherited;
end;

function TfPregInfo.GetText;
var
  I: Integer;
begin
  Result := TStringList.Create;

  Result.Add(' Delivery Details:');

  if lbStatus.Caption <> '' then
    Result.Add('  Complication: ' + lbStatus.Caption);

  Result.Add('  Delivery Date: ' + dtDelivery.Text);
  Result.Add('  Days in Hospital following Delivery: '+ edtDeliveryAt.text);
  Result.Add('  Gestational Age: ' + spnGAWeeks.Text + ' Weeks ' + spnGADays.Text + ' Days');

  if cbAnesthesia.ItemIndex <> -1 then
    Result.Add('  Anesthesia: ' + cbAnesthesia.Text);

  if rgPretermDelivery.ItemIndex = 0 then
    Result.Add('  Preterm Labor: No')
  else if rgPretermDelivery.ItemIndex = 1 then
    Result.Add('  Preterm Labor: Yes');

  Result.Add('  Length of Labor: ' + spnLaborLength.Text + ' hrs');

  if cbOutcome.ItemIndex <> -1 then
    Result.Add('  Outcome: ' + cbOutcome.Items[cbOutcome.ItemIndex]);

  if Trim(cbDeliveryPlace.Text) <> '' then
    Result.Add('  Place of Delivery: ' + Trim(cbDeliveryPlace.Text));

  if meDeliveryNotes.Lines.Count > 0 then
  begin
    Result.Add('  Delivery Notes: ');
    for I := 0 to meDeliveryNotes.Lines.Count - 1 do
      Result.Add('   ' + meDeliveryNotes.Lines[I]);
  end;
end;

end.
