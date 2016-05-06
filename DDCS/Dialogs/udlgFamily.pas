unit udlgFamily;

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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Vcl.Samples.Spin, Vcl.ComCtrls, system.StrUtils,
  uDialog, uCommon, uExtndComBroker, VA508AccessibilityManager;

type
  TdlgFamily = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    btnDAdd: TButton;
    btnDDelete: TButton;
    ListBox: TListBox;
    ledcomments: TLabeledEdit;
    leddatebirth: TLabeledEdit;
    cobdx: TComboBox;
    cbdead: TCheckBox;
    cblive: TCheckBox;
    cobfammem: TComboBox;
    spDateSelect: TSpeedButton;
    Label2: TLabel;
    Label1: TLabel;
    spnEducation: TSpinEdit;
    lblEducation: TStaticText;
    edtAddr1: TLabeledEdit;
    edtAddr2: TLabeledEdit;
    edtAddr3: TLabeledEdit;
    edtAddrcity: TLabeledEdit;
    edtAddrzip: TLabeledEdit;
    edtPhoneH: TLabeledEdit;
    edtPhoneC: TLabeledEdit;
    edtPhoneW: TLabeledEdit;
    cbAddrstate: TComboBox;
    Label3: TLabel;
    lvPersonList: TListView;
    cbName: TComboBox;
    lblName: TStaticText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    amgrMain: TVA508AccessibilityManager;
    procedure bbtnOKClick(Sender: TObject);
    procedure btnDAddClick(Sender: TObject);
    procedure btnDDeleteClick(Sender: TObject);
    procedure spDateSelectClick(Sender: TObject);
    procedure ToggleCB(Sender: TObject);
    procedure spnEducationChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbNameChange(Sender: TObject);
    procedure UpdateField(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cbNameSelect(Sender: TObject);
  private
    Item: TListItem;
    ISelected: Integer;
    procedure ClearForm;
    procedure UpdateDiagnosis;
  public
  end;

var
  dlgFamily: TdlgFamily;

implementation

uses
   udlgDATE, fFamilyAdd;

{$R *.dfm}

procedure TdlgFamily.FormShow(Sender: TObject);
var
  I,J: Integer;
begin
  ClearForm;
  cbName.Clear;

  for I := 0 to lvPersonList.Items.Count - 1 do
  begin
    for J := lvPersonList.Items.Item[I].SubItems.Count - 1 to 19 do
      lvPersonList.Items.Item[I].SubItems.Add('');

    if not AnsiContainsText(lvPersonList.Items.Item[I].Caption,'-') then
      cbName.Items.Add(lvPersonList.Items[I].SubItems[0]);
  end;
end;

procedure TdlgFamily.ClearForm;
begin
  Item := nil; ISelected := -1;

  cobfammem.Text := '';
  cblive.OnClick := nil;
  cbdead.OnClick := nil;
  cblive.Checked := False;
  cbdead.Checked := False;
  cblive.OnClick := ToggleCB;
  cbdead.OnClick := ToggleCB;
  cobdx.Text := '';
  ListBox.Clear;
  ledcomments.Text := '';
  leddatebirth.Text := '';
  spnEducation.Value := 0;
  edtAddr1.Text := '';
  edtAddr2.Text := '';
  edtAddr3.Text := '';
  edtAddrcity.Text := '';
  cbAddrstate.Text := '';
  edtAddrzip.Text := '';
  edtPhoneH.Text := '';
  edtPhoneC.Text := '';
  edtPhoneW.Text := '';
end;

procedure TdlgFamily.UpdateField(Sender: TObject);
begin
  if Item = nil then
    Exit;

  case TWinControl(Sender).Tag of
   0: ;
   1: ;
   2: Item.SubItems[2]  := leddatebirth.Text;
   3: Item.SubItems[3]  := spnEducation.Text;
   4: Item.SubItems[4]  := edtAddr1.Text;
   5: Item.SubItems[5]  := edtAddr2.Text;
   6: Item.SubItems[6]  := edtAddr3.Text;
   7: Item.SubItems[7]  := edtAddrcity.Text;
   8: begin
        if cbAddrstate.ItemIndex <> -1 then
          Item.SubItems[8]  := cbAddrstate.Items[cbAddrstate.ItemIndex];
      end;
   9: Item.SubItems[9]  := edtAddrzip.Text;
  10: Item.SubItems[10] := edtPhoneH.Text;
  11: Item.SubItems[11] := edtPhoneW.Text;
  12: Item.SubItems[12] := edtPhoneC.Text;
  13: ;
  14: ;
  15: ;
  16: Item.SubItems[16] := cobfammem.Text;
  17: Item.SubItems[17] := TCheckBox(Sender).Caption;
  18: ;
  19: Item.SubItems[19] := ledcomments.Text;
  end;
end;

procedure TdlgFamily.UpdateDiagnosis;
var
  I: Integer;
begin
  if Item = nil then
    Exit;

  Item.SubItems[18] := '';
  for I := 0 to ListBox.Items.Count - 1 do
  begin
    if I > 0 then
      Item.SubItems[18] := Item.SubItems[18] + '|' + ListBox.Items[I]
    else
      Item.SubItems[18] := ListBox.Items[I];
  end;
end;

procedure TdlgFamily.cbNameChange(Sender: TObject);
begin
  if Item <> nil then
  begin
    Item.SubItems[0] := cbName.Text;
    cbName.Items[ISelected] := cbName.Text;
  end;
end;

procedure TdlgFamily.cbNameSelect(Sender: TObject);
var
  I,sNbr,J: Integer;
  sl: TStringList;

  // IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^ZIP^PHONE HOME^
  // PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^DFN^RELATIONSHIP^STATUS^DIAGNOSIS^COMMENTS

begin
  ClearForm;
  ISelected := cbName.ItemIndex;

  for I := 0 to lvPersonList.Items.Count - 1 do
  begin
    if lvPersonList.Items[I].SubItems[0] = cbName.Text then
    begin
      Item := lvPersonList.Items[I];

      cobfammem.Text := Item.SubItems[16];

      if UpperCase(Item.SubItems[17]) = 'LIVING' then
        cblive.Checked := True
      else if UpperCase(Item.SubItems[17]) = 'DECEASED' then
        cbdead.Checked := True;

      leddatebirth.Text := Item.SubItems[2];

      if ((Item.SubItems[3] <> '') and (TryStrToInt(Item.SubItems[3],sNbr))) then
        spnEducation.Value := sNbr;

      edtAddr1.Text := Item.SubItems[4];
      edtAddr2.Text := Item.SubItems[5];
      edtAddr3.Text := Item.SubItems[6];
      edtAddrcity.Text := Item.SubItems[7];
      cbAddrstate.Text := Item.SubItems[8];

      if ((Item.SubItems[9] <> '') and (TryStrToInt(Item.SubItems[9],sNbr))) then
        edtAddrzip.Text := Item.SubItems[9];

      edtPhoneH.Text := Item.SubItems[10];
      edtPhoneW.Text := Item.SubItems[11];
      edtPhoneC.Text := Item.SubItems[12];

      sl := TStringList.Create;
      try
        sl.Delimiter := '|'; sl.StrictDelimiter := True;
        sl.DelimitedText := Item.SubItems[18];
        for J := 0 to sl.Count - 1 do
          ListBox.Items.Add(sl[J]);
      finally
        sl.Free;
      end;

      ledcomments.Text := Item.SubItems[19];

      Break;
    end;
  end;
end;

Procedure TdlgFamily.ToggleCB(Sender: TObject);
begin
  if not (Sender is TCheckBox)then
    Exit;

  if ((TCheckBox(Sender).Name = 'cblive') and (TCheckBox(Sender).Checked)) then
    cbdead.Checked := False;

  if ((TCheckBox(Sender).Name = 'cbdead') and (TCheckBox(Sender).Checked)) then
    cblive.Checked := False;

  UpdateField(Sender);
end;

procedure TdlgFamily.BitBtn1Click(Sender: TObject);
var
  lvitem: TListItem;
  I: Integer;
begin
  frmFamilyAdd := TfrmFamilyAdd.Create(Self);
  try
    frmFamilyAdd.ShowModal;
    if frmFamilyAdd.ModalResult = mrOk then
    begin
      lvitem := lvPersonList.Items.Add;
      lvitem.Caption := '+';
      lvitem.SubItems.Add(frmFamilyAdd.LabeledEdit1.Text);

      FormShow(Sender);

      cbName.ItemIndex := cbName.Items.IndexOf(frmFamilyAdd.LabeledEdit1.Text);
      cbNameSelect(Sender);
    end;
  finally
    frmFamilyAdd.Free;
  end;
end;

procedure TdlgFamily.BitBtn2Click(Sender: TObject);
begin
  if MessageDlg('Do you really want to DELETE "' + cbName.Text + '"?',mtWarning,mbYesNoCancel,0) = mrYes then
  begin
    Item.Caption := Item.Caption + '-';

    FormShow(Sender);
  end;
end;

procedure TdlgFamily.btnDAddClick(Sender: TObject);
begin
  if cobdx.Text = '' then
    Exit;

  if ListBox.Items.IndexOf(cobdx.Text) = -1 then
    ListBox.Items.Add(cobdx.Text);

  UpdateDiagnosis;
end;

procedure TdlgFamily.btnDDeleteClick(Sender: TObject);
begin
  if ListBox.ItemIndex = -1 then
    Exit;

  ListBox.Items.Delete(ListBox.ItemIndex);
  UpdateDiagnosis;
end;

procedure TdlgFamily.bbtnOKClick(Sender: TObject);
var
  I,J: Integer;
  val: string;

  // IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^ZIP^PHONE HOME^
  // PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^DFN^RELATIONSHIP^STATUS^DIAGNOSIS^COMMENTS

begin
  if lvPersonList.Items.Count < 1 then
    Exit;

  TmpStrList.Add('Family History:');
  for I := 0 to lvPersonList.Items.Count - 1 do
  begin
    if not AnsiContainsText(lvPersonList.Items.Item[I].Caption,'-') then
    begin
      TmpStrList.Add('  Name: ' + lvPersonList.Items.Item[I].SubItems[0]);
//      TmpStrList.Add('   Date of Birth: ' + lvPersonList.Items.Item[I].SubItems[2]);
      TmpStrList.Add('   Status: ' + lvPersonList.Items.Item[I].SubItems[17]);
      TmpStrList.Add('   Relationship: ' + lvPersonList.Items.Item[I].SubItems[16]);
//      TmpStrList.Add('   Years of Education: ' + lvPersonList.Items.Item[I].SubItems[3]);

      val := lvPersonList.Items.Item[I].SubItems[18];
      if val <> '' then
      begin
        TmpStrList.Add('   Diagnosis:');
        for J := 1 to SubCount(val,'|') + 1 do
          TmpStrList.Add('    ' + Piece(val,'|',J));
      end;

//      TmpStrList.Add('   Street Address 1: ' + lvPersonList.Items.Item[I].SubItems[4]);
//      TmpStrList.Add('   Street Address 2: ' + lvPersonList.Items.Item[I].SubItems[5]);
//      TmpStrList.Add('   Street Address 3: ' + lvPersonList.Items.Item[I].SubItems[6]);
//      TmpStrList.Add('   City: ' + lvPersonList.Items.Item[I].SubItems[7]);
//      TmpStrList.Add('   State: ' + lvPersonList.Items.Item[I].SubItems[8]);
//      TmpStrList.Add('   Zip: ' + lvPersonList.Items.Item[I].SubItems[9]);
//
//      TmpStrList.Add('   Phone (Home): ' + lvPersonList.Items.Item[I].SubItems[10]);
//      TmpStrList.Add('   Phone (Cell): ' + lvPersonList.Items.Item[I].SubItems[11]);
//      TmpStrList.Add('   Phone (Work): ' + lvPersonList.Items.Item[I].SubItems[12]);

      TmpStrList.Add('   Comments: ' + lvPersonList.Items.Item[I].SubItems[19]);
    end;
  end;
end;

procedure TdlgFamily.spDateSelectClick(Sender: TObject);
var
  TmpForm: TdlgDate;
begin
  TmpForm := TdlgDate.Create(nil);
  try
    TmpForm.ShowModal;
    if TmpForm.ModalResult = mrOK then
    begin
      if(TmpForm.calMonth.Date) >  Now then
        showmessage('No future dates')
      else
        leddatebirth.Text := DateToStr(TmpForm.calMonth.Date);
    end;
  finally
    TmpForm.Free;
  end;
end;

procedure TdlgFamily.spnEducationChange(Sender: TObject);
begin
  if spnEducation.Value < 0 then
    spnEducation.Value := 0;

  UpdateField(Sender);
end;

end.
