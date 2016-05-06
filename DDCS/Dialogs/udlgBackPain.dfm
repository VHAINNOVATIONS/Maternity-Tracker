object dlgBackPain: TdlgBackPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 200
  ClientWidth = 558
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
  object Label3: TLabel
    Left = 233
    Top = 86
    Width = 43
    Height = 14
    Caption = 'Dysuria?'
  end
  object Label1: TLabel
    Left = 234
    Top = 114
    Width = 61
    Height = 14
    Caption = 'Fever/chills?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 558
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
      Width = 80
      Height = 20
      Caption = 'Back pain'
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
    Top = 171
    Width = 558
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
    object bbtnOK: TBitBtn
      Left = 400
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 481
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 63
    Top = 50
    Width = 137
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leChar: TLabeledEdit
    Left = 63
    Top = 134
    Width = 137
    Height = 22
    EditLabel.Width = 51
    EditLabel.Height = 14
    EditLabel.Caption = 'Character:'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object leLocat: TLabeledEdit
    Left = 63
    Top = 106
    Width = 137
    Height = 22
    EditLabel.Width = 44
    EditLabel.Height = 14
    EditLabel.Caption = 'Location:'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object leDur: TLabeledEdit
    Left = 63
    Top = 78
    Width = 137
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object leUrin: TLabeledEdit
    Left = 371
    Top = 50
    Width = 156
    Height = 22
    EditLabel.Width = 134
    EditLabel.Height = 14
    EditLabel.Caption = 'Urinary frequency/urgency:'
    LabelPosition = lpLeft
    TabOrder = 5
  end
  object cbDysY: TCheckBox
    Tag = 1
    Left = 332
    Top = 85
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = cbDysYClick
  end
  object cbDysN: TCheckBox
    Tag = 2
    Left = 380
    Top = 85
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = cbDysYClick
  end
  object cbFeverY: TCheckBox
    Tag = 3
    Left = 332
    Top = 113
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = cbDysYClick
  end
  object cbFeverN: TCheckBox
    Tag = 4
    Left = 380
    Top = 113
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = cbDysYClick
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 501
    Top = 40
    Data = (
      (
        'Component = dlgBackPain'
        'Status = stsDefault'))
  end
end
