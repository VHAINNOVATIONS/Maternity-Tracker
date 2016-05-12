object dlgAbdomPain: TdlgAbdomPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Abdominal Pain and Cramping'
  ClientHeight = 179
  ClientWidth = 537
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
    Left = 21
    Top = 51
    Width = 82
    Height = 18
    Caption = 'Contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Label1: TStaticText
    Left = 260
    Top = 20
    Width = 159
    Height = 18
    Caption = 'Nausea, Vomiting, Diarrhea?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object Label4: TStaticText
    Left = 260
    Top = 44
    Width = 58
    Height = 18
    Caption = 'Appetite?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object Label5: TStaticText
    Left = 260
    Top = 68
    Width = 114
    Height = 18
    Caption = 'Fever and or Chills?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 150
    Width = 537
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 20
    object bbtnOK: TBitBtn
      Left = 379
      Top = 2
      Width = 75
      Height = 25
      Align = alCustom
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 460
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
    Left = 64
    Top = 18
    Width = 163
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leLocat: TCaptionEdit
    Left = 317
    Top = 96
    Width = 186
    Height = 22
    TabOrder = 19
    Caption = 'Location'
  end
  object leFreq: TCaptionEdit
    Left = 89
    Top = 77
    Width = 138
    Height = 22
    TabOrder = 6
    Visible = False
    Caption = 'Frequency'
  end
  object leDur: TCaptionEdit
    Left = 89
    Top = 112
    Width = 138
    Height = 22
    TabOrder = 8
    Visible = False
    Caption = 'Duration'
  end
  object cbContYes: TCheckBox
    Tag = 1
    Left = 109
    Top = 52
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = cbContYesClick
  end
  object cbContNo: TCheckBox
    Tag = 2
    Left = 171
    Top = 52
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = cbContYesClick
  end
  object cbNausYes: TCheckBox
    Tag = 3
    Left = 419
    Top = 21
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 10
    OnClick = cbContYesClick
  end
  object cbNausNo: TCheckBox
    Tag = 4
    Left = 467
    Top = 21
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 11
    OnClick = cbContYesClick
  end
  object cbAppYes: TCheckBox
    Tag = 5
    Left = 419
    Top = 45
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 13
    OnClick = cbContYesClick
  end
  object cbAppNo: TCheckBox
    Tag = 6
    Left = 467
    Top = 45
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 14
    OnClick = cbContYesClick
  end
  object cbFevYes: TCheckBox
    Tag = 7
    Left = 419
    Top = 69
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 16
    OnClick = cbContYesClick
  end
  object cbFevNo: TCheckBox
    Tag = 8
    Left = 467
    Top = 69
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 17
    OnClick = cbContYesClick
  end
  object StaticText1: TStaticText
    Left = 21
    Top = 21
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
  object lbFreq: TStaticText
    Left = 21
    Top = 81
    Width = 62
    Height = 18
    Caption = 'Frequency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object lbDur: TStaticText
    Left = 21
    Top = 116
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object StaticText4: TStaticText
    Left = 260
    Top = 100
    Width = 51
    Height = 18
    Caption = 'Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
  end
end
