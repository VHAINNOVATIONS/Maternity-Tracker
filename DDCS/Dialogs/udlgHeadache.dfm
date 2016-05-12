object dlgHeadache: TdlgHeadache
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Headache'
  ClientHeight = 178
  ClientWidth = 540
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
    Left = 231
    Top = 70
    Width = 76
    Height = 18
    Caption = 'Treatments?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 149
    Width = 540
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 15
    object bbtnOK: TBitBtn
      Left = 382
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
      Left = 463
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
    Left = 76
    Top = 12
    Width = 137
    Height = 22
    TabOrder = 1
    Caption = 'Time of onset'
  end
  object leChar: TCaptionEdit
    Left = 76
    Top = 45
    Width = 137
    Height = 22
    TabOrder = 3
    Caption = 'Character'
  end
  object leLocat: TCaptionEdit
    Left = 76
    Top = 79
    Width = 137
    Height = 22
    TabOrder = 5
    Caption = 'Localization'
  end
  object leDur: TCaptionEdit
    Left = 76
    Top = 115
    Width = 137
    Height = 22
    TabOrder = 7
    Caption = 'Duration'
  end
  object leAssoc: TCaptionEdit
    Left = 231
    Top = 35
    Width = 293
    Height = 22
    TabOrder = 9
    Caption = 'Associated Symptoms'
  end
  object leWhat: TCaptionEdit
    Left = 231
    Top = 115
    Width = 293
    Height = 22
    TabOrder = 14
    Visible = False
    Caption = 'What was used? What was the effectiveness?'
  end
  object cbTreatYes: TCheckBox
    Tag = 1
    Left = 317
    Top = 70
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = cbTreatYesClick
  end
  object cbTreatNo: TCheckBox
    Tag = 2
    Left = 366
    Top = 70
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = cbTreatYesClick
  end
  object lbWhat: TStaticText
    Left = 231
    Top = 97
    Width = 258
    Height = 18
    Caption = 'What was used? What was the effectiveness?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    Visible = False
  end
  object StaticText2: TStaticText
    Left = 231
    Top = 16
    Width = 129
    Height = 18
    Caption = 'Associated Symptoms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object StaticText3: TStaticText
    Left = 17
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
  object StaticText4: TStaticText
    Left = 17
    Top = 49
    Width = 58
    Height = 18
    Caption = 'Character'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object StaticText5: TStaticText
    Left = 17
    Top = 83
    Width = 51
    Height = 18
    Caption = 'Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object StaticText6: TStaticText
    Left = 17
    Top = 119
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
end
