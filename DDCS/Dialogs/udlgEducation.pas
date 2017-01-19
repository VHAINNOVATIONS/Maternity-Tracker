unit udlgEducation;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils,
  System.Classes, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Controls, Vcl.Graphics, ORCtrls,
  uDialog, uCommon, DDCSUtils, DDCSComBroker;

type
  TdlgEducation = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    educationListView: TListView;
    procedure FormShow(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure educationListViewColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure educationListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    Descending: Boolean;
    SortedColumn: Integer;
  public
  end;

var
  dlgEducation: TdlgEducation;

implementation

{$R *.dfm}

procedure TdlgEducation.FormShow(Sender: TObject);
var
  cBit: TBitmap;
  I,J: Integer;
  nWidth: Integer;
const
  EXTRA_WD = 40;
begin
  cBit := TBitmap.Create;
  try
    nWidth := educationListView.Columns[0].Width;
    for J := 0 to educationListView.Items.Count - 1 do
      if (cBit.Canvas.TextWidth(educationListView.Items[J].Caption) + EXTRA_WD) > nWidth then
        nWidth := cBit.Canvas.TextWidth(educationListView.Items[J].Caption) + EXTRA_WD;
    educationListView.Columns[0].Width := nWidth;

    if educationListView.Columns.Count > 1 then
      for I := 1 to educationListView.Columns.Count - 1 do
      begin
        nWidth := 0;
        for J := 0 to educationListView.Items.Count - 1 do
          if (cBit.Canvas.TextWidth(educationListView.Items[J].SubItems[I-1]) + EXTRA_WD) > nWidth then
            nWidth := cBit.Canvas.TextWidth(educationListView.Items[J].SubItems[I-1]) + EXTRA_WD;
        educationListView.Columns[I].Width := nWidth;
      end;
  finally
    cBit.Free;
  end;
end;

procedure TdlgEducation.bbtnOKClick(Sender: TObject);
var
  I: Integer;
  tmp: string;
begin
  for I := 0 to educationListView.Items.Count - 1 do
    if educationListView.Items[I].Checked then
    begin
      tmp := educationListView.Items[I].Caption;

      if educationListView.Items[I].SubItems[0] <> '' then
        tmp := tmp + ' (Code: ' + educationListView.Items[I].SubItems[0] + ')';
      if educationListView.Items[I].SubItems[1] <> '' then
        tmp := tmp + ' (Category: ' + educationListView.Items[I].SubItems[1] + ')';
      TmpStrList.Add('  ' + tmp);
    end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0,'Patient Education:');
end;

procedure TdlgEducation.educationListViewColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  educationListView.SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end else Descending := not Descending;
  educationListView.SortType := stText;
end;

procedure TdlgEducation.educationListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  try
    if SortedColumn = 0 then
      Compare := CompareText(Item1.Caption, Item2.Caption)
    else if SortedColumn <> 0 then
      Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
    if Descending then
      Compare := -Compare;
  except
  end;
end;

end.
