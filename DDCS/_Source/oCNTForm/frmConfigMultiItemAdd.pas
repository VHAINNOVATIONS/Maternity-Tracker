unit frmConfigMultiItemAdd;

interface

uses
  Forms, StdCtrls, Buttons, System.Classes, Vcl.Controls;

type
  TAddItem = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddItem: TAddItem;

implementation

{$R *.dfm}

procedure TAddItem.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
