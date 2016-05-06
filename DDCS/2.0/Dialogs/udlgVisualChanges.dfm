object dlgVisualChanges: TdlgVisualChanges
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 207
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel
    Left = 7
    Top = 101
    Width = 51
    Height = 14
    Caption = 'Character:'
  end
  object Label3: TLabel
    Left = 14
    Top = 140
    Width = 44
    Height = 14
    Caption = 'Location:'
  end
  object Label1: TLabel
    Left = 274
    Top = 53
    Width = 110
    Height = 14
    Caption = 'Associated symptoms:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 542
    Height = 33
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 126
      Height = 20
      Caption = 'Visual Changes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 178
    Width = 542
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    object bbtnOK: TBitBtn
      Left = 384
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 465
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 64
    Top = 59
    Width = 161
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leOther: TLabeledEdit
    Left = 320
    Top = 98
    Width = 192
    Height = 22
    EditLabel.Width = 30
    EditLabel.Height = 14
    EditLabel.Caption = 'Other:'
    LabelPosition = lpLeft
    TabOrder = 6
  end
  object leDur: TLabeledEdit
    Left = 320
    Top = 137
    Width = 192
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 7
  end
  object cmbChar: TComboBox
    Left = 64
    Top = 98
    Width = 161
    Height = 22
    TabOrder = 2
  end
  object cmbLoc: TComboBox
    Left = 64
    Top = 137
    Width = 161
    Height = 22
    TabOrder = 3
  end
  object cbVisCh: TCheckBox
    Left = 320
    Top = 72
    Width = 97
    Height = 17
    Caption = 'Visual Changes'
    TabOrder = 4
  end
  object cbNaus: TCheckBox
    Left = 433
    Top = 72
    Width = 61
    Height = 17
    Caption = 'Nausea'
    TabOrder = 5
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = dlgVisualChanges'
        'Status = stsDefault'))
  end
end
