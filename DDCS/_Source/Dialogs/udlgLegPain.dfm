object dlgLegPain: TdlgLegPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 149
  ClientWidth = 283
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 283
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
      Width = 142
      Height = 20
      Caption = 'Leg Pain/Swelling'
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
    Top = 120
    Width = 283
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object bbtnOK: TBitBtn
      Left = 125
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 206
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 56
    Top = 53
    Width = 201
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leDur: TLabeledEdit
    Left = 56
    Top = 86
    Width = 201
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
end
