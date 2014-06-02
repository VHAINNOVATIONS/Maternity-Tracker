unit oCNTBaseEditor;

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
  DesignIntf, DesignEditors, frmReportOrder, Classes, Controls, uReportItems;

type
  ToFormEditor = class(TComponentEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  ToPageEditor = class(TComponentEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  type
    TReportOrderEditor = class(TPropertyEditor)
      public
        procedure Edit; override;
        function GetAttributes: TPropertyAttributes; override;
        function GetValue: string; override;
  end;

  procedure Register;

implementation

uses
  oCNTBase;

{ ToFormEditor }
// Called when component of this type is right-clicked. It's where
// you actually perform the action. The component editor is passed a reference
// to the component as "Component", which you need to cast to your specific
// component type
procedure ToFormEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    0: begin
         (Component as ToForm).AddPage;
         Designer.Modified;
       end;
//    1: begin
//         (Component as ToForm).DeletePage;
//         Designer.Modified;
//       end;
//    2: begin
//       end;
//    3: begin
//       end;
  end;
end;

// Called the number of times you've stated you need in GetVerbCount.
// This is where you add your pop-up menu items
function ToFormEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Insert Page';
//    1: Result := 'Delete Page';
//    2: Result := 'Next Page';
//    3: Result := 'Previous Page';
  end;
end;

// Called when the IDE needs to populate the menu. Return the number
// of items you intend to add to the menu.
function ToFormEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ ToPageEditor }
procedure ToPageEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    0: begin
         (Component as ToForm).AddPage;
         Designer.Modified;
       end;
    1: begin
         (Component as ToPage).Destroy;
//         Designer.Modified;
       end;
//    2: begin
//       end;
//    3: begin
//       end;
  end;
end;

// Called the number of times you've stated you need in GetVerbCount.
// This is where you add your pop-up menu items
function ToPageEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Insert Page';
    1: Result := 'Delete Page';
//    2: Result := 'Next Page';
//    3: Result := 'Previous Page';
  end;
end;

// Called when the IDE needs to populate the menu. Return the number
// of items you intend to add to the menu.
function ToPageEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TReportOrderEditor }
procedure TReportOrderEditor.Edit;
var
  I: Integer;
  Main: ToForm;
  ItemObj: TObject;
  Item: TNoteItem;
begin
  Main := ToForm(Self.GetComponent(0));
  for I := 0 to Main.ReportCollection.Count - 1 do
  begin
    ItemObj := Main.ReportCollection.Items[I].OwningObject;
    ReportOrderDlg.ListBox1.AddItem(TWinControl(ItemObj).Name, ItemObj);
  end;
  ReportOrderDlg.ShowModal;
  if ReportOrderDlg.ModalResult = mrOK then
  begin
    for I := 0 to ReportOrderDlg.ListBox1.Count - 1 do
    begin
      Item := Main.ReportCollection.GetItem(TWinControl(ReportOrderDlg.ListBox1.Items.Objects[I]));
      Item.SetIndex(I);
    end;
  end;
  ReportOrderDlg.ListBox1.Clear;
end;

function TReportOrderEditor.GetAttributes: TPropertyAttributes;
begin
  //Makes the small button show to the right of the property
  Result := [paDialog];
end;

function TReportOrderEditor.GetValue: String;
begin
  //Returns the string which should show in Object Inspector
  Result := '(Reorder Report Items)';
end;

procedure Register;
begin
  RegisterComponentEditor(ToForm, ToFormEditor);
  RegisterComponentEditor(ToPage, ToPageEditor);
  RegisterPropertyEditor(TypeInfo(TStringList), ToForm, 'ReportOrder', TReportOrderEditor);
end;

end.
