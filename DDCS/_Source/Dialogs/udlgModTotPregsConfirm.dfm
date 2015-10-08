object dlgModTotPregsConfirm: TdlgModTotPregsConfirm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Confirmation'
  ClientHeight = 101
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    276
    101)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 260
    Height = 44
    Anchors = [akLeft, akRight]
    Shape = bsFrame
  end
  object Button1: TButton
    Left = 8
    Top = 61
    Width = 97
    Height = 34
    Caption = 'Delete Data'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 171
    Top = 61
    Width = 97
    Height = 34
    Anchors = [akRight]
    Cancel = True
    Caption = 'Cancel Action'
    ModalResult = 2
    TabOrder = 2
    WordWrap = True
  end
  object LabeledEdit1: TLabeledEdit
    Left = 204
    Top = 18
    Width = 47
    Height = 21
    EditLabel.Width = 179
    EditLabel.Height = 13
    EditLabel.Caption = 'Indicate which pregnancy to DELETE:'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 0
  end
end
