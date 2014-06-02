unit frmLock;

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
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Dialogs,
  Hash, uExtndComBroker;

type
  TCNTLock = class(TForm)
    btnOK: TButton;
    edtVC: TEdit;
    lbl1: TLabel;
    lblApplicationName: TLabel;
    lblUserName: TLabel;
    edtAC: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtVCKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    FName: string;
  end;

var
  CNTLock: TCNTLock;

implementation

{$R *.dfm}

procedure TCNTLock.FormShow(Sender: TObject);
begin
  lblUserName.Caption := 'User Name: ' + FName;
  lblApplicationName.Caption := 'the Application: ' + Application.Title;
  edtAC.Clear; edtVC.Clear;
  edtAC.SetFocus;
end;

procedure TCNTLock.edtVCKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  btnOKClick(Sender);
end;

procedure TCNTLock.btnOKClick(Sender: TObject);
var
  sl: TStringList;
begin
  if ((edtAC.Text <> '') and (edtVC.Text <> '')) then
  begin
    sl := TStringList.Create;
    try
      RPCBrokerV.SetContext('XUS SIGNON');
      RPCBrokerV.tCallV(sl, 'XUS AV CODE', [Encrypt(edtAC.Text + ';' + edtVC.Text)]);
      if sl[0] <> '0' then
      ModalResult := mrOK
      else
      begin
        MessageDlg('Invalid access/verify code for ' + FName + '; please try again or click on the cancel button.',
                   mtinformation,[mbok],0);
        edtVC.Text := '';
        edtVC.SetFocus;
      end;
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  end;
end;

end.
