unit frmPageEditor;

interface

uses
  Windows, SysUtils, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs;

type
  TPageEditorDlg = class(TForm)
    EditButton: TButton;
    AddButton: TButton;
    DeleteButton: TButton;
    CloseButton: TBitBtn;
    DownButton: TBitBtn;
    UpButton: TBitBtn;
    ListBox1: TListBox;
    lbHeader: THeader;
    procedure MoveClick(Sender: TObject);
    procedure EditClick(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private                                        { Private declarations }
    PageList: TStrings;
  public                                         { Public declarations }
    Modified: Boolean;
    procedure SetPageList(Value: TStrings);
  end;

implementation

{$R *.DFM}

procedure TPageEditorDlg.SetPageList(Value: TStrings);
begin
  PageList := Value;
  ListBox1.Items.Assign(Value);
end;

procedure TPageEditorDlg.MoveClick(Sender: TObject);
var
  NewIndex: Integer;
begin
  if ListBox1.ItemIndex >= 0 then begin
    NewIndex := ListBox1.ItemIndex;
    if Sender = UpButton then Dec(NewIndex)
    else Inc(NewIndex);
    if (NewIndex >= 0) and (NewIndex < PageList.Count) then
    begin
      PageList.Move(ListBox1.ItemIndex, NewIndex);
      ListBox1.ItemIndex := NewIndex;
      ListBox1.Invalidate;

      if Sender = UpButton then
      ListBox1.Items.Exchange (NewIndex+1, NewIndex)
      else
      ListBox1.Items.Exchange (NewIndex-1, NewIndex);

    end;
    ListBox1.SetFocus;
    Modified := True;
  end;
end;

procedure TPageEditorDlg.EditClick(Sender: TObject);
//var
//  D: TCntPageInfoDlg;
//  W: TWinControl;
begin
//  { edit the current entry }
//  D := TCntPageInfoDlg.Create(Application);
//  try
//    W := PageList.Objects[ListBox1.ItemIndex] as TWinControl;
//
//    D.Caption := 'Edit Page';
//    D.PageName := PageList[ListBox1.ItemIndex];
//    D.PageContext := W.HelpContext;
//    D.HelpContext := 0;
//    if D.ShowModal = mrOK then
//    begin
//      ListBox1.Items[ListBox1.ItemIndex] := D.PageName;
//
//      PageList[ListBox1.ItemIndex] := D.PageName;
//
//      W.HelpContext := D.PageContext;
//      ListBox1.Invalidate;
//      Modified := True;
//    end;
//  finally
//    D.Free;
//  end;
end;

procedure TPageEditorDlg.AddClick(Sender: TObject);
//var
//  D: TCntPageInfoDlg;
//  W: TWinControl;
begin
//  { add a new entry }
//  D := TCntPageInfoDlg.Create(Application);
//  try
//    D.Caption := 'Add Page';
//    D.PageName := '';
//    D.PageContext := 0;
//    D.HelpContext := 0;
//
//    if D.ShowModal = mrOK then
//    begin
//      if D.PageName = EmptyStr then
//      Exit;
//
//      PageList.Add(D.PageName);
//      ListBox1.Items.AddObject(D.PageName, Pointer(D.PageContext));
//      W := PageList.Objects[PageList.Count - 1] as TWinControl;
//      W.HelpContext := 0;
//      ListBox1.Invalidate;;
//      Modified := True;
//    end;
//  finally
//    D.Free;
//  end;
end;

procedure TPageEditorDlg.DeleteClick(Sender: TObject);
begin
  if ListBox1.Items.Count = 1 then
  Exit;

  if MessageDlg(Format('Delete page, %s', [ListBox1.Items[ListBox1.ItemIndex]]), mtConfirmation,
  [mbYes, mbNo], 0) = mrYes then
  begin
    PageList.Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    ListBox1.Invalidate;
    Modified := True;
  end;
end;

procedure TPageEditorDlg.ListBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  s: String;
  si: String;
begin
  s := ListBox1.Items[Index];
  si := IntToStr(Longint(ListBox1.Items.Objects[Index]));
  ListBox1.Canvas.FillRect(Rect);
  Rect.Right := lbHeader.SectionWidth[0];
  DrawText(ListBox1.Canvas.Handle, PChar(s), Length(s), Rect, dt_left or dt_vcenter);
  Rect.Left := Rect.Right;
  DrawText(ListBox1.Canvas.Handle, PChar(si), Length(si), Rect, dt_left or dt_vcenter);
end;

end.
