unit frmConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uReportItems, ComCtrls, ExtCtrls, StdCtrls, Buttons, oCNTBase,
  uExtndComBroker;

type
  ToCNTConfiguration = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ConfigList: TListView;
    btnCloseMain: TBitBtn;
    Label1: TLabel;
    edtSingTextDisp: TLabeledEdit;
    TabSheet3: TTabSheet;
    DialogType: TRadioGroup;
    DialogEditor: TGroupBox;
    DialogConLst: TComboBox;
    DialogLst: TListBox;
    lstMultiDialogItems: TListBox;
    btnConMulDiAdd: TBitBtn;
    btnConMulDiDelete: TBitBtn;
    btnMultiDialogItemsUp: TBitBtn;
    btnMultiDialogItemsDown: TBitBtn;
    configDisclaimer: TLabel;
    ItemEditor: TGroupBox;
    btnMultiListItemsDown: TBitBtn;
    btnMultiListItemsUp: TBitBtn;
    lstMultiListItems: TListBox;
    btnAddMultiItem: TBitBtn;
    btnDeleteMultiItem: TBitBtn;
    pnlIntro: TPanel;
    Memo1: TMemo;
    ReportItemlst: TListView;
    Label2: TLabel;
    Label4: TLabel;
    Panel5: TPanel;
    RITitle: TLabeledEdit;
    RIPrefex: TLabeledEdit;
    RIVistalabel: TLabeledEdit;
    RIHide: TCheckBox;
    RISuffix: TLabeledEdit;
    RIRequired: TCheckBox;
    RIDoNotSave: TCheckBox;
    btnRIDelete: TBitBtn;
    BitBtn1: TBitBtn;
    btnUpdateVistADialogs: TBitBtn;
    DialogEditList: TListBox;
    dialogcomplist: TListView;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    btnDialogMultiDown: TBitBtn;
    btnDialogMultiUp: TBitBtn;
    lstDialogMulti: TListBox;
    btnDialogMultiAdd: TBitBtn;
    btnDialogMultiDelete: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    Label6: TLabel;
    Panel7: TPanel;
    btnDialogOK: TBitBtn;
    btnDialogCancel: TBitBtn;
    Panel6: TPanel;
    Panel4: TPanel;
    btnRIOK: TBitBtn;
    btnRICancel: TBitBtn;
    Panel8: TPanel;
    Panel3: TPanel;
    btnConfigOK: TBitBtn;
    btnConfigCancel: TBitBtn;
    Panel9: TPanel;
    configWP: TGroupBox;
    Memo2: TMemo;
    btnConMulDiDeleteAll: TBitBtn;
    btnConMulDiAddAll: TBitBtn;
    cbConfigButton: TComboBox;
    GroupBox2: TGroupBox;
    Memo3: TMemo;
    lblConfigSelected: TLabel;
    lblRISelected: TLabel;
    lblDialogCompSelected: TLabel;
    lblDialogSelected: TLabel;
    ComponentList: TListView;
    btnDialogShow: TBitBtn;
    btnoCNTImport: TBitBtn;
    lblRISelectedTyp: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ConfigListDblClick(Sender: TObject);
    procedure DialogTypeClick(Sender: TObject);
    procedure btnCloseMainClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseConfigClick(Sender: TObject);
    procedure btnAddMultiItemClick(Sender: TObject);
    procedure btnDeleteMultiItemClick(Sender: TObject);
    procedure lstUpClick(Sender: TObject);
    procedure lstDownClick(Sender: TObject);
    procedure btnOKConfigClick(Sender: TObject);
    procedure lstMultiListItemsDblClick(Sender: TObject);
    procedure btnRIDeleteClick(Sender: TObject);
    procedure btnRIOKClick(Sender: TObject);
    procedure ReportItemlstDblClick(Sender: TObject);
    procedure ListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListColumnClick(Sender: TObject; Column: TListColumn);
    procedure ReLoadDialogs(Sender: TObject);
    procedure DialogEditListDblClick(Sender: TObject);
    procedure dialogcomplistDblClick(Sender: TObject);
    procedure btnRICancelClick(Sender: TObject);
    procedure btnDialogOKClick(Sender: TObject);
    procedure btnDialogCancelClick(Sender: TObject);
    procedure btnConMulDiAddClick(Sender: TObject);
    procedure btnConMulDiDeleteClick(Sender: TObject);
    procedure btnConMulDiAddAllClick(Sender: TObject);
    procedure btnConMulDiDeleteAllClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnUpdateVistADialogsClick(Sender: TObject);
    procedure ShowDialog(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure btnoCNTImportClick(Sender: TObject);
  private
    { Private declarations }
    Descending: Boolean;
    SortedColumn: Integer;
    function GetType(Comp: TComponent; ClassName: string): string;
    function GetClass(CompName,CompClass: string): Boolean;
    procedure ClearConfiguration;
    procedure ClearConfigurationforMain;
    procedure ClearReportItem;
    procedure ClearReportforMain;
    procedure ClearDialogEditor;
    procedure ClearDialogforMain;
    procedure ClearDialogforSecondary;
    procedure UpdateToDialogType(CompDialog,CompContainer: string);
  public
    { Public declarations }
  end;

var
  oCNTConfiguration: ToCNTConfiguration;

implementation

uses
  frmConfigMultiItemAdd;

{$R *.dfm}

//------------------------------ Dialog Support -------------------------------

procedure ToCNTConfiguration.ReLoadDialogs(Sender: TObject);
begin
  if not (csDesigning in ComponentState) then
  begin
    DialogDLL := LoadDialogs;

    DialogEditList.Clear;
    DialogEditList.Items.AddStrings(DLLDialogList);

    cbConfigButton.Items.Clear;
    cbConfigButton.Items.AddStrings(DLLDialogList);

    DialogLst.Clear;
    DialogLst.Items.AddStrings(DLLDialogList);

    if DialogEditList.Count > 0 then
    btnUpdateVistADialogs.Enabled := True;
  end;
end;

//------------------------------ Initial Setup -------------------------------

function ToCNTConfiguration.GetType(Comp: TComponent; ClassName: string): string;
begin
  if ClassName = 'TDateTimePicker' then
  Result := 'Single'
  else if ClassName = 'TEdit' then
  Result := 'Single'
  else if ClassName = 'TLabeledEdit' then
  Result := 'Single'
  else if ClassName = 'TCheckBox' then
  Result := 'Single'
  else if ClassName = 'TRadioButton' then
  Result := 'Single'
  else if ClassName = 'TRadioGroup' then
  Result := 'Single'
  else if ClassName = 'TSpinEdit' then
  Result := 'Single'
  else if ClassName = 'TButton' then
  Result := 'Single'
  else if ClassName = 'TBitBtn' then
  Result := 'Single'
  else if ClassName = 'TComboBox' then
  Result := 'Multi'
  else if ClassName = 'TListBox' then
  Result := 'Multi'
  else if ClassName = 'TCheckListBox' then
  Result := 'Dialog List'
  else if ClassName = 'TMemo' then
  begin
    Result := 'Word Processing';
    DialogConLst.Items.Add(Comp.Name);
  end
  else if ClassName = 'TRichEdit' then
  begin
    Result := 'Word Processing';
    DialogConLst.Items.Add(Comp.Name);
  end
  else if ClassName = 'TJvStringGrid' then
  Result := 'Multi'
  else Result := '';
end;

procedure ToCNTConfiguration.FormCreate(Sender: TObject);
var
  I,ct: Integer;
  location: string;
  win1: TWinControl;
  base: ToForm;

  procedure setLists(Control: TWincontrol);
  var
    configType: string;
    cLst,rLst,oLst: TListItem;
  begin
    configType := GetType(Control, Control.ClassName);
    // RPC - get configuration type from VistA - use if Dialog Type
    if configType <> '' then
    begin
      //Vitural List
      oLst := ComponentList.Items.Add;
      oLst.Caption := Control.Name;
      oLst.SubItems.Add(configType);
      oLst.SubItems.Add(location);
      oLst.SubItems.Add(Control.ClassName);
      //Configuration List Box
      cLst := ConfigList.Items.Add;
      cLst.Caption := Control.Name;
      cLst.SubItems.Add(configType);
      cLst.SubItems.Add(location);
      //Report Item List Box
      if configType <> 'Button' then
      begin
        rLst := ReportItemlst.Items.Add;
        rLst.Caption := Control.Name;
        rLst.SubItems.Add(configType);
        rLst.SubItems.Add(location);
      end;
    end;
  end;

  procedure loopin(Control: TWinControl);
  var
    I: Integer;
  begin
    if (Control.ClassType = TPanel) or (Control.ClassType = TGroupBox) then
    begin
      for I := 0 to Control.ControlCount - 1 do
      loopin(TWinControl(Control.Controls[I]));
    end else
    setLists(Control);
  end;

  function PageIndex(form: ToForm; tab: ToPage): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to form.PageCount - 1 do
    begin
      if form.Pages[I] = tab then
      begin
        Result := I;
        Break;
      end;
    end;
  end;

begin
  DialogEditList.Items.AddStrings(DLLDialogList);
  cbConfigButton.Items.AddStrings(DLLDialogList);

  base := ToForm(Owner.FindComponent('ofrm1'));

  for I := 0 to Owner.ComponentCount - 1 do
  begin
    if Owner.Components[I].ClassType = ToPage then
    begin
      location := IntToStr(PageIndex(base, ToPage(Owner.Components[I]))+1);
      win1 := TWinControl(Owner.Components[I]);
      for ct := 0 to win1.ControlCount - 1 do
      loopin(TWinControl(win1.Controls[ct]));
    end;
  end;
end;

//--------------------------- Regular Form Movement ----------------------------

procedure ToCNTConfiguration.FormShow(Sender: TObject);
begin
  ClearConfiguration;
  ClearReportItem;
  ClearDialogEditor;
  PageControl1.ActivePageIndex := 0;

  configDisclaimer.Visible := False;
  pnlIntro.Visible := True;
  pnlIntro.BringToFront;
end;

procedure ToCNTConfiguration.PageControl1Change(Sender: TObject);
begin
  ClearConfiguration;
  ClearReportItem;
  ClearDialogEditor;
end;

procedure ToCNTConfiguration.btnCloseMainClick(Sender: TObject);
begin
  Close;
end;

//---------------------------- Configuration Page -----------------------------

procedure ToCNTConfiguration.ClearConfiguration;
var
  I: Integer;
begin
  for I := 0 to ConfigList.Items.Count - 1 do
  ConfigList.Items.Item[I].Selected := False;

  ClearConfigurationforMain;
  Panel9.Visible := False;
  configDisclaimer.Visible := False;
  pnlIntro.Visible := True;
  pnlIntro.BringToFront;
end;

procedure ToCNTConfiguration.ClearConfigurationforMain;
begin
  lblConfigSelected.Caption := '';

  //Single Type
  edtSingTextDisp.Clear;
  edtSingTextDisp.Visible := False;

  //Button Type
  cbConfigButton.ItemIndex := -1;
  cbConfigButton.Visible := False;

  DialogType.ItemIndex := -1;
  DialogType.Visible := False;

  //Dialog Editor Group
  DialogConLst.ItemIndex := -1;
  DialogLst.Clear;
  DialogLst.Items.AddStrings(DLLDialogList);
  lstMultiDialogItems.Clear;
  DialogEditor.Visible := False;

  //Multi Item Group
  lstMultiListItems.Clear;
  ItemEditor.Visible := False;

  //Word Processing Type
  Memo2.Clear;
  configWP.Visible := False;

  Panel3.Visible := False;
end;

procedure ToCNTConfiguration.ConfigListDblClick(Sender: TObject);
begin
  if ConfigList.ItemIndex < 0 then Exit;

  ClearConfigurationforMain;

  pnlIntro.Visible := False;
  pnlIntro.SendToBack;
  configDisclaimer.Visible := True;

  lblConfigSelected.Caption := ConfigList.Items.Item[ConfigList.ItemIndex].Caption;

  if (ConfigList.Items.Item[ConfigList.ItemIndex].SubItems[0] = 'Multi') or
  (ConfigList.Items.Item[ConfigList.ItemIndex].SubItems[0] = 'Dialog List') then
  begin
    DialogType.Visible := True;
    edtSingTextDisp.Visible := False;
    cbConfigButton.Visible := False;
    ItemEditor.Visible := False;
    DialogEditor.Visible := False;
    configWP.Visible := False;
  end
  else if (ConfigList.Items.Item[ConfigList.ItemIndex].SubItems[0] = 'Word Processing') or
  (ConfigList.Items.Item[ConfigList.ItemIndex].SubItems[0] = 'Dialog Container') then
  begin
    configWP.Visible := True;
    DialogType.Visible := False;
    edtSingTextDisp.Visible := False;
    cbConfigButton.Visible := False;
    ItemEditor.Visible := False;
    DialogEditor.Visible := False;
  end
  else if ConfigList.Items.Item[ConfigList.ItemIndex].SubItems[0] = 'Button' then
  begin
    cbConfigButton.Visible := True;
    DialogType.Visible := False;
    edtSingTextDisp.Visible := False;
    ItemEditor.Visible := False;
    DialogEditor.Visible := False;
    configWP.Visible := False;
  end
  else
  begin
    edtSingTextDisp.Visible := True;
    DialogType.Visible := False;
    cbConfigButton.Visible := False;
    ItemEditor.Visible := False;
    DialogEditor.Visible := False;
    configWP.Visible := False;
  end;
  Panel3.Visible := True;
end;

procedure ToCNTConfiguration.DialogTypeClick(Sender: TObject);
begin
  if DialogType.ItemIndex = 0 then
  begin
    if not GetClass(lblConfigSelected.Caption, 'TCheckListBox') then
    begin
      ShowMessage('Only TCheckListBoxes can be of the Dialog Type.');
      DialogType.ItemIndex := 1;
      DialogEditor.Visible := False;
      ItemEditor.Visible := True;
    end else
    begin
      DialogEditor.Visible := True;
      ItemEditor.Visible := False;
    end;
  end
  else
  begin
    DialogEditor.Visible := False;
    ItemEditor.Visible := True;
  end;
end;

procedure ToCNTConfiguration.btnConMulDiAddAllClick(Sender: TObject);
begin
  lstMultiDialogItems.Items.AddStrings(DialogLst.Items);
  DialogLst.Clear;
end;

procedure ToCNTConfiguration.btnConMulDiAddClick(Sender: TObject);
begin
  if DialogLst.ItemIndex < 0 then Exit;

  lstMultiDialogItems.Items.Add(DialogLst.Items.Strings[DialogLst.ItemIndex]);
  DialogLst.Items.Delete(DialogLst.ItemIndex);
end;

procedure ToCNTConfiguration.btnConMulDiDeleteAllClick(Sender: TObject);
begin
  DialogLst.Items.AddStrings(lstMultiDialogItems.Items);
  lstMultiDialogItems.Clear;
end;

procedure ToCNTConfiguration.btnConMulDiDeleteClick(Sender: TObject);
begin
  if lstMultiDialogItems.ItemIndex < 0 then Exit;

  DialogLst.Items.Add(lstMultiDialogItems.Items.Strings[lstMultiDialogItems.ItemIndex]);
  lstMultiDialogItems.Items.Delete(lstMultiDialogItems.ItemIndex);
end;

procedure ToCNTConfiguration.btnOKConfigClick(Sender: TObject);
begin
  // Component is a Dialog Type
  if DialogType.ItemIndex = 0 then
  begin
    if DialogConLst.ItemIndex = -1 then
    begin
      ShowMessage('Dialog types must have a dialog container.');
      DialogConLst.SetFocus;
      Exit;
    end
    else
    begin
      // Update lists with the new Component Type and its container
      UpdateToDialogType(lblConfigSelected.Caption, DialogConLst.Items.Strings[DialogConLst.ItemIndex]);
    end;
  end;

  // RPC - Save Configuration

  ClearConfigurationforMain;
end;

procedure ToCNTConfiguration.btnCloseConfigClick(Sender: TObject);
begin
  ClearConfigurationforMain;
end;

procedure ToCNTConfiguration.btnoCNTImportClick(Sender: TObject);
var
  sl: TStringList;
  I: Integer;

begin
  sl := TStringList.Create;
  try
    for I := 0 to ConfigList.Items.Count - 1 do
    sl.Add(ConfigList.Items[I].Caption + U + ConfigList.Items[I].SubItems[0]);

    try
      RPCBrokerV.CallV('DSIO OCNT IMPORT', [oCNT, sl]);
    except
      On E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    sl.Free;
  end;
end;

//----------------------------- Report Item Page ------------------------------

procedure ToCNTConfiguration.ClearReportItem;
var
  I: Integer;
begin
  for I := 0 to ReportItemlst.Items.Count - 1 do
  ReportItemlst.Items.Item[I].Selected := False;

  ClearReportforMain;
  Panel5.Visible := False;
  Panel4.Visible := False;
end;

procedure ToCNTConfiguration.ClearReportforMain;
begin
  lblRISelected.Caption := '';
  lblRISelectedTyp.Caption := '';

  RITitle.Clear;
  RIPrefex.Clear;
  RISuffix.Clear;
  RIVistalabel.Clear;
  RIDoNotSave.Checked := False;
  RIHide.Checked := False;
  RIRequired.Checked := False;
end;

procedure ToCNTConfiguration.ReportItemlstDblClick(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
begin
  if ReportItemlst.ItemIndex < 0 then Exit;

  ClearReportforMain;
  if ReportItemlst.Items.Item[ReportItemlst.ItemIndex].SubItems[0] = 'Dialog List' then
  begin
    ShowMessage('Dialog Lists cannot be a Report Item.');
    Exit;
  end;

  lblRISelected.Caption := ReportItemlst.Items.Item[ReportItemlst.ItemIndex].Caption;
  lblRISelectedTyp.Caption := ReportItemlst.Items.Item[ReportItemlst.ItemIndex].SubItems[0];
  Panel5.Visible := True;
  Panel4.Visible := True;

  sl := TStringList.Create;
  try
    try
      RPCBrokerV.tCallV(sl, 'DSIO OCNT GET REPORT ITEM', [oCNT, lblRISelected.Caption, lblRISelectedTyp.Caption]);
      if sl.Count > 0 then
      begin
        for I := 0 to sl.Count - 1 do
        begin
          if Piece(sl[I],U,1) = '3.5' then
          RITitle.Text := Piece(sl[I],U,2)
          else if Piece(sl[I],U,1) = '3.3' then
          RIPrefex.Text := Piece(sl[I],U,2)
          else if Piece(sl[I],U,1) = '3.4' then
          RISuffix.Text := Piece(sl[I],U,2)
          else if Piece(sl[I],U,1) = '3.2' then
          RIVistalabel.Text := Piece(sl[I],U,2)
          else if Piece(sl[I],U,1) = '3.8' then
          begin
            if Piece(sl[I],U,2) = 'TRUE' then
            RIDoNotSave.Checked := True;
          end
          else if Piece(sl[I],U,1) = '3.9' then
          begin
            if Piece(sl[I],U,2) = 'TRUE' then
            RIHide.Checked := True;
          end
          else if Piece(sl[I],U,1) = '3.7' then
          begin
            if Piece(sl[I],U,2) = 'TRUE' then
            RIRequired.Checked := True;
          end;
        end;
      end;
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    sl.Free;
  end;
end;

procedure ToCNTConfiguration.btnRIDeleteClick(Sender: TObject);
var
  sl: TStringList;
  str: string;
begin
  sl := TStringList.Create;
  try
    try
      sl.Add('3.5^');
      sl.Add('3.3^');
      sl.Add('3.4^');
      sl.Add('3.2^');
      sl.Add('3.8^');
      sl.Add('3.9^');
      sl.Add('3.7^');
      str := RPCBrokerV.sCallV('DSIO OCNT SAVE REPORT ITEM', [oCNT, lblRISelected.Caption, lblRISelectedTyp.Caption, sl]);
      if Piece(str,U,1) = '-1' then
      ShowMessage(Piece(str,U,2));
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    sl.Free;
    ClearReportforMain;
  end;
end;

procedure ToCNTConfiguration.btnRIOKClick(Sender: TObject);
var
  sl: TStringList;
  str: string;
begin
  sl := TStringList.Create;
  try
    try
      sl.Add('3.5^' + RITitle.Text);
      sl.Add('3.3^' + RIPrefex.Text);
      sl.Add('3.4^' + RISuffix.Text);
      sl.Add('3.2^' + RIVistalabel.Text);
      sl.Add('3.8^' + BoolToStr(RIDoNotSave.Checked));
      sl.Add('3.9^' + BoolToStr(RIHide.Checked));
      sl.Add('3.7^' + BoolToStr(RIRequired.Checked));
      str := RPCBrokerV.sCallV('DSIO OCNT SAVE REPORT ITEM', [oCNT, lblRISelected.Caption, lblRISelectedTyp.Caption, sl]);
      if Piece(str,U,1) = '-1' then
      ShowMessage(Piece(str,U,2));
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    sl.Free;
    ClearReportforMain;
  end;
end;

procedure ToCNTConfiguration.btnRICancelClick(Sender: TObject);
begin
  ClearReportforMain;
end;

//---------------------------- Dialog Editor Page ------------------------------

procedure ToCNTConfiguration.TabSheet3Show(Sender: TObject);
begin
  if DialogEditList.Count = 0 then
  btnUpdateVistADialogs.Enabled := False;
end;

procedure ToCNTConfiguration.ClearDialogEditor;
var
  I: Integer;
begin
  for I := 0 to DialogEditList.Items.Count - 1 do
  DialogEditList.Selected[I] := False;

  ClearDialogforMain;
  Label6.Visible := False;
end;

procedure ToCNTConfiguration.ClearDialogforMain;
begin
  lblDialogSelected.Caption := '';

  dialogcomplist.Items.Clear;
  ClearDialogforSecondary;
end;

procedure ToCNTConfiguration.ClearDialogforSecondary;
begin
  lblDialogCompSelected.Caption := '';

  LabeledEdit1.Clear;
  LabeledEdit1.Visible := False;
  lstDialogMulti.Clear;
  GroupBox1.Visible := False;
  Memo3.Clear;
  GroupBox2.Visible := False;
  Panel7.Visible := False;
end;

procedure ToCNTConfiguration.DialogEditListDblClick(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
  dlst: TListItem;
  comptyp: string;

  function GetType(ClassName: string): string;
  begin
    if ClassName = 'TDateTimePicker' then
    Result := 'Single'
    else if ClassName = 'TEdit' then
    Result := 'Single'
    else if ClassName = 'TLabeledEdit' then
    Result := 'Single'
    else if ClassName = 'TCheckBox' then
    Result := 'Single'
    else if ClassName = 'TRadioButton' then
    Result := 'Single'
    else if ClassName = 'TRadioGroup' then
    Result := 'Single'
    else if ClassName = 'TSpinEdit' then
    Result := 'Single'
    else if ClassName = 'TButton' then
    Result := '' //button - not supported for dialogs
    else if ClassName = 'TBitBtn' then
    Result := '' //button - not supported for dialogs
    else if ClassName = 'TComboBox' then
    Result := 'Multiple'
    else if ClassName = 'TListBox' then
    Result := 'Multiple'
    else if ClassName = 'TCheckListBox' then
    Result := 'Dialog List'
    else if ClassName = 'TMemo' then
    Result := 'Word Processing'
    else if ClassName = 'TRichEdit' then
    Result := 'Word Processing'
    else if ClassName = 'TJvStringGrid' then
    Result := 'Multiple'
    else Result := '';
  end;

begin
  if DialogEditList.ItemIndex < 0 then Exit;

  ClearDialogforMain;
  lblDialogCompSelected.Caption := '';
  lblDialogSelected.Caption := DialogEditList.Items.Strings[DialogEditList.ItemIndex];

  sl := TStringList.Create;
  try
    try
      sl.AddStrings(GetDialogComponents(DialogEditList.Items.Strings[DialogEditList.ItemIndex]));
      for I := 0 to sl.Count - 1 do
      begin
        comptyp := GetType(Piece(sl[I],U,2));
        if comptyp <> '' then
        begin
          dlst := dialogcomplist.Items.Add;
          dlst.Caption := Piece(sl[I],U,1);
          dlst.SubItems.Add(comptyp);
        end;
      end;
    except
    end;
  finally
    sl.Free;
  end;
end;

procedure ToCNTConfiguration.dialogcomplistDblClick(Sender: TObject);
begin
  if dialogcomplist.ItemIndex < 0 then Exit;

  Label6.Visible := True;
  ClearDialogforSecondary;

  lblDialogCompSelected.Caption := dialogcomplist.Items.Item[dialogcomplist.ItemIndex].Caption;

  if dialogcomplist.Items.Item[dialogcomplist.ItemIndex].SubItems[0] = 'Multi' then
  begin
    GroupBox1.Visible := True;
    GroupBox1.BringToFront;
    GroupBox2.Visible := False;
    LabeledEdit1.Visible := False;
  end
  else if dialogcomplist.Items.Item[dialogcomplist.ItemIndex].SubItems[0] = 'Word Processing' then
  begin
    GroupBox2.Visible := True;
    GroupBox2.BringToFront;
    GroupBox1.Visible := False;
    LabeledEdit1.Visible := False;
  end
  else
  begin
    LabeledEdit1.Visible := True;
    LabeledEdit1.BringToFront;
    GroupBox1.Visible := False;
    GroupBox2.Visible := False;
  end;
  Panel7.Visible := True;
end;

procedure ToCNTConfiguration.btnUpdateVistADialogsClick(Sender: TObject);
var
  sl,controllist: TStringList;
  ct,I: Integer;
  comptyp: string;

  function GetType(ClassName: string): string;
  begin
    if ClassName = 'TDateTimePicker' then
    Result := 'Single'
    else if ClassName = 'TEdit' then
    Result := 'Single'
    else if ClassName = 'TLabeledEdit' then
    Result := 'Single'
    else if ClassName = 'TCheckBox' then
    Result := 'Single'
    else if ClassName = 'TRadioButton' then
    Result := 'Single'
    else if ClassName = 'TRadioGroup' then
    Result := 'Single'
    else if ClassName = 'TSpinEdit' then
    Result := 'Single'
    else if ClassName = 'TButton' then
    Result := '' //button - not supported for dialogs
    else if ClassName = 'TBitBtn' then
    Result := '' //button - not supported for dialogs
    else if ClassName = 'TComboBox' then
    Result := 'Multiple'
    else if ClassName = 'TListBox' then
    Result := 'Multiple'
    else if ClassName = 'TCheckListBox' then
    Result := 'Dialog List'
    else if ClassName = 'TMemo' then
    Result := 'Word Processing'
    else if ClassName = 'TRichEdit' then
    Result := 'Word Processing'
    else if ClassName = 'TJvStringGrid' then
    Result := 'Multiple'
    else Result := '';
  end;

begin
  sl := TStringList.Create;
  controllist := TStringList.Create;
  try
    for ct := 0 to DLLDialogList2.Count - 1 do
    begin
      sl.Clear;
      controllist.Clear;
      try
        sl.AddStrings(GetDialogComponents(Piece(DLLDialogList2[ct],U,1)));
        for I := 0 to sl.Count - 1 do
        begin
          comptyp := GetType(Piece(sl[I],U,2));
          if comptyp <> '' then
          controllist.Add(Piece(sl[I],U,1) + U + comptyp);
        end;

        RPCBrokerV.CallV('DSIO OCNT DIALOG IMPORT', [Piece(DLLDialogList2[ct],U,2),
                          Piece(DLLDialogList2[ct],U,1), controllist]);
      except
      end;
    end;
  finally
    sl.Free;
    controllist.Free;
  end;
end;

procedure ToCNTConfiguration.btnDialogOKClick(Sender: TObject);
begin
  //RPC Save
  ClearDialogforSecondary;
end;

procedure ToCNTConfiguration.btnDialogCancelClick(Sender: TObject);
begin
  ClearDialogforSecondary;
end;

//------------------------------ Shared Methods -------------------------------

function ToCNTConfiguration.GetClass(CompName,CompClass: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ComponentList.Items.Count - 1 do
  begin
    if ComponentList.Items.Item[I].Caption = CompName then
    begin
      if ComponentList.Items.Item[I].SubItems[2] = CompClass then
      Result := True;
      Break;
    end;
  end;
end;

procedure ToCNTConfiguration.UpdateToDialogType(CompDialog,CompContainer: string);
var
  I: Integer;
begin
  //Update the Configuration List
  for I := 0 to ConfigList.Items.Count - 1 do
  begin
    if ConfigList.Items.Item[I].Caption = CompDialog then
    ConfigList.Items.Item[I].SubItems[0] := 'Dialog List';
    if ConfigList.Items.Item[I].Caption = CompContainer then
    ConfigList.Items.Item[I].SubItems[0] := 'Dialog Container';
  end;

  //Update the ReportItem List
  for I := 0 to ReportItemlst.Items.Count - 1 do
  begin
    if ReportItemlst.Items.Item[I].Caption = CompDialog then
    ReportItemlst.Items.Item[I].SubItems[0] := 'Dialog List';
    if ReportItemlst.Items.Item[I].Caption = CompContainer then
    ReportItemlst.Items.Item[I].SubItems[0] := 'Dialog Container';
  end;
end;

procedure ToCNTConfiguration.lstUpClick(Sender: TObject);
var
  I: Integer;
  lstBox: TListBox;
begin
  if not (Sender is TBitBtn) then Exit;

  case TBitBtn(Sender).Tag of
    1 : lstBox := lstMultiListItems;
    2 : lstBox := lstMultiDialogItems;
    3 : lstBox := lstDialogMulti;
  end;

  if lstBox = nil then Exit;
  if lstBox.ItemIndex < 0 then Exit;

  I := lstBox.ItemIndex;
  if I > 0 then
  begin
    lstBox.Items.Exchange(I, I - 1);
    lstBox.ItemIndex := I - 1;
  end;
end;

procedure ToCNTConfiguration.lstDownClick(Sender: TObject);
var
  I: Integer;
  lstBox: TListBox;
begin
  if not (Sender is TBitBtn) then Exit;

  case TBitBtn(Sender).Tag of
    1 : lstBox := lstMultiListItems;
    2 : lstBox := lstMultiDialogItems;
    3 : lstBox := lstDialogMulti;
  end;

  if lstBox = nil then Exit;
  if lstBox.ItemIndex < 0 then Exit;

  I := lstBox.ItemIndex;
  if I < lstBox.Items.Count - 1 then
  begin
    lstBox.Items.Exchange(I, I + 1);
    lstBox.ItemIndex := I + 1;
  end;
end;

procedure ToCNTConfiguration.btnAddMultiItemClick(Sender: TObject);
var
  lstBox: TListBox;
begin
  if not (Sender is TBitBtn) then Exit;

  case TBitBtn(Sender).Tag of
    1 : lstBox := lstMultiListItems;
    3 : lstBox := lstDialogMulti;
  end;
  if lstBox = nil then Exit;

  AddItem := TAddItem.Create(Self);
  try
    AddItem.ShowModal;
    if AddItem.ModalResult = mrOk then
    lstBox.Items.Add(AddItem.Edit1.Text);
  finally
    AddItem.Free;
  end;
end;

procedure ToCNTConfiguration.btnDeleteMultiItemClick(Sender: TObject);
var
  lstBox: TListBox;
begin
  if not (Sender is TBitBtn) then Exit;

  case TBitBtn(Sender).Tag of
    1 : lstBox := lstMultiListItems;
    3 : lstBox := lstDialogMulti;
  end;
  if lstBox = nil then Exit;
  if lstBox.ItemIndex < 0 then Exit;

  if MessageDlg('Are you sure you want to delete this entry?' + #13#13 +
                 '"' + lstBox.Items.Strings[lstbox.ItemIndex] + '"',
                 mtWarning, [mbYes,mbNo], 0) = mrYes then
                 lstBox.Items.Delete(lstBox.ItemIndex);
end;

procedure ToCNTConfiguration.lstMultiListItemsDblClick(Sender: TObject);
begin
  if not (Sender is TListBox) then Exit;

  if TListBox(Sender).ItemIndex < 0 then Exit;

  AddItem := TAddItem.Create(Self);
  try
    AddItem.Edit1.Text := TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex];
    AddItem.ShowModal;
    if AddItem.ModalResult = mrOk then
    begin
      TListBox(Sender).Items.Delete(TListBox(Sender).ItemIndex);
      TListBox(Sender).Items.Add(AddItem.Edit1.Text);
    end;
  finally
    AddItem.Free;
  end;
end;

procedure ToCNTConfiguration.ListColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end else Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure ToCNTConfiguration.ListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then
  Compare := CompareText(Item1.Caption, Item2.Caption)
  else if SortedColumn <> 0 then
  Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
  if Descending then Compare := -Compare;
end;

procedure ToCNTConfiguration.ShowDialog(Sender: TObject);
var
  lstbox: TListBox;
  dlgName: string;
  sl: TStringList;
begin
  if Sender is TListBox then
  lstbox := TListBox(Sender)
  else if Sender is TBitBtn then
  lstbox := DialogEditList
  else Exit;

  if lstbox.ItemIndex < 0 then Exit;

  dlgName := lstbox.Items.Strings[lstbox.ItemIndex];

  if DialogDLL <> 0 then
  begin
    sl := TStringList.Create;
    try
      try
        sl.AddStrings(DisplayDialog(@RPCBrokerV, dlgName, True));
      except
        on E: Exception do
        ShowMessage(E.Message);
      end;
    finally
      sl.Free;
    end;
  end;
end;

end.
