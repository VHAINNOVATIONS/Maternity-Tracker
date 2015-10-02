object dlgAbdomPain: TdlgAbdomPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 214
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
  object Label3: TLabel
    Left = 10
    Top = 81
    Width = 67
    Height = 14
    Caption = 'Contractions?'
  end
  object Label1: TLabel
    Left = 270
    Top = 53
    Width = 130
    Height = 14
    Caption = 'Nausea/Vomiting/Diarrhea?'
  end
  object Label4: TLabel
    Left = 270
    Top = 76
    Width = 46
    Height = 14
    Caption = 'Appetite?'
  end
  object Label5: TLabel
    Left = 270
    Top = 99
    Width = 61
    Height = 14
    Caption = 'Fever/chills?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 537
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
      Width = 206
      Height = 20
      Caption = 'Abdominal Pain/Cramping'
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
    Top = 185
    Width = 537
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 13
    object bbtnOK: TBitBtn
      Left = 378
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 459
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 44
    Top = 50
    Width = 163
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leLocat: TLabeledEdit
    Left = 316
    Top = 141
    Width = 172
    Height = 22
    EditLabel.Width = 44
    EditLabel.Height = 14
    EditLabel.Caption = 'Location:'
    LabelPosition = lpLeft
    TabOrder = 12
  end
  object leFreq: TLabeledEdit
    Left = 77
    Top = 107
    Width = 130
    Height = 22
    EditLabel.Width = 55
    EditLabel.Height = 14
    EditLabel.Caption = 'Frequency:'
    LabelPosition = lpLeft
    TabOrder = 4
    Visible = False
  end
  object leDur: TLabeledEdit
    Left = 64
    Top = 141
    Width = 143
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 5
    Visible = False
  end
  object cbContYes: TCheckBox
    Tag = 1
    Left = 81
    Top = 80
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 2
    OnClick = cbContYesClick
  end
  object cbContNo: TCheckBox
    Tag = 2
    Left = 129
    Top = 80
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 3
    OnClick = cbContYesClick
  end
  object cbNausYes: TCheckBox
    Tag = 3
    Left = 419
    Top = 52
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = cbContYesClick
  end
  object cbNausNo: TCheckBox
    Tag = 4
    Left = 467
    Top = 52
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = cbContYesClick
  end
  object cbAppYes: TCheckBox
    Tag = 5
    Left = 419
    Top = 75
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = cbContYesClick
  end
  object cbAppNo: TCheckBox
    Tag = 6
    Left = 467
    Top = 75
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = cbContYesClick
  end
  object cbFevYes: TCheckBox
    Tag = 7
    Left = 419
    Top = 98
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 10
    OnClick = cbContYesClick
  end
  object cbFevNo: TCheckBox
    Tag = 8
    Left = 467
    Top = 98
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 11
    OnClick = cbContYesClick
  end
end
