unit frmPreview;

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
  Vcl.Dialogs, System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, uCommon, uExtndComBroker;

type
  TReviewNoteDlg = class(TForm)
    pnlControl: TPanel;
    btnAccept: TButton;
    btnReturn: TButton;
    NoteMemo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
  private
  public
     DialogResult: TStringList;
     procedure SetNote(NoteText: TStringList);
  published
  end;

var
  ReviewNoteDlg: TReviewNoteDlg;

implementation

{$R *.DFM}

procedure TReviewNoteDlg.FormCreate(Sender: TObject);
var
  tmp: string;
begin
  DialogResult := TStringList.Create;

  if RPCBrokerV = nil then
    Exit;

  try
    tmp := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'PREVIEW TITLE']);
    if tmp <> '' then
      Caption := tmp;

    tmp := '';
    tmp := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'PREVIEW READONLY']);
    if tmp <> '' then
      NoteMemo.ReadOnly := StrToBool(tmp);
  except
    on E: Exception do
    ShowDialog(Self, E.Message, mtError);
  end;
end;

procedure TReviewNoteDlg.FormDestroy(Sender: TObject);
begin
  DialogResult.Free;
end;

procedure TReviewNoteDlg.FormShow(Sender: TObject);
begin
  if btnAccept.Enabled then
    btnAccept.SetFocus
  else btnReturn.SetFocus;
end;

procedure TReviewNoteDlg.btnAcceptClick(Sender: TObject);
begin
  if RPCBrokerV <> nil then
  begin
    RPCBrokerV.Source.Lines.Clear;
    RPCBrokerV.Source.Lines.AddStrings(NoteMemo.Lines);
  end;

  ReviewNoteDlg.ModalResult := mrOK;
end;

procedure TReviewNoteDlg.SetNote(NoteText: TStringList);
begin
  NoteMemo.Lines.SetText(NoteText.GetText);
end;

end.

