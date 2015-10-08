unit udlgEducation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Controls, uDialog, uExtndComBroker;

type
  TdlgEducation = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    educationListView: TListView;
    procedure bbtnOKClick(Sender: TObject);
    procedure educationListViewColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure educationListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
    Descending: Boolean;
    SortedColumn: Integer;
  public
    { Public declarations }
  end;

var
  dlgEducation: TdlgEducation;

implementation

{$R *.dfm}

procedure TdlgEducation.bbtnOKClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to educationListView.Items.Count - 1 do
  if educationListView.Items[I].Checked then
  TmpStrList.Add('  ' + educationListView.Items[I].Caption);

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
    if Descending then Compare := -Compare;
  except
  end;
end;

end.
