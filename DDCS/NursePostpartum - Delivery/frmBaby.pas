unit frmBaby;

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
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.ConvUtils, System.StdConvs, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.ComCtrls, ORCtrls;

type
  TfChild = class(TFrame)
    edAPGARone: TEdit;
    meComplications: TCaptionMemo;
    ckNICU: TCheckBox;
    edAPGARfive: TEdit;
    lbAPGAR: TLabel;
    rgSex: TRadioGroup;
    lbComplications: TLabel;
    Panel1: TPanel;
    lbOz: TLabel;
    lbLbs: TLabel;
    lbTotalWeight: TLabel;
    lbG: TLabel;
    spnLb: TSpinEdit;
    spnOz: TSpinEdit;
    spnG: TSpinEdit;
    procedure spnLbChange(Sender: TObject);
    procedure spnOzChange(Sender: TObject);
    procedure UpdateLbOz(Sender: TObject);
  private
    FBabyIEN: string;
    FBabyNumber: string;
    procedure OnChangeNil;
    procedure OnChangeRestore;
    procedure UpdateGrams;
    procedure SetBabyNumber(const Value: string);
    function GetBabyIEN: string;
    function GetBabyNumber: string;
  public
    IEN: string;
    constructor Create(AOwner: TComponent); override;
    procedure UpdateBirthWeightGrams(Value: string);
    procedure GetText(var oText: TStringList);
    function GetV: string;
    property BabyIEN: string read GetBabyIEN write FBabyIEN;
    property BabyNumber: string read GetBabyNumber write SetBabyNumber;
  end;

implementation

{$R *.dfm}

uses
  frmMain, uBase, uReportItems;

procedure TfChild.spnLbChange(Sender: TObject);
begin
  OnChangeNil;

  if spnLb.Value < 0 then
    spnLb.Value := 0;

  UpdateGrams;

  OnChangeRestore;
end;

procedure TfChild.spnOzChange(Sender: TObject);
var
  lb: double;
begin
  OnChangeNil;

  if spnOz.Value < 0 then
    spnOz.Value := 0;

  lb := Convert(spnOz.Value, muOunces, muPounds);
  if lb >= 1 then
  begin
    spnLb.Value := spnLb.Value + Trunc(lb);
    spnOz.Value := 0;
  end;

  UpdateGrams;

  OnChangeRestore;
end;

procedure TfChild.UpdateLbOz(Sender: TObject);
var
  lb: double;
begin
  OnChangeNil;

  if spnG.Value < 0 then
    spnG.Value := 0;

  lb := Convert(spnG.Value, muGrams, muPounds);
  if lb >= 1 then
  begin
    spnLb.Value := Trunc(lb);
    spnOz.Value := Trunc(Convert(lb - Trunc(lb), muPounds, muOunces));
  end else
  begin
    spnLb.Value := 0;
    spnOz.Value := Trunc(Convert(spnG.Value, muGrams, muOunces));
  end;

  OnChangeRestore;
end;

// Private ---------------------------------------------------------------------

procedure TfChild.OnChangeNil;
begin
  spnLb.OnChange := nil;
  spnOz.OnChange := nil;
  spnG.OnChange := nil;
end;

procedure TfChild.OnChangeRestore;
begin
  spnLb.OnChange := spnLbChange;
  spnOz.OnChange := spnOzChange;
  spnG.OnChange := UpdateLbOz;
end;

procedure TfChild.UpdateGrams;
var
  lbs,ozs: double;
begin
  OnChangeNil;

  lbs := Convert(spnLb.Value, muPounds, muGrams);
  ozs := Convert(spnOz.Value, muOunces, muGrams);
  spnG.Value := Trunc(lbs + ozs);

  OnChangeRestore;
end;

procedure TfChild.SetBabyNumber(const Value: string);
begin
  FBabyNumber := Value;
end;

function TfChild.GetBabyIEN: string;
begin
  if StrToIntDef(FBabyIEN, 0) < 1 then
    FBabyIEN := '+';

  Result := FBabyIEN;
end;

function TfChild.GetBabyNumber: string;
begin
  if FBabyNumber <> '' then
  begin
    Result := FBabyNumber;
    Exit;
  end;

  if Owner <> nil then
    if Owner is TTabSheet then
      Result := IntToStr(TTabSheet(Owner).TabIndex);
end;

// Public ----------------------------------------------------------------------

constructor TfChild.Create(AOwner: TComponent);
var
  nItem: TDDCSNoteItem;
begin
  inherited;

  nItem := Form1.DDCSForm1.ReportCollection.GetNoteItemAddifNil(spnLb);
  if nItem <> nil then
    nItem.SayOnFocus := 'Birth Weight in pounds';
  nItem := Form1.DDCSForm1.ReportCollection.GetNoteItemAddifNil(spnOz);
  if nItem <> nil then
    nItem.SayOnFocus := 'Birth Weight in ounces';
  nItem := Form1.DDCSForm1.ReportCollection.GetNoteItemAddifNil(spnG);
  if nItem <> nil then
    nItem.SayOnFocus := 'Total Birth Weight in grams';
  nItem := Form1.DDCSForm1.ReportCollection.GetNoteItemAddifNil(edAPGARone);
  if nItem <> nil then
    nItem.SayOnFocus := 'A P G A R Score one minute after birth';
  nItem := Form1.DDCSForm1.ReportCollection.GetNoteItemAddifNil(edAPGARfive);
  if nItem <> nil then
    nItem.SayOnFocus := 'A P G A R Score five minutes after birth';
end;

procedure TfChild.UpdateBirthWeightGrams(Value: string);
var
  iVal: Integer;
begin
  if ((Value <> '') and (TryStrToInt(Value, iVal))) then
  begin
    if iVal < 0 then
      Exit;

    spnG.Value := iVal;
  end;
end;

procedure TfChild.GetText(var oText: TStringList);
var
  I: Integer;
begin
  oText.Clear;

  if rgSex.ItemIndex <> -1 then
    oText.Add('   Gender: ' + TRadioButton(rgSex.Controls[rgSex.ItemIndex]).Caption)
  else
    oText.Add('   Gender: Unknown');

  if Trim(edAPGARone.Text) <> '' then
    oText.Add('   APGAR Score (one minute): ' + edAPGARone.Text)
  else
    oText.Add('   APGAR Score (one minute): Unknown');
  if Trim(edAPGARfive.Text) <> '' then
    oText.Add('   APGAR Score (five minute): ' + edAPGARfive.Text)
  else
    oText.Add('   APGAR Score (five minute): Unknown');

  if ckNICU.Checked then
    oText.Add('   NICU Admission: Yes')
  else
    oText.Add('   NICU Admission: No');

  if spnG.Text <> '0' then
    oText.Add('   Birth Weight: ' + spnG.Text + 'g')
  else
    oText.Add('   Birth Weight: Unknown');

  if meComplications.Lines.Count > 0 then
  begin
    oText.Add('   Complications: ');

    for I := 0 to meComplications.Lines.Count - 1 do
      oText.Add('    ' + meComplications.Lines[I]);
  end;
end;

function TfChild.GetV: string;

  function GetSex: string;
  begin
    case rgSex.ItemIndex of
      0: Result := 'M';
      1: Result := 'F';
      2: Result := 'U';
    end;
  end;

  function GetNICU: string;
  begin
    if ckNICU.Checked then
      Result := '1'
    else
      Result := '0';
  end;

begin
  // IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
  Result := BabyIEN + ';' + BabyNumber + ';;' + GetSex + ';' + spnG.Text + ';;'
            + edAPGARone.Text + ';' + edAPGARfive.Text + ';;' + GetNICU + '|';
end;

end.
