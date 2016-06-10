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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin, Vcl.ComCtrls,
  Vcl.CheckLst, ORCtrls, uDialog, uCommon, uExtndComBroker;

type
  TdlgFamily = class(TDDCSDialog)
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    cbRelationship: TComboBox;
    lbRelationship: TLabel;
    lvPersonList: TListView;
    cbName: TComboBox;
    lblName: TLabel;
    rgLife: TRadioGroup;
    rgSex: TRadioGroup;
    lbComments: TLabel;
    edComment: TEdit;
    pnlDiagnosis: TPanel;
    cklstDiagnosisList: TCheckListBox;
    btnAdd: TButton;
    cklstDiagnosis: TCheckListBox;
    btnDelete: TButton;
    lbDiagnosis: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbNameChange(Sender: TObject);
    procedure cbNameExit(Sender: TObject);
    procedure cbRelationshipChange(Sender: TObject);
    procedure rgSexClick(Sender: TObject);
    procedure rgLifeClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure edCommentExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FamilyItem: TListItem;
    procedure ClearForm;
    procedure BuildForm;
    procedure AddDiagnosis(Value: string);
    procedure UpdateDiagnosis;
    function SubCount(str: string; d: Char): Integer;
  public
  end;

var
  dlgFamily: TdlgFamily;

implementation

{$R *.dfm}

procedure TdlgFamily.FormCreate(Sender: TObject);
begin
  SayOnFocus(cklstDiagnosisList, 'Check items to add to person diagnosis.');
  SayOnFocus(    cklstDiagnosis, 'Check items to delete from person diagnosis.');
  SayOnFocus(            btnAdd, 'Click to add checked items from available diagnosis list to person diagnosis.');
  SayOnFocus(         btnDelete, 'Click to delete checked items from person diagnosis.');
end;

procedure TdlgFamily.FormShow(Sender: TObject);
var
  I,J: Integer;
begin
  ClearForm;

  for I := 0 to lvPersonList.Items.Count - 1 do
  begin
    if lvPersonList.Items[I].SubItems.Count > 0 then
      cbName.Items.Add(lvPersonList.Items[I].SubItems[0]);
    for J := lvPersonList.Items.Item[I].SubItems.Count - 1 to 19 do
      lvPersonList.Items.Item[I].SubItems.Add('');
  end;
end;

procedure TdlgFamily.cbNameChange(Sender: TObject);
var
  I: Integer;
begin
  if cbName.Text = '' then
  begin
    FamilyItem := nil;
    Exit;
  end;

  ClearForm;

  for I := 0 to lvPersonList.Items.Count - 1 do
    if lvPersonList.Items[I].SubItems.Count > 0 then
      if AnsiCompareText(lvPersonList.Items[I].SubItems[0], cbName.Text) = 0 then
      begin
        FamilyItem := lvPersonList.Items[I];
        BuildForm;
        Break;
      end;
end;

procedure TdlgFamily.cbNameExit(Sender: TObject);
begin
  cbNameChange(cbName);

  if ((FamilyItem = nil) and (cbName.Text <> '')) then
  begin
    if ShowMsg('Do you wish to add ' + cbName.Text + ' as a new entry?', smiQuestion,
                smbYesNo) = smrYes then
    begin
      FamilyItem := lvPersonList.Items.Add;
      FamilyItem.Caption := '+';
      FamilyItem.SubItems.Add(cbName.Text);
      cbName.Items.Add(cbName.Text);
      BuildForm;
    end else
    begin
      ClearForm;
      cbName.ItemIndex := -1;
      cbName.Text := '';
    end;
  end;
end;

procedure TdlgFamily.cbRelationshipChange(Sender: TObject);
begin
  if FamilyItem = nil then
    Exit;

  FamilyItem.SubItems[16] := cbRelationship.Text;
end;

procedure TdlgFamily.rgSexClick(Sender: TObject);
begin
  if FamilyItem = nil then
    Exit;

  case rgSex.ItemIndex of
   0: FamilyItem.SubItems[1] := 'MALE';
   1: FamilyItem.SubItems[1] := 'FEMALE';
   2: FamilyItem.SubItems[1] := 'UNKNOWN';
  end;
end;

procedure TdlgFamily.rgLifeClick(Sender: TObject);
begin
  if FamilyItem = nil then
    Exit;

  case rgLife.ItemIndex of
   0: FamilyItem.SubItems[17] := 'LIVING';
   1: FamilyItem.SubItems[17] := 'DECEASED';
  end;
end;

procedure TdlgFamily.btnAddClick(Sender: TObject);
var
  I: Integer;
begin
  if FamilyItem = nil then
    Exit;

  for I := 0 to cklstDiagnosisList.Items.Count - 1 do
    if cklstDiagnosisList.Checked[I] then
      AddDiagnosis(cklstDiagnosisList.Items[I]);

  UpdateDiagnosis;
end;

procedure TdlgFamily.btnDeleteClick(Sender: TObject);
var
  I: Integer;
begin
  if FamilyItem = nil then
    Exit;

  for I := cklstDiagnosis.Items.Count - 1 downto 0 do
    if cklstDiagnosis.Checked[I] then
      cklstDiagnosis.Items.Delete(I);

  UpdateDiagnosis;
end;

procedure TdlgFamily.edCommentExit(Sender: TObject);
begin
  if FamilyItem = nil then
    Exit;

  FamilyItem.SubItems[19] := edComment.Text;
end;

procedure TdlgFamily.btnOKClick(Sender: TObject);
var
  I,J,G: Integer;
  val: string;

  // IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^ZIP^PHONE HOME^
  // PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^DFN^RELATIONSHIP^STATUS^DIAGNOSIS^COMMENTS

begin
  for I := 0 to lvPersonList.Items.Count - 1 do
  begin
    TmpStrList.Add('  Name: ' + lvPersonList.Items.Item[I].SubItems[0]);
    TmpStrList.Add('    Relationship: ' + lvPersonList.Items.Item[I].SubItems[16]);
    TmpStrList.Add('    Gender: ' + lvPersonList.Items.Item[I].SubItems[1]);
    TmpStrList.Add('    Status: ' + lvPersonList.Items.Item[I].SubItems[17]);

    val := lvPersonList.Items.Item[I].SubItems[18];
    if val <> '' then
    begin
      TmpStrList.Add('    Diagnosis:');
      G := SubCount(val,'|') + 1;
      for J := 1 to G do
        TmpStrList.Add('     ' + Piece(val,'|',J));
    end;

    TmpStrList.Add('    Comment: ' + lvPersonList.Items.Item[I].SubItems[19]);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Family History:');
end;

// Private ---------------------------------------------------------------------

procedure TdlgFamily.ClearForm;
var
  I: Integer;
begin
  FamilyItem := nil;

  cbRelationship.ItemIndex := -1;
  rgSex.ItemIndex := -1;
  rgLife.ItemIndex := -1;
  edComment.Clear;

  for I := 0 to cklstDiagnosisList.Items.Count - 1 do
    cklstDiagnosisList.Checked[I] := False;
  cklstDiagnosis.Clear;
end;

procedure TdlgFamily.BuildForm;
var
  val: string;
  I,J: Integer;
begin
  if FamilyItem = nil then
    Exit;

  for I := FamilyItem.SubItems.Count - 1 to 19 do
    FamilyItem.SubItems.Add('');

  if cbRelationship.Items.IndexOf(FamilyItem.SubItems[16]) <> -1 then
    cbRelationship.ItemIndex := cbRelationship.Items.IndexOf(FamilyItem.SubItems[16]);

  if FamilyItem.SubItems[1] = 'MALE' then
    rgSex.ItemIndex := 0
  else if FamilyItem.SubItems[1] = 'FEMALE' then
    rgSex.ItemIndex := 1
  else rgSex.ItemIndex := 2;

  if FamilyItem.SubItems[17] = 'LIVING' then
    rgLife.ItemIndex := 0
  else rgLife.ItemIndex := 1;

  val := FamilyItem.SubItems[18];
  if val <> '' then
  begin
    J := SubCount(val,'|') + 1;
    for I := 1 to J do
      AddDiagnosis(Piece(val,'|',I));
  end;

  edComment.Text := FamilyItem.SubItems[19];
end;

procedure TdlgFamily.AddDiagnosis(Value: string);
var
  I: Integer;
begin
  for I := 0 to cklstDiagnosis.Items.Count - 1 do
    if cklstDiagnosis.Items[I] = Value then
      Exit;

  cklstDiagnosis.Items.Add(Value);
end;

procedure TdlgFamily.UpdateDiagnosis;
var
  Value: string;
  I: Integer;
begin
  if FamilyItem = nil then
    Exit;

  Value := '';
  for I := 0 to cklstDiagnosis.Items.Count - 1 do
    Value := Value + cklstDiagnosis.Items[I] + '|';
  FamilyItem.SubItems[18] := Value;
end;

function TdlgFamily.SubCount(str: string; d: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(str) - 1 do
    if str[I] = d then
      inc(Result);
end;

end.
