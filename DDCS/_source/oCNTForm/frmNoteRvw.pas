unit frmNoteRvw;

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
  Vcl.Dialogs, system.SysUtils, Classes, Forms, Controls, StdCtrls, ExtCtrls,
  ComCtrls, uExtndComBroker;

type
  TReviewNoteDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel3: TPanel;
    NoteMemo: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
  public
     DialogResult : TStringList;
     procedure SetNote(NoteText: TStringList);
  published
  end;

var
  ReviewNoteDlg: TReviewNoteDlg;

implementation

{$R *.DFM}

procedure TReviewNoteDlg.FormCreate(Sender: TObject);
var
  DDCSConfig: string;
begin
  DialogResult := TStringList.Create;
  try
    DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'PREVIEW TITLE']);
    if DDCSConfig <> '' then
      Caption := DDCSConfig;

    DDCSConfig := '';
    DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'PREVIEW READONLY']);
    if DDCSConfig <> '' then
      NoteMemo.ReadOnly := StrToBool(DDCSConfig);
  except
    on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TReviewNoteDlg.FormDestroy(Sender: TObject);
begin
  DialogResult.Free;
end;

procedure TReviewNoteDlg.OKBtnClick(Sender: TObject);
begin
  RPCBrokerV.Source.Lines.Clear;
  RPCBrokerV.Source.Lines.AddStrings(NoteMemo.Lines);
  ReviewNoteDlg.ModalResult := mrOK;
end;

procedure TReviewNoteDlg.SetNote(NoteText: TStringList);
begin
  NoteMemo.Lines.SetText(NoteText.GetText);
end;

end.

