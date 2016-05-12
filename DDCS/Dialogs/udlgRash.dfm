object dlgRash: TdlgRash
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Rash and Itching'
  ClientHeight = 130
  ClientWidth = 287
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
  object Label3: TStaticText
    Left = 15
    Top = 72
    Width = 48
    Height = 18
    Caption = 'Itching?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 101
    Width = 287
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    object bbtnOK: TBitBtn
      Left = 129
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
      Left = 210
      Top = 2
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
    Left = 70
    Top = 9
    Width = 206
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leLocat: TCaptionEdit
    Left = 70
    Top = 40
    Width = 206
    Height = 22
    TabOrder = 3
    Caption = 'Location'
  end
  object cbItchY: TCheckBox
    Tag = 1
    Left = 70
    Top = 72
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    OnClick = checkboxClick
  end
  object cbItchN: TCheckBox
    Tag = 2
    Left = 119
    Top = 72
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    OnClick = checkboxClick
  end
  object StaticText1: TStaticText
    Left = 15
    Top = 13
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
    Left = 15
    Top = 44
    Width = 51
    Height = 18
    Caption = 'Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
end
