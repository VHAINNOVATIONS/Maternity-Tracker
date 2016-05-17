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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.ConvUtils, System.StdConvs, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin,
  ORCtrls, uBase, uReportItems;

type
  TfrmInner = class(TFrame)
    edAPGARone: TEdit;
    meComplications: TCaptionMemo;
    spnOz: TSpinEdit;
    ckNICU: TCheckBox;
    rgLife: TRadioGroup;
    spnG: TSpinEdit;
    edAPGARfive: TEdit;
    spnLb: TSpinEdit;
    lbOz: TLabel;
    lbAPGAR: TLabel;
    lbLbs: TLabel;
    rgSex: TRadioGroup;
    lbComplications: TLabel;
    lbTotalWeight: TLabel;
    lbG: TLabel;
    procedure spnLbChange(Sender: TObject);
    procedure spnOzChange(Sender: TObject);
    procedure UpdateLbOz(Sender: TObject);
  private
    procedure OnChangeNil;
    procedure OnChangeRestore;
    procedure UpdateGrams;
  public
    BabyNumber: Integer;
    IEN: string;
    constructor Create(AOwner: TComponent); override;
    procedure UpdateBirthWeightGrams(Value: string);
    function GetText: TStringList;
  end;

implementation

{$R *.dfm}

uses
  frmMain;

procedure TfrmInner.spnLbChange(Sender: TObject);
begin
  OnChangeNil;

  if spnLb.Value < 0 then
    spnLb.Value := 0;

  UpdateGrams;

  OnChangeRestore;
end;

procedure TfrmInner.spnOzChange(Sender: TObject);
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

procedure TfrmInner.UpdateLbOz(Sender: TObject);
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

procedure TfrmInner.OnChangeNil;
begin
  spnLb.OnChange := nil;
  spnOz.OnChange := nil;
  spnG.OnChange := nil;
end;

procedure TfrmInner.OnChangeRestore;
begin
  spnLb.OnChange := spnLbChange;
  spnOz.OnChange := spnOzChange;
  spnG.OnChange := UpdateLbOz;
end;

procedure TfrmInner.UpdateGrams;
var
  lbs,ozs: double;
begin
  OnChangeNil;

  lbs := Convert(spnLb.Value, muPounds, muGrams);
  ozs := Convert(spnOz.Value, muOunces, muGrams);
  spnG.Value := Trunc(lbs + ozs);

  OnChangeRestore;
end;

// Public ----------------------------------------------------------------------

constructor TfrmInner.Create(AOwner: TComponent);
var
  I: Integer;
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

procedure TfrmInner.UpdateBirthWeightGrams(Value: string);
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

function TfrmInner.GetText: TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;

  if rgLife.ItemIndex <> -1 then
    Result.Add('  Baby ' + IntTostr(BabyNumber) + ' (' +
               TRadioButton(rgLife.Controls[rgLife.ItemIndex]).Caption + '):')
  else
    Result.Add('  Baby ' + IntTostr(BabyNumber) + ':');

  if rgSex.ItemIndex <> -1 then
    Result.Add('   Gender: ' + TRadioButton(rgSex.Controls[rgSex.ItemIndex]).Caption)
  else
    Result.Add('   Gender: Unknown');

  if Trim(edAPGARone.Text) <> '' then
    Result.Add('   APGAR Score (one minute): ' + edAPGARone.Text)
  else
    Result.Add('   APGAR Score (one minute): Unknown');
  if Trim(edAPGARfive.Text) <> '' then
    Result.Add('   APGAR Score (five minute): ' + edAPGARfive.Text)
  else
    Result.Add('   APGAR Score (five minute): Unknown');

  if ckNICU.Checked then
    Result.Add('   NICU Admission: Yes')
  else
    Result.Add('   NICU Admission: No');

  if spnG.Text <> '0' then
    Result.Add('   Birth Weight: ' + spnG.Text + 'g')
  else
    Result.Add('   Birth Weight: Unknown');

  if meComplications.Lines.Count > 0 then
  begin
    Result.Add('   Complications: ');

    for I := 0 to meComplications.Lines.Count - 1 do
      Result.Add('    ' + meComplications.Lines[I]);
  end;
end;

end.
