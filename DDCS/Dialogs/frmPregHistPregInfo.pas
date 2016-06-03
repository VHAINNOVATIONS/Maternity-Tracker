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
    rgTypeDelivery: TRadioGroup;
    procedure SpinCheck(Sender: TObject);
    procedure spnBabyCountChange(Sender: TObject);
    procedure rgPretermDeliveryClick(Sender: TObject);
    procedure spnGADaysChange(Sender: TObject);
  private
  public
    ChildCount: Integer;
    MultiBirth: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetText: TStringList;
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

    if ((ChildCount > 1) and not (MultiBirth)) then
    begin
      MultiBirth := True;
      dlgPregHist.ModifyMultiBirth(1);
    end;

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
      end;
  end;
end;

procedure TfPregInfo.rgPretermDeliveryClick(Sender: TObject);

  procedure UpdateOutCome;

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

begin
  if Sender = nil then
  begin
    UpdateOutCome;
    Exit;
  end;

  if rgPretermDelivery.ItemIndex = 0 then
  begin
    dlgPregHist.ModifyFullTerm(1);
    dlgPregHist.ModifyPreterm(-1);
  end else if rgPretermDelivery.ItemIndex = 1 then
  begin
    dlgPregHist.ModifyFullTerm(-1);
    dlgPregHist.ModifyPreterm(1);
  end;

  UpdateOutCome;
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
var
  nItem: TDDCSNoteItem;
begin
  inherited;

  ChildCount := 0;
  dlgPregHist.ModifyFullTerm(1);
  MultiBirth := False;

//  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnLb);
//  if nItem <> nil then
//    nItem.SayOnFocus := 'Birth Weight in pounds';
end;

destructor TfPregInfo.Destroy;
begin
  if rgPretermDelivery.ItemIndex = 0 then
    dlgPregHist.ModifyFullTerm(-1)
  else if  rgPretermDelivery.ItemIndex = 1 then
    dlgPregHist.ModifyPreterm(-1);

  inherited;
end;

function TfPregInfo.GetText: TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;

  Result.Add(' Delivery Details:');

  if lbStatus.Caption <> '' then
    Result.Add('  Complication: ' + lbStatus.Caption);

  Result.Add('  Delivery Date: ' + dtDelivery.Text);

  if cbOutcome.ItemIndex <> -1 then
    Result.Add('  Outcome: ' + cbOutcome.Items[cbOutcome.ItemIndex]);

  Result.Add('  Length of Labor: ' + spnLaborLength.Text + ' hrs');

  if rgTypeDelivery.ItemIndex = 0 then
    Result.Add('  Type of Delivery: Vaginal')
  else if rgTypeDelivery.ItemIndex = 1 then
    Result.Add('  Type of Delivery: Cesarean');

  if rgPretermDelivery.ItemIndex = 0 then
    Result.Add('  Preterm Labor: No')
  else if rgPretermDelivery.ItemIndex = 1 then
    Result.Add('  Preterm Labor: Yes');

  Result.Add('  Gestational Age: ' + spnGAWeeks.Text + ' Weeks ' + spnGADays.Text + ' Days');

  Result.Add('  Days in Hospital following Delivery: '+ edtDeliveryAt.text);

  if cbAnesthesia.ItemIndex <> -1 then
    Result.Add('  Anesthesia: ' + cbAnesthesia.Text);

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
