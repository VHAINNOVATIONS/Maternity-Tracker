object frmFamilyAdd: TfrmFamilyAdd
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  ClientHeight = 97
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 68
    Width = 356
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      356
      29)
    object bbtnOK: TBitBtn
      Left = 197
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 278
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 321
    Height = 21
    EditLabel.Width = 294
    EditLabel.Height = 13
    EditLabel.Caption = 'New Associated Person Name (LastName,FirstName)'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    TabOrder = 0
  end
end
