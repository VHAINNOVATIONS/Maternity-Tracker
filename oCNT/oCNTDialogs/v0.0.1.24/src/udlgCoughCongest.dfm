object dlgCoughCongest: TdlgCoughCongest
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 215
  ClientWidth = 528
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
    Left = 9
    Top = 85
    Width = 91
    Height = 14
    Caption = 'Productive Cough?'
  end
  object lbBlood: TLabel
    Left = 66
    Top = 147
    Width = 33
    Height = 14
    Caption = 'Blood?'
    Visible = False
  end
  object Label5: TLabel
    Left = 286
    Top = 50
    Width = 80
    Height = 14
    Caption = 'Post-Nasal Drip?'
  end
  object Label1: TLabel
    Left = 286
    Top = 73
    Width = 56
    Height = 14
    Caption = 'Sinus Pain?'
  end
  object Label2: TLabel
    Left = 286
    Top = 96
    Width = 59
    Height = 14
    Caption = 'Rhinorrhea?'
  end
  object Label6: TLabel
    Left = 286
    Top = 121
    Width = 62
    Height = 14
    Caption = 'Fever/Chills?'
  end
  object Label7: TLabel
    Left = 286
    Top = 145
    Width = 104
    Height = 14
    Caption = 'Shortness of Breath?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 528
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
      Width = 149
      Height = 20
      Caption = 'Cough/Congestion'
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
    Top = 186
    Width = 528
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 17
    object bbtnOK: TBitBtn
      Left = 370
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 451
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 45
    Top = 50
    Width = 161
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leColor: TLabeledEdit
    Left = 45
    Top = 112
    Width = 161
    Height = 22
    EditLabel.Width = 28
    EditLabel.Height = 14
    EditLabel.Caption = 'Color:'
    LabelPosition = lpLeft
    TabOrder = 4
    Visible = False
  end
  object cbProdCY: TCheckBox
    Tag = 1
    Left = 105
    Top = 85
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 2
    OnClick = cbProdCYClick
  end
  object cbProdCN: TCheckBox
    Tag = 2
    Left = 158
    Top = 85
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 3
    OnClick = cbProdCYClick
  end
  object cbBloodY: TCheckBox
    Tag = 1
    Left = 105
    Top = 147
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    Visible = False
    OnClick = cbBloodYClick
  end
  object cbBloodN: TCheckBox
    Tag = 2
    Left = 158
    Top = 147
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    Visible = False
    OnClick = cbBloodYClick
  end
  object cbNasalY: TCheckBox
    Tag = 1
    Left = 407
    Top = 50
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 7
    OnClick = cbNasalYClick
  end
  object cbNasalN: TCheckBox
    Tag = 2
    Left = 460
    Top = 50
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 8
    OnClick = cbNasalYClick
  end
  object cbSinusY: TCheckBox
    Tag = 3
    Left = 407
    Top = 73
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 9
    OnClick = cbNasalYClick
  end
  object cbSinusN: TCheckBox
    Tag = 4
    Left = 460
    Top = 73
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 10
    OnClick = cbNasalYClick
  end
  object cbRhinY: TCheckBox
    Tag = 5
    Left = 407
    Top = 96
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = cbNasalYClick
  end
  object cbRhinN: TCheckBox
    Tag = 6
    Left = 460
    Top = 96
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = cbNasalYClick
  end
  object cbFeverY: TCheckBox
    Tag = 7
    Left = 407
    Top = 121
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 13
    OnClick = cbNasalYClick
  end
  object cbFeverN: TCheckBox
    Tag = 8
    Left = 460
    Top = 121
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 14
    OnClick = cbNasalYClick
  end
  object cbSOBY: TCheckBox
    Tag = 9
    Left = 407
    Top = 145
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 15
    OnClick = cbNasalYClick
  end
  object cbSOBN: TCheckBox
    Tag = 10
    Left = 460
    Top = 145
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 16
    OnClick = cbNasalYClick
  end
end
