object dlgLegPain: TdlgLegPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Leg Pain and Swelling'
  ClientHeight = 94
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 65
    Width = 283
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object bbtnOK: TBitBtn
      Left = 125
      Top = 2
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
      Left = 206
      Top = 2
      Width = 75
      Height = 25
      Align = alCustom
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TCaptionEdit
    Left = 69
    Top = 8
    Width = 201
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leDur: TCaptionEdit
    Left = 69
    Top = 36
    Width = 201
    Height = 22
    TabOrder = 3
    Caption = 'Duration'
  end
  object StaticText1: TStaticText
    Left = 11
    Top = 12
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
    Left = 11
    Top = 40
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
end
