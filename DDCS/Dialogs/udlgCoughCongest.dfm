object dlgCoughCongest: TdlgCoughCongest
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Cough and Congestion'
  ClientHeight = 169
  ClientWidth = 475
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
    Left = 19
    Top = 46
    Width = 109
    Height = 18
    Caption = 'Productive Cough?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object lbBlood: TStaticText
    Left = 19
    Top = 111
    Width = 42
    Height = 18
    Caption = 'Blood?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = True
    Visible = False
  end
  object Label5: TStaticText
    Left = 244
    Top = 15
    Width = 94
    Height = 18
    Caption = 'Post-Nasal Drip?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    TabStop = True
  end
  object Label1: TStaticText
    Left = 244
    Top = 39
    Width = 68
    Height = 18
    Caption = 'Sinus Pain?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    TabStop = True
  end
  object Label2: TStaticText
    Left = 244
    Top = 63
    Width = 72
    Height = 18
    Caption = 'Rhinorrhea?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    TabStop = True
  end
  object Label6: TStaticText
    Left = 244
    Top = 87
    Width = 114
    Height = 18
    Caption = 'Fever and or Chills?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    TabStop = True
  end
  object Label7: TStaticText
    Left = 244
    Top = 111
    Width = 122
    Height = 18
    Caption = 'Shortness of Breath?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 140
    Width = 475
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 25
    object bbtnOK: TBitBtn
      Left = 318
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
      Left = 399
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
    Left = 62
    Top = 11
    Width = 161
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leColor: TCaptionEdit
    Left = 62
    Top = 75
    Width = 161
    Height = 22
    TabOrder = 6
    Visible = False
    Caption = 'Color'
  end
  object cbProdCY: TCheckBox
    Tag = 1
    Left = 138
    Top = 46
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = cbProdCYClick
  end
  object cbProdCN: TCheckBox
    Tag = 2
    Left = 187
    Top = 46
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = cbProdCYClick
  end
  object cbBloodY: TCheckBox
    Tag = 1
    Left = 138
    Top = 111
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    Visible = False
    OnClick = cbBloodYClick
  end
  object cbBloodN: TCheckBox
    Tag = 2
    Left = 187
    Top = 111
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    Visible = False
    OnClick = cbBloodYClick
  end
  object cbNasalY: TCheckBox
    Tag = 1
    Left = 375
    Top = 15
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = cbNasalYClick
  end
  object cbNasalN: TCheckBox
    Tag = 2
    Left = 428
    Top = 15
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = cbNasalYClick
  end
  object cbSinusY: TCheckBox
    Tag = 3
    Left = 375
    Top = 39
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 14
    OnClick = cbNasalYClick
  end
  object cbSinusN: TCheckBox
    Tag = 4
    Left = 428
    Top = 39
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 15
    OnClick = cbNasalYClick
  end
  object cbRhinY: TCheckBox
    Tag = 5
    Left = 375
    Top = 63
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 17
    OnClick = cbNasalYClick
  end
  object cbRhinN: TCheckBox
    Tag = 6
    Left = 428
    Top = 63
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 18
    OnClick = cbNasalYClick
  end
  object cbFeverY: TCheckBox
    Tag = 7
    Left = 375
    Top = 87
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 20
    OnClick = cbNasalYClick
  end
  object cbFeverN: TCheckBox
    Tag = 8
    Left = 428
    Top = 87
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 21
    OnClick = cbNasalYClick
  end
  object cbSOBY: TCheckBox
    Tag = 9
    Left = 375
    Top = 111
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 23
    OnClick = cbNasalYClick
  end
  object cbSOBN: TCheckBox
    Tag = 10
    Left = 428
    Top = 111
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 24
    OnClick = cbNasalYClick
  end
  object lbColor: TStaticText
    Left = 19
    Top = 79
    Width = 34
    Height = 18
    Caption = 'Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object StaticText2: TStaticText
    Left = 19
    Top = 15
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
