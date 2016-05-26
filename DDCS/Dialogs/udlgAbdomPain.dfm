object dlgAbdomPain: TdlgAbdomPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Abdominal Pain and Cramping'
  ClientHeight = 179
  ClientWidth = 521
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
  object Label3: TLabel
    Left = 21
    Top = 51
    Width = 78
    Height = 14
    Caption = 'Contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 260
    Top = 20
    Width = 154
    Height = 14
    Caption = 'Nausea, Vomiting, Diarrhea?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 260
    Top = 44
    Width = 54
    Height = 14
    Caption = 'Appetite?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 260
    Top = 68
    Width = 110
    Height = 14
    Caption = 'Fever and or Chills?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbonset: TLabel
    Left = 21
    Top = 21
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
  object lbFreq: TLabel
    Left = 21
    Top = 80
    Width = 58
    Height = 14
    Caption = 'Frequency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbDur: TLabel
    Left = 21
    Top = 115
    Width = 46
    Height = 14
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbloc: TLabel
    Left = 260
    Top = 99
    Width = 47
    Height = 14
    Caption = 'Location'
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
    Top = 150
    Width = 521
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 12
    object bbtnOK: TBitBtn
      Left = 363
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
      Left = 444
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
  object leOnset: TEdit
    Left = 62
    Top = 18
    Width = 165
    Height = 22
    TabOrder = 0
  end
  object leLocat: TEdit
    Left = 317
    Top = 96
    Width = 186
    Height = 22
    TabOrder = 11
  end
  object leFreq: TEdit
    Left = 89
    Top = 77
    Width = 138
    Height = 22
    TabOrder = 3
    Visible = False
  end
  object leDur: TEdit
    Left = 89
    Top = 112
    Width = 138
    Height = 22
    TabOrder = 4
    Visible = False
  end
  object cbContYes: TCheckBox
    Tag = 1
    Left = 109
    Top = 51
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = cbContYesClick
  end
  object cbContNo: TCheckBox
    Tag = 2
    Left = 155
    Top = 51
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = cbContYesClick
  end
  object cbNausYes: TCheckBox
    Tag = 3
    Left = 422
    Top = 20
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    OnClick = cbContYesClick
  end
  object cbNausNo: TCheckBox
    Tag = 4
    Left = 467
    Top = 20
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    OnClick = cbContYesClick
  end
  object cbAppYes: TCheckBox
    Tag = 5
    Left = 422
    Top = 44
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 7
    OnClick = cbContYesClick
  end
  object cbAppNo: TCheckBox
    Tag = 6
    Left = 467
    Top = 44
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 8
    OnClick = cbContYesClick
  end
  object cbFevYes: TCheckBox
    Tag = 7
    Left = 422
    Top = 68
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 9
    OnClick = cbContYesClick
  end
  object cbFevNo: TCheckBox
    Tag = 8
    Left = 467
    Top = 68
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 10
    OnClick = cbContYesClick
  end
end
