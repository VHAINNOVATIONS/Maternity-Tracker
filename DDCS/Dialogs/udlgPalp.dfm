object dlgPalp: TdlgPalp
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Palpitations'
  ClientHeight = 221
  ClientWidth = 241
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
    Left = 136
    Top = 167
    Width = 92
    Height = 14
    Caption = '(dizziness/fainting)'
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 192
    Width = 241
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    object bbtnOK: TBitBtn
      Left = 84
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 165
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TCaptionEdit
    Left = 81
    Top = 12
    Width = 147
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leDur: TCaptionEdit
    Left = 81
    Top = 48
    Width = 147
    Height = 22
    TabOrder = 3
    Caption = 'Duration'
  end
  object leAssoc: TCaptionEdit
    Left = 13
    Top = 143
    Width = 215
    Height = 22
    TabOrder = 7
    Caption = 'Associated symptoms such as dizziness and fainting'
  end
  object leFreq: TCaptionEdit
    Left = 81
    Top = 84
    Width = 147
    Height = 22
    TabOrder = 5
    Caption = 'Frequency'
  end
  object StaticText1: TStaticText
    Left = 38
    Top = 16
    Width = 37
    Height = 18
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 25
    Top = 52
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object StaticText3: TStaticText
    Left = 13
    Top = 88
    Width = 62
    Height = 18
    Caption = 'Frequency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object StaticText4: TStaticText
    Left = 13
    Top = 124
    Width = 129
    Height = 18
    Caption = 'Associated Symptoms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
end
