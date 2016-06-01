unit frmPregHistChild;

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
  System.Classes, System.ConvUtils, System.StdConvs, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Buttons, ORCtrls;

type
  TfChild = class(TFrame)
    meComplications: TCaptionMemo;
    rgSex: TRadioGroup;
    spnLb: TSpinEdit;
    edAPGARfive: TEdit;
    spnG: TSpinEdit;
    rgLife: TRadioGroup;
    ckNICU: TCheckBox;
    spnOz: TSpinEdit;
    edAPGARone: TEdit;
    lbG: TLabel;
    lbTotalWeight: TLabel;
    lbComplications: TLabel;
    lbLbs: TLabel;
    lbAPGAR: TLabel;
    lbOz: TLabel;
    btnDelete: TBitBtn;
    procedure spnLbChange(Sender: TObject);
    procedure spnOzChange(Sender: TObject);
    procedure UpdateLbOz(Sender: TObject);
    procedure rgLifeClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    procedure OnChangeNil;
    procedure OnChangeRestore;
    procedure UpdateGrams;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetText: TStringList;
  end;

implementation

{$R *.dfm}

uses
  udlgPregHist, frmPregHistPreg, uReportItems;

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

procedure TfChild.rgLifeClick(Sender: TObject);
begin
  if rgLife.ItemIndex = 0 then
    dlgPregHist.ModifyLiving(1)
  else if rgLife.ItemIndex = 1 then
    dlgPregHist.ModifyLiving(-1);
end;

procedure TfChild.btnDeleteClick(Sender: TObject);
begin
  if Owner <> nil then
    if Owner is TTabSheet then
      if TTabSheet(Owner).PageControl.Owner is TfPreg then
        TfPreg(TTabSheet(Owner).PageControl.Owner).DeleteChild(TTabSheet(Owner));
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

// Public ----------------------------------------------------------------------

constructor TfChild.Create(AOwner: TComponent);
var
  nItem: TDDCSNoteItem;
begin
  inherited;

  dlgPregHist.ModifyLiving(1);

  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnLb);
  if nItem <> nil then
    nItem.SayOnFocus := 'Birth Weight in pounds';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnOz);
  if nItem <> nil then
    nItem.SayOnFocus := 'Birth Weight in ounces';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(spnG);
  if nItem <> nil then
    nItem.SayOnFocus := 'Total Birth Weight in grams';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(edAPGARone);
  if nItem <> nil then
    nItem.SayOnFocus := 'A P G A R Score one minute after birth';
  nItem := dlgPregHist.ReportCollection.GetNoteItemAddifNil(edAPGARfive);
  if nItem <> nil then
    nItem.SayOnFocus := 'A P G A R Score five minutes after birth';
end;

destructor TfChild.Destroy;
begin
  if rgLife.ItemIndex = 0 then
    dlgPregHist.ModifyLiving(-1);

  inherited;
end;

function TfChild.GetText: TStringList;
var
  BabyNumber,I: Integer;
begin
  Result := TStringList.Create;

  BabyNumber := 0;
  if Owner <> nil then
    if Owner is TTabSheet then
      BabyNumber := TTabSheet(Owner).TabIndex;

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
