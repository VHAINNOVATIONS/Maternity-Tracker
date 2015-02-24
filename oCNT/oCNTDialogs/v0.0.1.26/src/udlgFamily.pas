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
  StdCtrls, ExtCtrls, Buttons, Vcl.Samples.Spin, Vcl.ComCtrls,
  oCNTBase, uExtndComBroker;

type
  TdlgFamily = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    memFamily: TMemo;
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
    btnAdd: TBitBtn;
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
    procedure bbtnOKClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDAddClick(Sender: TObject);
    procedure btnDDeleteClick(Sender: TObject);
    procedure spDateSelectClick(Sender: TObject);
    procedure ToggleCB(Sender: TObject);
    procedure spnEducationChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbNameChange(Sender: TObject);
  private
  public
  end;

var
  dlgFamily: TdlgFamily;

implementation

uses
   udlgDATE;

{$R *.dfm}

procedure TdlgFamily.FormShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to lvPersonList.Items.Count - 1 do
  cbName.Items.Add(lvPersonList.Items[I].SubItems[0]);
end;

procedure TdlgFamily.cbNameChange(Sender: TObject);
var
  I,sNbr,J: Integer;
  Item: TListItem;
  sl: TStringList;

  {
        0   1   2     3         4       5      6       7    8    9      10
  IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^ZIP^PHONE HOME^
       11         12       13    14      15        16      17
  PHONE CELL^PHONE WORK^PATIENT^DFN^RELATIONSHIP^STATUS^DIAGNOSIS
  }

begin
  for I := 0 to lvPersonList.Items.Count - 1 do
  begin
    if lvPersonList.Items[I].SubItems[0] = cbName.Text then
    begin
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

      Item := lvPersonList.Items[I];

      cobfammem.Text := Item.SubItems[15];
      if Item.SubItems[16] = 'LIVING' then
      cblive.Checked := True
      else if Item.SubItems[16] = 'DECEASED' then
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
      edtPhoneC.Text := Item.SubItems[11];
      edtPhoneW.Text := Item.SubItems[12];

      sl := TStringList.Create;
      try
        sl.Delimiter := '|'; sl.StrictDelimiter := True;
        sl.DelimitedText := Item.SubItems[17];
        for J := 0 to sl.Count - 1 do
        ListBox.Items.Add(sl[J]);
      finally
        sl.Free;
      end;

      Break;
    end;
  end;
end;

Procedure TdlgFamily.ToggleCB(Sender: TObject);
begin
  if not (Sender is TCheckBox)then Exit;

  if ((TCheckBox(Sender).Name = 'cblive') and (TCheckBox(Sender).Checked)) then
  cbdead.Checked := False;

  if ((TCheckBox(Sender).Name = 'cbdead') and (TCheckBox(Sender).Checked)) then
  cblive.Checked := False;
end;

procedure TdlgFamily.btnDAddClick(Sender: TObject);
begin
  if cobdx.Text = '' then Exit;

  if ListBox.Items.IndexOf(cobdx.Text) = -1 then
  ListBox.Items.Add(cobdx.Text);
end;

procedure TdlgFamily.btnDDeleteClick(Sender: TObject);
begin
  if ListBox.ItemIndex = -1 then Exit;

  ListBox.Items.Delete(ListBox.ItemIndex);
end;

procedure TdlgFamily.btnAddClick(Sender: TObject);
var
  I: Integer;
begin
  if cobfammem.Text = '' then
  begin
    MessageDlg('You must enter a family member.', mtinformation, [mbok], 0);
    Exit;
  end;

  memFamily.Lines.Add(' Relationship: ' + cobfammem.Text);
  if cbName.Text <> ''      then memFamily.Lines.Add('  Name: ' + cbName.Text);
  if cblive.Checked = True   then memFamily.Lines.Add('  Status: ' + cblive.Caption);
  if cbdead.Checked = True   then memFamily.Lines.Add('  Status: ' + cbdead.Caption);
  if leddatebirth.Text <> '' then memFamily.Lines.Add('  Date of Birth: ' + leddatebirth.Text);
  if spnEducation.Value > 0  then memFamily.Lines.Add('  Years of Education: ' + IntToStr(spnEducation.Value));
  if edtAddr1.Text <> ''     then
  begin
    memFamily.Lines.Add('  Street Line 1: ' + edtAddr1.Text);
    if edtAddr2.Text <> ''     then memFamily.Lines.Add('  Street Line 2: ' + edtAddr2.Text);
    if edtAddr3.Text <> ''     then memFamily.Lines.Add('  Street Line 3: ' + edtAddr3.Text);
    if edtAddrcity.Text <> ''  then memFamily.Lines.Add('  City: ' + edtAddrcity.Text);
    if cbAddrstate.Text <> ''  then memFamily.Lines.Add('  State: ' + cbAddrstate.Text);
    if ((edtAddrzip.Text <> '') and (edtAddrzip.Text <> '0'))   then memFamily.Lines.Add('  Zip: ' + edtAddrzip.Text);
  end;
  if edtPhoneH.Text <> ''    then memFamily.Lines.Add('  Phone (Home): ' + edtPhoneH.Text);
  if edtPhoneC.Text <> ''    then memFamily.Lines.Add('  Phone (Cell): ' + edtPhoneC.Text);
  if edtPhoneW.Text <> ''    then memFamily.Lines.Add('  Phone (Work): ' + edtPhoneW.Text);

  for I := 0 to ListBox.Count - 1 do
  memFamily.Lines.Add('  Diagnosis: ' + ListBox.Items[I]);

  if ledcomments.Text <> '' then memFamily.Lines.Add('  Comments: ' + ledcomments.Text);

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
  cbName.Text := '';
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

procedure TdlgFamily.bbtnOKClick(Sender: TObject);
begin
  if memFamily.Lines.Count > 0 then
  if memFamily.Lines[0] <> 'Family History:' then
  memFamily.Lines.Insert(0,'Family History:');

  TmpStrList.AddStrings(memFamily.Lines);
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
end;

end.
