unit frmConfiguration;

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
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Samples.Spin,
  uBase, uCommon, uReportItems, uExtndComBroker;

type
  TDDCSFormConfig = class(TForm)
    Tabs: TPageControl;
    tabConfig: TTabSheet;
    tabDialog: TTabSheet;
    lvConfig: TListView;
    tabReport: TTabSheet;
    lvReportItems: TListView;
    pnlReport: TPanel;
    ckHideFromNote: TCheckBox;
    ckRequired: TCheckBox;
    ckDoNotSave: TCheckBox;
    btnReloadDialogs: TBitBtn;
    btnUpdateDialogs: TBitBtn;
    lsDialog: TListBox;
    lvDialogComponent: TListView;
    btnDialogShow: TBitBtn;
    btnUpdateConfig: TBitBtn;
    pnlCommand: TPanel;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    lbReportNotice: TLabel;
    spOrder: TSpinEdit;
    lbOrder: TLabel;
    lbTitle: TLabel;
    lbPrefix: TLabel;
    lbSuffix: TLabel;
    edTitle: TEdit;
    edPrefix: TEdit;
    edSuffix: TEdit;
    ckDoNotSpace: TCheckBox;
    cbDialogReturn: TComboBox;
    lbDialogReturn: TLabel;
    pnlConfig: TPanel;
    pnlDialog: TPanel;
    btnClear: TBitBtn;
    btnClose: TBitBtn;
    procedure FormShow(Sender: TObject);
    // ListBox -----------------------------------------------------------------
    procedure ListColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    // Configuration -----------------------------------------------------------
    procedure lvConfigDblClick(Sender: TObject);
    procedure btnUpdateConfigClick(Sender: TObject);
    // Report Items ------------------------------------------------------------
    procedure lvReportItemsDblClick(Sender: TObject);
    // Dialogs -----------------------------------------------------------------
    procedure lsDialogDblClick(Sender: TObject);
    procedure lvDialogComponentDblClick(Sender: TObject);
    procedure ReloadDialogs(Sender: TObject);
    procedure btnDialogShowClick(Sender: TObject);
    procedure btnUpdateDialogsClick(Sender: TObject);
    // Command
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FDDCSForm: TDDCSForm;
    FObjects: TStringList;
    Descending: Boolean;
    SortedColumn: Integer;
    procedure ClearConfigurationEditor;
    procedure ClearReportItemEditor;
    procedure ClearReportItemInput;
    procedure ClearDialogEditor;
  public
    constructor Create(AOwner: TComponent; DDCSForm: TDDCSForm); overload;
    destructor Destroy; override;
  end;

var
  DDCSFormConfig: TDDCSFormConfig;

implementation

uses
  frmConfigMultiItemAdd;

{$R *.dfm}

// -----------------------------------------------------------------------------

{$REGION 'ListView'}

procedure TDDCSFormConfig.ListColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end else Descending := not Descending;

  TListView(Sender).SortType := stText;
end;

procedure TDDCSFormConfig.ListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else if SortedColumn <> 0 then
    Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);

  if Descending then
    Compare := -Compare;
end;

{$ENDREGION}

{$REGION 'Configuration'}

procedure TDDCSFormConfig.lvConfigDblClick(Sender: TObject);
begin
  if lvConfig.ItemIndex < 0 then
    Exit;
end;

procedure TDDCSFormConfig.btnUpdateConfigClick(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
begin
  if RPCBrokerV = nil then
    Exit;

  sl := TStringList.Create;
  try
    // page# ^ control_name ^ class
    for I := 0 to lvConfig.Items.Count - 1 do
      sl.Add(lvConfig.Items[I].SubItems[1] + U + lvConfig.Items[I].Caption + U + lvConfig.Items[I].SubItems[0]);

    try
      RPCBrokerV.SetContext(MENU_CONTEXT);
      RPCBrokerV.CallV('DSIO DDCS IMPORT FORM', [RPCBrokerV.DDCSInterface, sl]);
    except
      On E: Exception do
      ShowDialog(Self, E.Message, mtError);
    end;
  finally
    sl.Free;
  end;
end;

{$ENDREGION}

{$REGION 'Report Items'}

procedure TDDCSFormConfig.lvReportItemsDblClick(Sender: TObject);
begin
  if lvReportItems.ItemIndex < 0 then
    Exit;
end;

{$ENDREGION}

{$REGION 'Dialogs'}

procedure TDDCSFormConfig.lsDialogDblClick(Sender: TObject);
begin
  if lsDialog.ItemIndex < 0 then
    Exit;
end;

procedure TDDCSFormConfig.lvDialogComponentDblClick(Sender: TObject);
begin
  if lvDialogComponent.ItemIndex < 0 then
    Exit;
end;

procedure TDDCSFormConfig.ReloadDialogs(Sender: TObject);
begin
  DialogDLL := LoadDialogs;
end;

procedure TDDCSFormConfig.btnDialogShowClick(Sender: TObject);
var
  dlgName: string;
  sl: TStringList;
begin
  if lsDialog.ItemIndex < 0 then
    Exit;

  dlgName := '||' + lsDialog.Items[lsDialog.ItemIndex];

  if DialogDLL <> 0 then
  begin
    sl := TStringList.Create;
    try
      try
        sl.Text := DisplayDialog(@RPCBrokerV, dlgName, True);
      except
        on E: Exception do
        ShowDialog(Self, E.Message, mtError);
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TDDCSFormConfig.btnUpdateDialogsClick(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
begin
  if RPCBrokerV = nil then
    Exit;

  sl := TStringList.Create;
  try
    try
      for I := 0 to DLLDialogList.Count - 1 do
      begin
        sl.Clear;

        if DialogDLL <> 0 then
          sl.Text := GetDialogComponents(Piece(DLLDialogList[I],U,1));

        if sl.Count > 0 then
        begin
          RPCBrokerV.SetContext(MENU_CONTEXT);
          RPCBrokerV.CallV('DSIO DDCS DIALOG IMPORT', [Piece(DLLDialogList[I],U,2), Piece(DLLDialogList[I],U,1), sl]);
        end;
      end;
    except
      on E: Exception do
      ShowDialog(Self, E.Message, mtError);
    end;
  finally
    sl.Free;
  end;
end;

{$ENDREGION}

{$REGION 'Command'}

procedure TDDCSFormConfig.btnSaveClick(Sender: TObject);
begin
//
end;

procedure TDDCSFormConfig.btnCancelClick(Sender: TObject);
begin
//
end;

procedure TDDCSFormConfig.btnClearClick(Sender: TObject);
begin
//
end;

procedure TDDCSFormConfig.btnDeleteClick(Sender: TObject);
begin
//
end;

procedure TDDCSFormConfig.btnCloseClick(Sender: TObject);
begin
  Close;
end;

{$ENDREGION}

// Private ---------------------------------------------------------------------

procedure TDDCSFormConfig.ClearConfigurationEditor;
begin
  lvConfig.SortType := stNone;
  lvConfig.Clear;
end;

procedure TDDCSFormConfig.ClearReportItemEditor;
begin
  lvReportItems.SortType := stNone;
  lvReportItems.Clear;
  ClearReportItemInput;
end;

procedure TDDCSFormConfig.ClearReportItemInput;
begin
  spOrder.Value := 0;
  edTitle.Clear;
  edPrefix.Clear;
  edSuffix.Clear;
  ckDoNotSpace.Checked := False;
  ckHideFromNote.Checked := False;
  ckDoNotSave.Checked := False;
  ckRequired.Checked := False;
  cbDialogReturn.ItemIndex := -1;
end;

procedure TDDCSFormConfig.ClearDialogEditor;
var
  I: Integer;
begin
  lsDialog.ItemIndex := -1;
  for I := 0 to lsDialog.Count - 1 do
    lsDialog.Selected[I] := False;

  lvDialogComponent.SortType := stNone;
  lvDialogComponent.Clear;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSFormConfig.Create(AOwner: TComponent; DDCSForm: TDDCSForm);
begin
  inherited Create(AOwner);

  FDDCSForm := DDCSForm;
  FObjects := TStringList.Create;
end;

destructor TDDCSFormConfig.Destroy;
begin
  FObjects.Free;

  inherited;
end;

procedure TDDCSFormConfig.FormShow(Sender: TObject);
var
  I,J: Integer;
  wControl: TWinControl;
  lvItem: TListItem;
  nItem: TDDCSNoteItem;

  function BoolAsStr(b: Boolean): string;
  begin
    Result := BoolToStr(b);
    if Result = '-1' then
      Result := 'True'
    else Result := 'False';
  end;

begin
  ClearConfigurationEditor;
  ClearReportItemEditor;
  ClearDialogEditor;

  Tabs.ActivePageIndex := 0;

  for I := 0 to FDDCSForm.PageCount - 1 do
    for J := 0 to FDDCSForm.Pages[I].ControlCount - 1 do
      if FDDCSForm.Pages[I].Controls[J] is TWinControl then
      begin
        wControl := TWinControl(FDDCSForm.Pages[I].Controls[J]);

        lvItem := lvConfig.Items.Add;
        lvItem.Caption := wControl.Name;
        lvItem.SubItems.Add(wControl.ClassName);
        lvItem.SubItems.Add(IntToStr(I+1));

        lvItem := lvReportItems.Items.Add;
        lvItem.Caption := wControl.Name;
        lvItem.SubItems.Add(wControl.ClassName);
        lvItem.SubItems.Add(IntToStr(I+1));

        nItem := FDDCSForm.ReportCollection.GetNoteItem(wControl);
        if nItem <> nil then
        begin
          lvItem.SubItems.Add(BoolAsStr(nItem.Required));
          lvItem.SubItems.Add(IntToStr(nItem.Order));
        end;
      end;
end;

end.
