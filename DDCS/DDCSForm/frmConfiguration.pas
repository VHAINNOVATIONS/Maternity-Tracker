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
  ORCtrls, uBase, uCommon, uReportItems;

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
    lvDialogComponent: TListView;
    btnDialogShow: TBitBtn;
    btnUpdateConfig: TBitBtn;
    pnlCommand: TPanel;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    lbReportNotice: TStaticText;
    spOrder: TSpinEdit;
    lbOrder: TStaticText;
    lbTitle: TStaticText;
    lbPrefix: TStaticText;
    lbSuffix: TStaticText;
    edTitle: TCaptionEdit;
    edPrefix: TCaptionEdit;
    edSuffix: TCaptionEdit;
    ckDoNotSpace: TCheckBox;
    cbDialogReturn: TCaptionComboBox;
    lbDialogReturn: TStaticText;
    pnlConfig: TPanel;
    btnClear: TBitBtn;
    btnClose: TBitBtn;
    ckDoNotRestore: TCheckBox;
    lbReportControl: TStaticText;
    lvDialog: TListView;
    pgDialogOutput: TPageControl;
    TabSheet1: TTabSheet;
    pnlDialog: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    SpinEdit1: TSpinEdit;
    CaptionEdit1: TCaptionEdit;
    CaptionEdit2: TCaptionEdit;
    CaptionEdit3: TCaptionEdit;
    CheckBox4: TCheckBox;
    CaptionComboBox1: TCaptionComboBox;
    CheckBox5: TCheckBox;
    StaticText7: TStaticText;
    TabSheet2: TTabSheet;
    meDialogOutput: TMemo;
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
    procedure lvDialogDblClick(Sender: TObject);
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
  frmConfigMultiItemAdd, VAUtils, uExtndComBroker;

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
    Compare := CompareText(Item1.SubItems[SortedColumn - 1], Item2.SubItems[SortedColumn - 1]);

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
      if UpdateContext(MENU_CONTEXT) then
        CallV('DSIO DDCS IMPORT FORM', [RPCBrokerV.DDCSInterface, sl]);
    except
      On E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
    end;
  finally
    sl.Free;
  end;
end;

{$ENDREGION}

{$REGION 'Report Items'}

procedure TDDCSFormConfig.lvReportItemsDblClick(Sender: TObject);
var
  cControl: TComponent;
  nItem: TDDCSNoteItem;
begin
  lbReportControl.Caption := '';
  if lvReportItems.ItemIndex < 0 then
    Exit;

  lbReportControl.Caption := lvReportItems.Items[lvReportItems.ItemIndex].Caption;

  cControl := FDDCSForm.Owner.FindComponent(lbReportControl.Caption);
  if cControl <> nil then
  begin
    nItem := FDDCSForm.ReportCollection.GetNoteItem(TWinControl(cControl));

    if nItem <> nil then
    begin
      spOrder.Value := nItem.Order;
      edTitle.Text := nItem.Title;
      edPrefix.Text := nItem.Prefix;
      edSuffix.Text := nItem.Suffix;
      ckDoNotSpace.Checked := nItem.DoNotSpace;
      ckHideFromNote.Checked := nItem.HideFromNote;
      ckDoNotSave.Checked := nItem.DoNotSave;
//      ckDoNotRestore.Checked := nItem.DoNotRestore;
      ckRequired.Checked := nItem.Required;
      if nItem.DialogReturn <> nil then
        cbDialogReturn.ItemIndex := cbDialogReturn.Items.IndexOf(nItem.DialogReturn.Name);
    end;
  end;
end;

{$ENDREGION}

{$REGION 'Dialogs'}

procedure TDDCSFormConfig.lvDialogDblClick(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
  lvItem: TListItem;
begin
  lvDialogComponent.SortType := stNone;
  lvDialogComponent.Clear;

  if lvDialog.ItemIndex < 0 then
    Exit;

  sl := TStringList.Create;
  try
    sl.Text := GetDialogComponents(lvDialog.Items[lvDialog.ItemIndex].Caption);

    for I := 0 to sl.Count - 1 do
    begin
      lvItem := lvDialogComponent.Items.Add;
      lvItem.Caption := Piece(sl[I],U,2);
      lvItem.SubItems.Add(Piece(sl[I],u,3));
    end;
  finally
    sl.Free;
  end;
end;

procedure TDDCSFormConfig.lvDialogComponentDblClick(Sender: TObject);
begin
  if lvDialogComponent.ItemIndex < 0 then
    Exit;
end;

procedure TDDCSFormConfig.ReloadDialogs(Sender: TObject);
var
  I: Integer;
  lvItem: TListItem;
begin
  lvDialog.SortType := stNone;
  lvDialog.Clear;

  DialogDLL := LoadDialogs;

  if Assigned(DLLDialogList) then
    for I := 0 to DLLDialogList.Count - 1 do
    begin
      lvItem := lvDialog.Items.Add;
      lvItem.Caption := Piece(DLLDialogList[I],U,1);
      lvItem.SubItems.Add(Piece(DLLDialogList[I],u,2));
    end;
end;

procedure TDDCSFormConfig.btnDialogShowClick(Sender: TObject);
var
  sl: TStringList;
begin
  if lvDialog.ItemIndex < 0 then
    Exit;

  if DialogDLL <> 0 then
  begin
    sl := TStringList.Create;
    try
      try
        sl.Text := DisplayDialog(@RPCBrokerV, '||' + lvDialog.Items[lvDialog.ItemIndex].Caption, True);
      except
        on E: Exception do
        ShowMsg(E.Message, smiError, smbOK);
      end;
    finally
      if sl.Count > 0 then
      begin
        meDialogOutput.Clear;
        pgDialogOutput.ActivePageIndex := 1;
        meDialogOutput.Lines.Text := sl.Text;
      end;
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
      for I := 0 to lvDialog.Items.Count - 1 do
      begin
        sl.Clear;

        if DialogDLL <> 0 then
        begin
          sl.Text := GetDialogComponents(lvDialog.Items[I].Caption);

          // Need to collect changes made in this form and apply them to the
          // return of the existing configuration

          if sl.Count > 0 then
          begin
            if UpdateContext(MENU_CONTEXT) then
              CallV('DSIO DDCS DIALOG IMPORT', [Piece(DLLDialogList[I],U,2), Piece(DLLDialogList[I],U,1), sl]);
          end;
        end;
      end;
    except
      on E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
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
  ckDoNotRestore.Checked := False;
  ckRequired.Checked := False;
  cbDialogReturn.ItemIndex := -1;
end;

procedure TDDCSFormConfig.ClearDialogEditor;
var
  I: Integer;
begin
  lvDialog.ItemIndex := -1;
  for I := 0 to lvDialog.Items.Count - 1 do
    lvDialog.Items[I].Selected := False;

  lvDialogComponent.SortType := stNone;
  lvDialogComponent.Clear;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSFormConfig.Create(AOwner: TComponent; DDCSForm: TDDCSForm);
var
  I: Integer;
  lvItem: TListItem;
begin
  inherited Create(AOwner);

  FDDCSForm := DDCSForm;
  FObjects := TStringList.Create;

  if Assigned(DLLDialogList) then
    for I := 0 to DLLDialogList.Count - 1 do
    begin
      lvItem := lvDialog.Items.Add;
      lvItem.Caption := Piece(DLLDialogList[I],U,1);
      lvItem.SubItems.Add(Piece(DLLDialogList[I],u,2));
    end;
end;

destructor TDDCSFormConfig.Destroy;
begin
  FObjects.Free;

  inherited;
end;

procedure TDDCSFormConfig.FormShow(Sender: TObject);
var
  I,J: Integer;

  procedure ProcessControls(iPage: string; wControl: TWinControl);
  var
    I: Integer;
    lvItem: TListItem;
    nItem: TDDCSNoteItem;

    function BoolAsStr(b: Boolean): string;
    begin
      Result := 'False';
      if b then
        Result := 'True'
    end;

  begin
    if wControl.Name = '' then Exit;
    if wControl is TStaticText then Exit;

    for I := 0 to wControl.ControlCount - 1 do
      if wControl.Controls[I] is TWinControl then
        ProcessControls(iPage, TWinControl(wControl.Controls[I]));

    lvItem := lvConfig.Items.Add;
    lvItem.Caption := wControl.Name;
    lvItem.SubItems.Add(wControl.ClassName);
    lvItem.SubItems.Add(iPage);

    lvItem := lvReportItems.Items.Add;
    lvItem.Caption := wControl.Name;
    lvItem.SubItems.Add(wControl.ClassName);
    lvItem.SubItems.Add(iPage);

    // We don't want to create new note items that would unless necessary
    nItem := FDDCSForm.ReportCollection.GetNoteItem(wControl);
    if nItem <> nil then
    begin
      lvItem.SubItems.Add(BoolAsStr(nItem.Required));
      lvItem.SubItems.Add(IntToStr(nItem.Order));
    end else
    begin
      lvItem.SubItems.Add('');
      lvItem.SubItems.Add('');
    end;

    if wControl.InheritsFrom(TCustomMemo) then
      cbDialogReturn.Items.AddObject(wControl.Name, wControl);
  end;

begin
  ClearConfigurationEditor;
  ClearReportItemEditor;
  ClearDialogEditor;

  Tabs.ActivePageIndex := 0;

  for I := 0 to FDDCSForm.PageCount - 1 do
    for J := 0 to FDDCSForm.Pages[I].ControlCount - 1 do
      if FDDCSForm.Pages[I].Controls[J] is TWinControl then
        ProcessControls(IntToStr(I + 1), TWinControl(FDDCSForm.Pages[I].Controls[J]));
end;

end.
