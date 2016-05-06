unit udlgHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, uDialog, uExtndComBroker,
  VA508AccessibilityManager;

type
  TdlgHistory = class(ToCNTDialog)
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Panel1: TPanel;
    lbltitle: TLabel;
    ListView: TListView;
    amgrMain: TVA508AccessibilityManager;
    procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    Descending: Boolean;
    SortedColumn: Integer;
  public
  end;

var
  dlgHistory: TdlgHistory;

implementation

{$R *.dfm}

procedure TdlgHistory.ListViewColumnClick(Sender: TObject; Column: TListColumn);
begin
  ListView.SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end else Descending := not Descending;
  ListView.SortType := stText;
end;

procedure TdlgHistory.ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
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
