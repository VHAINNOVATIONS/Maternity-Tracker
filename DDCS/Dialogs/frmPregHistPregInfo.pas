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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, ORDtTm, ORCtrls;

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
    spnLaborLength: TSpinEdit;
    meDeliveryNotes: TCaptionMemo;
    dtDelivery: TORDateBox;
    cbAnesthesia: TComboBox;
    cbDeliveryPlace: TComboBox;
    lbStatus: TStaticText;
    pnlBirthCount: TPanel;
    spnBirthCount: TSpinEdit;
    rgPretermDelivery: TRadioGroup;
    lbBirthCount: TLabel;
    rgTypeDelivery: TRadioGroup;
    Panel1: TPanel;
    edtDeliveryAt: TSpinEdit;
    Panel2: TPanel;
    spnGAWeeks: TSpinEdit;
    Panel3: TPanel;
    spnGADays: TSpinEdit;
    procedure SpinCheck(Sender: TObject);
    procedure spnBabyCountChange(Sender: TObject);
    procedure rgPretermDeliveryClick(Sender: TObject);
    procedure spnGADaysChange(Sender: TObject);
  private
    FDisable: Boolean;
    procedure SetDisable(const Value: Boolean);
  public
    ChildCount: Integer;
    constructor Create(AOwner: TComponent); override;
    procedure GetText(var oText: TStringList);
    property Disable: Boolean read FDisable write SetDisable default False;
  end;

implementation

{$R *.dfm}

uses
  udlgPregHist, frmPregHistChild, uCommon, uReportItems;

procedure TfPregInfo.SpinCheck(Sender: TObject);
begin
  if TSpinEdit(Sender).Value < 0 then
  begin
    TSpinEdit(Sender).Value := 0;
    Exit;
  end;
end;

procedure TfPregInfo.spnBabyCountChange(Sender: TObject);
var
  vTabSheet: TTabSheet;
  vPregBaby: TfChild;
begin
  if spnBirthCount.Value < 0 then
  begin
    spnBirthCount.Value := 0;
    Exit;
  end;

  if spnBirthCount.Value < ChildCount then
  begin
    spnBirthCount.OnChange := nil;
    spnBirthCount.Value := spnBirthCount.Value + 1;
    spnBirthCount.OnChange := spnBabyCountChange;
    ShowMsg('Use the "X" button on the child you wish to remove.', smiWarning, smbOK);
  end else
  begin
    Inc(ChildCount);

    if Owner <> nil then
      if Owner is TTabSheet then
      begin
        vTabSheet := TTabSheet.Create(TTabSheet(Owner).PageControl);
        vTabSheet.PageControl := TTabSheet(Owner).PageControl;
        vTabSheet.Caption := 'Baby #' + IntToStr(vTabSheet.TabIndex);

        vPregBaby := TfChild.Create(vTabSheet);
        vPregBaby.Parent := vTabSheet;
        vPregBaby.Align := alClient;
        vPregBaby.Show;
        TTabSheet(Owner).PageControl.OnChange(nil);
      end;
  end;
end;

procedure TfPregInfo.rgPretermDeliveryClick(Sender: TObject);

  function GetRg: string;
  begin
    if rgPretermDelivery.ItemIndex = 0 then
      Result := 'Full Term'
    else
      Result := 'Preterm';
  end;

begin
  if ((cbOutcome.Enabled) and (cbOutcome.Text <> 'Stillbirth')) then
  begin
    if cbOutcome.Items.IndexOf(GetRg) = -1 then
      cbOutcome.Items.Add(GetRg);

    cbOutcome.ItemIndex := cbOutcome.Items.IndexOf(GetRg);
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

// Private ---------------------------------------------------------------------

procedure TfPregInfo.SetDisable(const Value: Boolean);
var
  I: Integer;
begin
  if Value then
  begin
    for I := 0 to ComponentCount - 1 do
    begin
      if ((Components[I] is TWinControl) and (Components[I] <> lbStatus)) then
        TWinControl(Components[I]).Enabled := False
      else if Components[I] is TLabel then
        TLabel(Components[I]).Enabled := False;
    end;
  end else
  begin
    for I := 0 to ComponentCount - 1 do
    begin
      if ((Components[I] is TWinControl) and (Components[I] <> lbStatus)) then
        TWinControl(Components[I]).Enabled := True
      else if Components[I] is TLabel then
        TLabel(Components[I]).Enabled := True;
    end;
  end;
end;

// Public ----------------------------------------------------------------------

constructor TfPregInfo.Create(AOwner: TComponent);
var
  nItem: TDDCSNoteItem;
begin
  inherited;

  ChildCount := 0;

  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnLaborLength);
  if nItem <> nil then
    nItem.SayOnFocus := 'Length of Labor in hours';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(edtDeliveryAt);
  if nItem <> nil then
    nItem.SayOnFocus := 'Days in Hospital following Delivery';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnGAWeeks);
  if nItem <> nil then
    nItem.SayOnFocus := 'Gestational age in weeks';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnGADays);
  if nItem <> nil then
    nItem.SayOnFocus := 'Gestational age in days';
end;

procedure TfPregInfo.GetText(var oText: TStringList);
var
  I: Integer;
begin
  oText.Clear;

  oText.Add(' Delivery Details:');

  if lbStatus.Caption <> '' then
    oText.Add('  Complication: ' + lbStatus.Caption);

  oText.Add('  Delivery Date: ' + dtDelivery.Text);

  if cbOutcome.ItemIndex <> -1 then
    oText.Add('  Outcome: ' + cbOutcome.Items[cbOutcome.ItemIndex]);

  oText.Add('  Length of Labor: ' + spnLaborLength.Text + ' hrs');

  if rgTypeDelivery.ItemIndex = 0 then
    oText.Add('  Type of Delivery: Vaginal')
  else if rgTypeDelivery.ItemIndex = 1 then
    oText.Add('  Type of Delivery: Cesarean');

  if rgPretermDelivery.ItemIndex = 0 then
    oText.Add('  Preterm Labor: No')
  else if rgPretermDelivery.ItemIndex = 1 then
    oText.Add('  Preterm Labor: Yes');

  oText.Add('  Gestational Age: ' + spnGAWeeks.Text + ' Weeks ' + spnGADays.Text + ' Days');

  oText.Add('  Days in Hospital following Delivery: '+ edtDeliveryAt.text);

  if cbAnesthesia.ItemIndex <> -1 then
    oText.Add('  Anesthesia: ' + cbAnesthesia.Text);

  if Trim(cbDeliveryPlace.Text) <> '' then
    oText.Add('  Place of Delivery: ' + Trim(cbDeliveryPlace.Text));

  if meDeliveryNotes.Lines.Count > 0 then
  begin
    oText.Add('  Delivery Notes: ');
    for I := 0 to meDeliveryNotes.Lines.Count - 1 do
      oText.Add('   ' + meDeliveryNotes.Lines[I]);
  end;
end;

end.
