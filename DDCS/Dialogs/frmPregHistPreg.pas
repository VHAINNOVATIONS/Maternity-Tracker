unit frmPregHistPreg;

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
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, ORCtrls, ORDtTm,
  frmPregHistPregInfo;

type
  TPregType = (ptN, ptAI, ptAS, ptE);

  TfPreg = class(TFrame)
    btnDelete: TBitBtn;
    pgPreg: TPageControl;
    procedure btnDeleteClick(Sender: TObject);
  private
    FPregType: TPregType;
    procedure SetPregType(Value: TPregType);
    function GetIndex: Integer;
    function GetPregInfo: TfPregInfo;
  public
    function GetText: TStringList;
    property PregnancyType: TPregType read FPregType write SetPregType default ptN;
  end;

implementation

{$R *.dfm}

uses
  udlgPregHist;

procedure TfPreg.btnDeleteClick(Sender: TObject);
begin
  dlgPregHist.DeletePregnancy(GetIndex);
end;

// Private ---------------------------------------------------------------------

procedure TfPreg.SetPregType(Value: TPregType);
var
  vPregInfo: TfPregInfo;
begin
  FPregType := Value;

  vPregInfo := GetPregInfo;
  if vPregInfo <> nil then
  begin
    case Value of
         ptN: vPregInfo.lbStatus.Visible := False;
        ptAI: vPregInfo.lbStatus.Caption := 'Induced Abortion';
        ptAS: vPregInfo.lbStatus.Caption := 'Spontaneous Abortion';
         ptE: vPregInfo.lbStatus.Caption := 'Ectopic';
    end;
  end;
end;

function TfPreg.GetIndex: Integer;
begin
  Result := -1;
  if Owner is TTabSheet then
    Result := TTabSheet(Owner).PageIndex;
end;

function TfPreg.GetPregInfo;
begin
  Result := nil;

  if pgPreg.PageCount > 0 then
    if pgPreg.Pages[0].ControlCount > 0 then
      if pgPreg.Pages[0].Controls[0] is TfPregInfo then
        Result := TfPregInfo(pgPreg.Pages[0].Controls[0]);
end;

// Public ----------------------------------------------------------------------

function TfPreg.GetText: TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;

  if GetPregInfo <> nil then
    Result.AddStrings(GetPregInfo.GetText);

  if pgPreg.PageCount > 1 then
    for I := 1 to pgPreg.PageCount - 1 do
    begin
    // Add Babies
    end;
end;

end.
