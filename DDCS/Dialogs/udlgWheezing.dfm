object dlgWheezing: TdlgWheezing
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Wheezing'
  ClientHeight = 176
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TStaticText
    Left = 13
    Top = 41
    Width = 122
    Height = 18
    Caption = 'Shortness of breath?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 147
    Width = 265
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 9
    object bbtnOK: TBitBtn
      Left = 108
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
      Left = 189
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
    Left = 66
    Top = 8
    Width = 187
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leAssocSym: TCaptionEdit
    Left = 13
    Top = 118
    Width = 240
    Height = 22
    Align = alCustom
    Anchors = [akLeft, akBottom]
    TabOrder = 8
    Caption = 'Associated Symptoms'
  end
  object leDur: TCaptionEdit
    Left = 66
    Top = 67
    Width = 187
    Height = 22
    TabOrder = 6
    Visible = False
    Caption = 'Duration'
  end
  object cbSOBY: TCheckBox
    Tag = 1
    Left = 158
    Top = 41
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = checkboxClick
  end
  object cbSOBN: TCheckBox
    Tag = 2
    Left = 207
    Top = 41
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = checkboxClick
  end
  object lbDur: TStaticText
    Left = 13
    Top = 71
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object lbAssociatedSymp: TStaticText
    Left = 13
    Top = 100
    Width = 129
    Height = 18
    Align = alCustom
    Anchors = [akLeft, akBottom]
    Caption = 'Associated Symptoms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object StaticText3: TStaticText
    Left = 13
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
end
