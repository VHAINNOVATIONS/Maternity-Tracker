unit udlgPreNatal;

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
  StdCtrls, ExtCtrls, Buttons, oCNTBase, uExtndComBroker;

type
  TdlgPreNatal = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    gb1: TGroupBox;
    GroupBox2: TGroupBox;
    ed1: TEdit;
    ed2: TEdit;
    ed3: TEdit;
    ed4: TEdit;
    ed5: TEdit;
    ed6: TEdit;
    ed7: TEdit;
    cb1: TCheckBox;
    cb2: TCheckBox;
    cb3: TCheckBox;
    cb4: TCheckBox;
    cb5: TCheckBox;
    cb6: TCheckBox;
    cb7: TCheckBox;
    ed8: TEdit;
    ed9: TEdit;
    ed10: TEdit;
    ed11: TEdit;
    ed12: TEdit;
    ed13: TEdit;
    ed14: TEdit;
    cb14: TCheckBox;
    cb13: TCheckBox;
    cb12: TCheckBox;
    cb11: TCheckBox;
    cb10: TCheckBox;
    cb9: TCheckBox;
    cb8: TCheckBox;
    ledMedical: TLabeledEdit;
    Memo1: TMemo;
    procedure bbtnOKClick(Sender: TObject);
    procedure cb1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ToggleCB(InCB: TCheckBox; InED: TEdit);
  public
    function GetTmpStrList: TStringList;
  end;

var
  dlgPreNatal: TdlgPreNatal;

implementation

{$R *.dfm}

procedure TdlgPreNatal.FormCreate(Sender: TObject);
begin
  // Needed for embedding
  Self.OnGetTmpStrList := GetTmpStrList;
end;

function TdlgPreNatal.GetTmpStrList;
var
  I: integer;
  TmpStr: string;

  function Check4True(InGB: TGroupBox): Boolean;
  {Check for at least 1 checkbox = True }
  var
    J: integer;

  begin
    for J := 0 to InGB.ControlCount - 1 do
    begin
      if (InGB.Controls[J] is TCheckBox) and ((InGB.Controls[J] as TCheckBox).Checked = True) then
      begin
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  TmpStrList.Clear;
  Result := TmpStrList;

{precheck medical}
  if (Check4True(gb1)) = True then
  begin
    TmpStrList.Add(' Medical History:');
    for I := 0 to gb1.ControlCount -1 do
    if (gb1.Controls[I] is TCheckBox) and ((gb1.Controls[I] as TCheckBox).Checked = True) then
    begin
      TmpStr := (gb1.Controls[I] as TCheckBox).Caption;
      case (gb1.Controls[I] as TCheckBox).Tag of
        1 : if ed1.Text  <> '' then TmpStr := TmpStr + ': ' + ed1.Text;
        2 : if ed2.Text  <> '' then TmpStr := TmpStr + ': ' + ed2.Text;
        3 : if ed3.Text  <> '' then TmpStr := TmpStr + ': ' + ed3.Text;
        4 : if ed4.Text  <> '' then TmpStr := TmpStr + ': ' + ed4.Text;
        5 : if ed5.Text  <> '' then TmpStr := TmpStr + ': ' + ed5.Text;
        6 : if ed6.Text  <> '' then TmpStr := TmpStr + ': ' + ed6.Text;
        7 : if ed7.Text  <> '' then TmpStr := TmpStr + ': ' + ed7.Text;
        8 : if ed8.Text  <> '' then TmpStr := TmpStr + ': ' + ed8.Text;
        9 : if ed9.Text  <> '' then TmpStr := TmpStr + ': ' + ed9.Text;
        10: if ed10.Text <> '' then TmpStr := TmpStr + ': ' + ed10.Text;
        11: if ed11.Text <> '' then TmpStr := TmpStr + ': ' + ed11.Text;
        12: if ed12.Text <> '' then TmpStr := TmpStr + ': ' + ed12.Text;
        13: if ed13.Text <> '' then TmpStr := TmpStr + ': ' + ed13.Text;
        14: if ed14.Text <> '' then TmpStr := TmpStr + ': ' + ed14.Text;
      end;
      TmpStrList.Add('  ' + TmpStr);
    end;
    if ledmedical.Text <> '' then TmpStrList.Add('  Comments: ' + ledmedical.Text);
  end;
{precheck surgical information}
  if Memo1.Lines.Count >0 then
  begin
    TmpStrList.Add(' Surgical History:');
    for I:= 0 to Memo1.Lines.Count -1  do
    TmpStrList.Add('  ' + Memo1.Lines[I]);
  end;

  if TmpStrList.Count > 0 then
  TmpStrList.Insert(0,'Prenatal Visit:');
end;

procedure TdlgPreNatal.ToggleCB(InCB: TCheckBox; InED: TEdit);
{toggle checkbox and edit box}
begin
  InEd.Clear;
  InED.Enabled := InCB.Checked;
end;

procedure TdlgPreNatal.bbtnOKClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.AddStrings(GetTmpStrList);
  finally
    sl.Free;
  end;
end;

procedure TdlgPreNatal.cb1Click(Sender: TObject);
{make edit boxes visible}
begin
  if (Sender is TCheckBox) then
    case (Sender as TCheckBox).Tag of
      1 : ToggleCB(cb1,ed1);
      2 : ToggleCB(cb2,ed2);
      3 : ToggleCB(cb3,ed3);
      4 : ToggleCB(cb4,ed4);
      5 : ToggleCB(cb5,ed5);
      6 : ToggleCB(cb6,ed6);
      7 : ToggleCB(cb7,ed7);
      8 : ToggleCB(cb8,ed8);
      9 : ToggleCB(cb9,ed9);
      10: ToggleCB(cb10,ed10);
      11: ToggleCB(cb11,ed11);
      12: ToggleCB(cb12,ed12);
      13: ToggleCB(cb13,ed13);
      14: ToggleCB(cb14,ed14);
    end;
end;

end.
