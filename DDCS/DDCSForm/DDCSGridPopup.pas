unit DDCSGridPopup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfGridPopupEditor = class(TForm)
    pnlTop: TPanel;
    ckList: TCheckListBox;
    BitBtn1: TBitBtn;
    edFind: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGridPopupEditor: TfGridPopupEditor;

implementation

{$R *.dfm}

end.
