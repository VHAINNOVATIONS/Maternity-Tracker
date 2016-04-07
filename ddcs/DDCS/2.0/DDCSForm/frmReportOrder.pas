unit frmReportOrder;

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
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Extctrls, Grids, Menus, uReportItems;

type
  TReportOrderDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    UpBtn: TBitBtn;
    DownBtn: TBitBtn;
    ListBox1: TListBox;
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
  private
  public
  end;

var
  ReportOrderDlg: TReportOrderDlg;

implementation

{$R *.DFM}

{ TReportOrderDlg }
procedure TReportOrderDlg.UpBtnClick(Sender: TObject);
var
  I: Integer;
begin
  I := ListBox1.ItemIndex;
  if I > 0 then
  begin
    ListBox1.Items.Exchange(I, I - 1);
    ListBox1.ItemIndex := I - 1;
  end;
end;

procedure TReportOrderDlg.DownBtnClick(Sender: TObject);
var
  I: Integer;
begin
  I := ListBox1.ItemIndex;
  if I < ListBox1.Items.Count - 1 then
  begin
    ListBox1.Items.Exchange(I, I + 1);
    ListBox1.ItemIndex := I + 1;
  end;
end;

end.
