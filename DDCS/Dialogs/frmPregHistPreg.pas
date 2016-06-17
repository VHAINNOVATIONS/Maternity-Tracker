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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, ORCtrls, ORDtTm,
  frmPregHistPregInfo, frmPregHistChild;

type
  TPregType = (ptN, ptAI, ptAS, ptE);

  TfPreg = class(TFrame)
    btnDelete: TBitBtn;
    pgPreg: TPageControl;
    procedure btnDeleteClick(Sender: TObject);
    procedure pgPregChange(Sender: TObject);
  private
    FPregType: TPregType;
    FPregIEN: Integer;
    procedure SetPregType(Value: TPregType);
    function GetIndex: Integer;
  public
    procedure DeleteChild(Value: TTabSheet);
    function GetPregInfo: TfPregInfo;
    function GetChild(Value: Integer): TfChild;
    function GetText: TStringList;
    function GetChildrenV: string;
    property PregnancyType: TPregType read FPregType write SetPregType default ptN;
    property PregnancyIEN: Integer read FPregIEN write FPregIEN default 0;
  end;

implementation

{$R *.dfm}

uses
  udlgPregHist, uCommon;

procedure TfPreg.btnDeleteClick(Sender: TObject);
begin
  if ShowMsg('Are you sure you wish to delete this pregnancy record?' +
             ' All associated child information will also be deleted.' +
             ' This action cannot be undone.', smiWarning, smbYesNo) = smrYes then
    dlgPregHist.DeletePregnancy(GetIndex);
end;

procedure TfPreg.pgPregChange(Sender: TObject);
begin
  if pgPreg.ActivePageIndex <> 0 then
    btnDelete.Visible := False
  else
    btnDelete.Visible := True;
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
    Result := TTabSheet(Owner).TabIndex;
end;

// Public ----------------------------------------------------------------------

procedure TfPreg.DeleteChild(Value: TTabSheet);
var
  I: Integer;
  vPregInfo: TfPregInfo;
begin
  pgPreg.Pages[Value.TabIndex].Free;

  vPregInfo := GetPregInfo;
  if vPregInfo <> nil then
  begin
    vPregInfo.spnBirthCount.OnChange := nil;
    vPregInfo.spnBirthCount.Value := vPregInfo.spnBirthCount.Value - 1;
    vPregInfo.spnBirthCount.OnChange := vPregInfo.spnBabyCountChange;

    vPregInfo.ChildCount := vPregInfo.spnBirthCount.Value;
    if ((vPregInfo.ChildCount < 2) and (vPregInfo.MultiBirth)) then
    begin
      vPregInfo.MultiBirth := False;
      dlgPregHist.ModifyMultiBirth(-1);
    end;
  end;

  if pgPreg.PageCount > 1 then
    for I := 1 to pgPreg.PageCount - 1 do
      pgPreg.Pages[I].Caption := 'Baby # ' + IntToStr(I);

  pgPregChange(pgPreg);
end;

function TfPreg.GetPregInfo: TfPregInfo;
begin
  Result := nil;

  if pgPreg.PageCount > 0 then
    if pgPreg.Pages[0].ControlCount > 0 then
      if pgPreg.Pages[0].Controls[0] is TfPregInfo then
        Result := TfPregInfo(pgPreg.Pages[0].Controls[0]);
end;

function TfPreg.GetChild(Value: Integer): TfChild;
var
  I: Integer;
begin
  Result := nil;

  if pgPreg.PageCount > 1 then
    for I := 1 to pgPreg.PageCount - 1 do
      if pgPreg.Pages[I].ControlCount > 0 then
        if pgPreg.Pages[I].Controls[0] is TfChild then
          if TfChild(pgPreg.Pages[I].Controls[0]).BabyIEN = Value then
          begin
            Result := TfChild(pgPreg.Pages[I].Controls[0]);
            Break;
          end;
end;

function TfPreg.GetText: TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;

  if GetPregInfo <> nil then
    Result.AddStrings(GetPregInfo.GetText);

  if pgPreg.PageCount > 1 then
    for I := 1 to pgPreg.PageCount - 1 do
      if pgPreg.Pages[I].ControlCount > 0 then
        if pgPreg.Pages[I].Controls[0] is TfChild then
          Result.AddStrings(TfChild(pgPreg.Pages[I].Controls[0]).GetText);
end;

function TfPreg.GetChildrenV: string;
var
  I: Integer;
begin
  Result := '';

  if pgPreg.PageCount > 1 then
    for I := 1 to pgPreg.PageCount - 1 do
      if pgPreg.Pages[I].ControlCount > 0 then
        if pgPreg.Pages[I].Controls[0] is TfChild then
          Result := Result + TfChild(pgPreg.Pages[I].Controls[0]).GetV;
end;

end.
