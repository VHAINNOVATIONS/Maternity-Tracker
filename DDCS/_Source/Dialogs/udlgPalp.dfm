object dlgPalp: TdlgPalp
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 169
  ClientWidth = 551
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
  object Label1: TLabel
    Left = 363
    Top = 115
    Width = 92
    Height = 14
    Caption = '(dizziness/fainting)'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 551
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
      Width = 95
      Height = 20
      Caption = 'Palpitations'
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
    Top = 140
    Width = 551
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object bbtnOK: TBitBtn
      Left = 393
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 474
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 68
    Top = 50
    Width = 147
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leDur: TLabeledEdit
    Left = 68
    Top = 87
    Width = 147
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object leAssoc: TLabeledEdit
    Left = 363
    Top = 87
    Width = 156
    Height = 22
    EditLabel.Width = 110
    EditLabel.Height = 14
    EditLabel.Caption = 'Associated symptoms:'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object leFreq: TLabeledEdit
    Left = 363
    Top = 50
    Width = 156
    Height = 22
    EditLabel.Width = 55
    EditLabel.Height = 14
    EditLabel.Caption = 'Frequency:'
    LabelPosition = lpLeft
    TabOrder = 3
  end
end
