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
  object lbonset: TLabel
    Left = 13
    Top = 15
    Width = 33
    Height = 14
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbdur: TLabel
    Left = 13
    Top = 51
    Width = 46
    Height = 14
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbfrequency: TLabel
    Left = 13
    Top = 87
    Width = 58
    Height = 14
    Caption = 'Frequency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbsymptoms: TLabel
    Left = 13
    Top = 124
    Width = 125
    Height = 14
    Caption = 'Associated Symptoms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 192
    Width = 241
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
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
  object leOnset: TEdit
    Left = 81
    Top = 12
    Width = 147
    Height = 22
    TabOrder = 0
  end
  object leDur: TEdit
    Left = 81
    Top = 48
    Width = 147
    Height = 22
    TabOrder = 1
  end
  object leAssoc: TEdit
    Left = 13
    Top = 143
    Width = 215
    Height = 22
    TabOrder = 3
  end
  object leFreq: TEdit
    Left = 81
    Top = 84
    Width = 147
    Height = 22
    TabOrder = 2
  end
end
