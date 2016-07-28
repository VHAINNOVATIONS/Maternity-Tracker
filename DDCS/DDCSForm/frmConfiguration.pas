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
   VA Contract: TAC-13-06464
}

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Samples.Spin,
  Vcl.CheckLst, ORCtrls, uBase;

type
  TDDCSFormConfig = class(TForm)
    Tabs: TPageControl;
    tabDialog: TTabSheet;
    tabReport: TTabSheet;
    lvDDCSForm: TListView;
    btnReloadDialogs: TBitBtn;
    lvDialogComponent: TListView;
    btnDialogShow: TBitBtn;
    pnlCommand: TPanel;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    btnClear: TBitBtn;
    btnClose: TBitBtn;
    lvDialog: TListView;
    pgDialogOutput: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    meDialogOutput: TMemo;
    btnUpdate: TBitBtn;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    ckHideFromNoteD: TCheckBox;
    ckRequiredD: TCheckBox;
    ckDoNotSaveD: TCheckBox;
    spOrderD: TSpinEdit;
    edTitleD: TCaptionEdit;
    edPrefixD: TCaptionEdit;
    edSuffixD: TCaptionEdit;
    ckDoNotSpaceD: TCheckBox;
    cbDialogReturnD: TCaptionComboBox;
    ckDoNotRestoreD: TCheckBox;
    lbReportControlD: TStaticText;
    edIdentifyingNameD: TCaptionEdit;
    StaticText9: TStaticText;
    pgConfigCR: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    pnlReport: TPanel;
    lbReportNotice: TStaticText;
    lbOrder: TStaticText;
    lbTitle: TStaticText;
    lbPrefix: TStaticText;
    lbSuffix: TStaticText;
    lbDialogReturn: TStaticText;
    ckHideFromNoteCR: TCheckBox;
    ckRequiredCR: TCheckBox;
    ckDoNotSaveCR: TCheckBox;
    spOrderCR: TSpinEdit;
    edTitleCR: TCaptionEdit;
    edPrefixCR: TCaptionEdit;
    edSuffixCR: TCaptionEdit;
    ckDoNotSpaceCR: TCheckBox;
    cbDialogReturnCR: TCaptionComboBox;
    ckDoNotRestoreCR: TCheckBox;
    lbReportControlCR: TStaticText;
    edIdentifyingNameCR: TCaptionEdit;
    StaticText8: TStaticText;
    meConfigValuesC: TCaptionMemo;
    StaticText7: TStaticText;
    edConfigRoutineC: TCaptionEdit;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    cklConfigDialogsC: TCaptionCheckListBox;
    procedure FormShow(Sender: TObject);
    // ListBox -----------------------------------------------------------------
    procedure ListColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    // Report Items ------------------------------------------------------------
    procedure lvDDCSFormDblClick(Sender: TObject);
    // Dialogs -----------------------------------------------------------------
    procedure lvDialogDblClick(Sender: TObject);
    procedure lvDialogComponentDblClick(Sender: TObject);
    procedure ReloadDialogs(Sender: TObject);
    procedure btnDialogShowClick(Sender: TObject);
    // Command -----------------------------------------------------------------
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FDDCSForm: TDDCSForm;
    Descending: Boolean;
    SortedColumn: Integer;
    procedure ClearReportItemEditor;
    procedure ClearReportItemInputCR;
    procedure ClearDialogEditor;
    procedure ClearReportItemInputD;
  public
    constructor Create(AOwner: TDDCSForm); overload;
    destructor Destroy; override;
  end;

var
  DDCSFormConfig: TDDCSFormConfig;

implementation

uses
  frmVitals, uCommon, uReportItems, uExtndComBroker;

{$R *.dfm}

function BoolAsStr(b: Boolean): string;
begin
  Result := 'False';
  if b then
    Result := 'True'
end;

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

{$REGION 'Configuration and Report Items'}

procedure TDDCSFormConfig.lvDDCSFormDblClick(Sender: TObject);
var
  cControl: TComponent;
  nItem: TDDCSNoteItem;
  I,J: Integer;
begin
  lbReportControlCR.Caption := '';
  if lvDDCSForm.ItemIndex < 0 then
    Exit;

  lbReportControlCR.Caption := lvDDCSForm.Items[lvDDCSForm.ItemIndex].Caption;
  ClearReportItemInputCR;
  pgConfigCR.ActivePageIndex := 0;

  cControl := FDDCSForm.Owner.FindComponent(lbReportControlCR.Caption);
  if cControl <> nil then
  begin
    nItem := FDDCSForm.ReportCollection.GetNoteItem(TWinControl(cControl));

      //  IdentifyingName := nItem.IdentifyingName;
      //  Order           := nItem.Order;
      //  Title           := nItem.Title;
      //  Prefix          := nItem.Prefix;
      //  Suffix          := nItem.Suffix;
      //  DoNotSpace      := nItem.DoNotSpace;
      //  DoNotSave       := nItem.DoNotSave;
      //  DoNotRestoreV   := nItem.DoNotRestoreV;
      //  HideFromNote    := nItem.HideFromNote;
      //  Required        := nItem.Required;
      //  DialogReturn    := nItem.DialogReturn;

    if nItem = nil then
      Exit;

    spOrderCR.Value := nItem.Order;
    edIdentifyingNameCR.Caption := nItem.IdentifyingName;
    edTitleCR.Text := nItem.Title;
    edPrefixCR.Text := nItem.Prefix;
    edSuffixCR.Text := nItem.Suffix;
    ckDoNotSpaceCR.Checked := nItem.DoNotSpace;
    ckHideFromNoteCR.Checked := nItem.HideFromNote;
    ckDoNotSaveCR.Checked := nItem.DoNotSave;
    ckDoNotRestoreCR.Checked := nItem.DoNotRestoreV;
    ckRequiredCR.Checked := nItem.Required;
    if nItem.DialogReturn <> nil then
      cbDialogReturnCR.ItemIndex := cbDialogReturnCR.Items.IndexOf(nItem.DialogReturn.Name);

    if nItem.DialogReturn <> nil then
    begin
      for I := 0 to nItem.Configuration.Count - 1 do
      begin
        J := cklConfigDialogsC.Items.IndexOf(Piece(nItem.Configuration[I],'|',3));
        if J <> -1 then
          cklConfigDialogsC.Checked[J] := True;
      end;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'Dialogs'}

procedure TDDCSFormConfig.lvDialogDblClick(Sender: TObject);
var
  sl: TStringList;
  wStr: WideString;
  I: Integer;
  lvItem: TListItem;
begin
  lvDialogComponent.SortType := stNone;
  lvDialogComponent.Clear;

  if lvDialog.ItemIndex < 0 then
    Exit;

  sl := TStringList.Create;
  try
    if Assigned(FDDCSForm.GetDialogComponents) then
    begin
      FDDCSForm.GetDialogComponents(lvDialog.Items[lvDialog.ItemIndex].Caption, wStr);
      sl.Text := wStr;
      for I := 0 to sl.Count - 1 do
      begin
        lvItem := lvDialogComponent.Items.Add;
        lvItem.Caption := Piece(sl[I],U,2);
        lvItem.SubItems.Add(Piece(sl[I],u,3));
      end;
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

  FDDCSForm.LoadDialogs;

  if FDDCSForm.DLLDialogList.Count > 0 then
    for I := 0 to FDDCSForm.DLLDialogList.Count - 1 do
    begin
      lvItem := lvDialog.Items.Add;
      lvItem.Caption := Piece(FDDCSForm.DLLDialogList[I],U,1);
      lvItem.SubItems.Add(Piece(FDDCSForm.DLLDialogList[I],u,2));
    end;
end;

procedure TDDCSFormConfig.btnDialogShowClick(Sender: TObject);
var
  wSave,wConfig,wText: WideString;
begin
  if lvDialog.ItemIndex < 0 then
    Exit;

  try
    if Assigned(FDDCSForm.DisplayDialog) then
    begin
      FDDCSForm.DisplayDialog(@FDDCSForm, nil, '||' + lvDialog.Items[lvDialog.ItemIndex].Caption,
                              True, wSave, wConfig, wText);
      if wText <> '' then
      begin
        meDialogOutput.Clear;
        pgDialogOutput.ActivePageIndex := 1;
        meDialogOutput.Lines.Text := wText;
      end;
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;

  lvDialog.Selected := lvDialog.Items[lvDialog.ItemIndex];
end;

{$ENDREGION}

{$REGION 'Command'}

procedure TDDCSFormConfig.btnSaveClick(Sender: TObject);
begin
  if Tabs.ActivePageIndex = 0 then
  begin

  end else
  begin

  end;
end;

procedure TDDCSFormConfig.btnClearClick(Sender: TObject);
begin
  if Tabs.ActivePageIndex = 0 then
    ClearReportItemInputCR
  else
    ClearReportItemInputD;
end;

procedure TDDCSFormConfig.btnDeleteClick(Sender: TObject);
begin
//
end;

procedure TDDCSFormConfig.btnUpdateClick(Sender: TObject);
var
  sl: TStringList;
  wStr: WideString;
  I: Integer;
  cControl: TComponent;
  nItem: TDDCSNoteItem;

  function DialogReturnName(nItem: TDDCSNoteItem): string;
  begin
    Result := '';
    if nItem.DialogReturn <> nil then
      Result := nItem.DialogReturn.Name;
  end;

begin
  if RPCBrokerV = nil then
    Exit;

  if Tabs.ActivePageIndex = 0 then
  begin
    sl := TStringList.Create;
    try
      try
        //   (H) - CONTROL       ^ PAGE# ^ CONTROL_NAME ^ CONTROL_CLASS ^ PUSH ^ ID ^ OBSERVATION
        //   (C) - CONFIGURATION ^ PAGE# ^ CONTROL_NAME ^ VALUE
        //   (R) - REPORT ITEM   ^ PAGE# ^ CONTROL_NAME ^ NAME | VALUE
        for I := 0 to lvDDCSForm.Items.Count - 1 do
        begin
          sl.Add('H^' + lvDDCSForm.Items[I].SubItems[1] + U + lvDDCSForm.Items[I].Caption + U +
                 lvDDCSForm.Items[I].SubItems[0]);

          cControl := FDDCSForm.Owner.FindComponent(lvDDCSForm.Items[I].Caption);
          if cControl <> nil then
          begin
            nItem := FDDCSForm.ReportCollection.GetNoteItem(TWinControl(cControl));
            if nItem <> nil then
            begin
              sl.Add('R^' + lvDDCSForm.Items[I].SubItems[1] + U + lvDDCSForm.Items[I].Caption + U +
                     'IDENTIFYINGNAME|' + nItem.IdentifyingName          + U +
                               'ORDER|' + IntToStr(nItem.Order)          + U +
                               'TITLE|' + nItem.Title                    + U +
                              'PREFIX|' + nItem.Prefix                   + U +
                              'SUFFIX|' + nItem.Suffix                   + U +
                          'DONOTSPACE|' + BoolAsStr(nItem.DoNotSpace)    + U +
                           'DONOTSAVE|' + BoolAsStr(nItem.DoNotSave)     + U +
                        'DONOTRESTORE|' + BoolAsStr(nItem.DoNotRestoreV) + U +
                        'HIDEFROMNOTE|' + BoolAsStr(nItem.HideFromNote)  + U +
                             'REQUIRE|' + BoolAsStr(nItem.Required)      + U +
                        'DIALOGRETURN|' + DialogReturnName(nItem));
            end;
          end;
        end;

        if UpdateContext(MENU_CONTEXT) then
          CallV('DSIO DDCS IMPORT FORM', [RPCBrokerV.DDCSInterface, sl]);
      except
        On E: Exception do
        ShowMsg(E.Message, smiError, smbOK);
      end;
    finally
      sl.Free;
    end;
  end else
  begin
    sl := TStringList.Create;
    try
      try
        for I := 0 to lvDialog.Items.Count - 1 do
        begin
          sl.Clear;

          if Assigned(FDDCSForm.GetDialogComponents) then
          begin
            FDDCSForm.GetDialogComponents(lvDialog.Items[I].Caption, wStr);
            sl.Text := wStr;

            // Need to collect changes made in this form and apply them to the
            // return of the existing configuration

            if sl.Count > 0 then
            begin
              if UpdateContext(MENU_CONTEXT) then
                CallV('DSIO DDCS DIALOG IMPORT', [Piece(FDDCSForm.DLLDialogList[I],U,2),
                      Piece(FDDCSForm.DLLDialogList[I],U,1), sl]);
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
end;

procedure TDDCSFormConfig.btnCloseClick(Sender: TObject);
begin
  Close;
end;

{$ENDREGION}

// Private ---------------------------------------------------------------------

procedure TDDCSFormConfig.ClearReportItemEditor;
begin
  lvDDCSForm.SortType := stNone;
  lvDDCSForm.Clear;
  lbReportControlCR.Caption := '';
  ClearReportItemInputCR;
end;

procedure TDDCSFormConfig.ClearReportItemInputCR;
var
  I: Integer;
begin
  meConfigValuesC.Clear;
  edConfigRoutineC.Clear;

  for I := 0 to cklConfigDialogsC.Count - 1 do
    cklConfigDialogsC.Checked[I] := False;

  spOrderCR.Value := 0;
  edIdentifyingNameCR.Clear;
  edTitleCR.Clear;
  edPrefixCR.Clear;
  edSuffixCR.Clear;
  ckDoNotSpaceCR.Checked := False;
  ckHideFromNoteCR.Checked := False;
  ckDoNotSaveCR.Checked := False;
  ckDoNotRestoreCR.Checked := False;
  ckRequiredCR.Checked := False;
  cbDialogReturnCR.ItemIndex := -1;
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
  lbReportControlD.Caption := '';
  ClearReportItemInputD;
end;

procedure TDDCSFormConfig.ClearReportItemInputD;
begin
  spOrderD.Value := 0;
  edIdentifyingNameD.Clear;
  edTitleD.Clear;
  edPrefixD.Clear;
  edSuffixD.Clear;
  ckDoNotSpaceD.Checked := False;
  ckHideFromNoteD.Checked := False;
  ckDoNotSaveD.Checked := False;
  ckDoNotRestoreD.Checked := False;
  ckRequiredD.Checked := False;
  cbDialogReturnD.ItemIndex := -1;
  meDialogOutput.Clear;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSFormConfig.Create(AOwner: TDDCSForm);
var
  I: Integer;
  lvItem: TListItem;
begin
  inherited Create(AOwner);

  FDDCSForm := AOwner;

  if FDDCSForm.DLLDialogList.Count > 0 then
    for I := 0 to FDDCSForm.DLLDialogList.Count - 1 do
    begin
      lvItem := lvDialog.Items.Add;
      lvItem.Caption := Piece(FDDCSForm.DLLDialogList[I],U,1);
      lvItem.SubItems.Add(Piece(FDDCSForm.DLLDialogList[I],u,2));

      cklConfigDialogsC.Items.Add(lvItem.Caption);
    end;
end;

destructor TDDCSFormConfig.Destroy;
begin
  inherited;
end;

procedure TDDCSFormConfig.FormShow(Sender: TObject);
var
  I,J: Integer;
  lvItem: TListItem;
  nItem: TDDCSNoteItem;

  procedure ProcessControls(iPage: string; wControl: TWinControl; allow: Boolean);
  var
    I: Integer;
    lvItem: TListItem;
    nItem: TDDCSNoteItem;
  begin
    if wControl.Name = '' then
      Exit;
    if (not (allow) and (wControl is TStaticText)) then
      Exit;

    if not (wControl is TDDCSVitals) and not (wControl is TStaticText) then
      for I := 0 to wControl.ControlCount - 1 do
        if wControl.Controls[I] is TWinControl then
          ProcessControls(iPage, TWinControl(wControl.Controls[I]), allow);

    lvItem := lvDDCSForm.Items.Add;
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
    begin
      cbDialogReturnCR.Items.AddObject(wControl.Name, wControl);
      cbDialogReturnD.Items.AddObject(wControl.Name, wControl);
    end;
  end;

begin
  ClearReportItemEditor;
  ClearDialogEditor;

  Tabs.ActivePageIndex := 0;

  for I := 0 to FDDCSForm.PageCount - 1 do
    for J := 0 to FDDCSForm.Pages[I].ControlCount - 1 do
      if FDDCSForm.Pages[I].Controls[J] is TWinControl then
        ProcessControls(IntToStr(I + 1), TWinControl(FDDCSForm.Pages[I].Controls[J]), False);

  // Add any control that might have been manually added by the developer
  for I := 0 to FDDCSForm.ReportCollection.Count - 1 do
  begin
    nItem := FDDCSForm.ReportCollection.Items[I];
    lvItem := lvDDCSForm.FindCaption(0, nItem.OwningObject.Name, False, False, False);
    if lvItem = nil then
      ProcessControls(IntToStr(nItem.Page.PageIndex + 1), nItem.OwningObject, True);
  end;
end;

end.
