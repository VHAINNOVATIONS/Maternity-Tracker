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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object lbColor: TLabel
    Left = 19
    Top = 78
    Width = 30
    Height = 14
    Caption = 'Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbonset: TLabel
    Left = 19
    Top = 14
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
  object Label3: TLabel
    Left = 19
    Top = 46
    Width = 105
    Height = 14
    Caption = 'Productive Cough?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbBlood: TLabel
    Left = 19
    Top = 111
    Width = 38
    Height = 14
    Caption = 'Blood?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label5: TLabel
    Left = 244
    Top = 15
    Width = 90
    Height = 14
    Caption = 'Post-Nasal Drip?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 244
    Top = 39
    Width = 64
    Height = 14
    Caption = 'Sinus Pain?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 244
    Top = 63
    Width = 68
    Height = 14
    Caption = 'Rhinorrhea?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 244
    Top = 87
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
  object Label7: TLabel
    Left = 244
    Top = 111
    Width = 118
    Height = 14
    Caption = 'Shortness of Breath?'
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
    Top = 140
    Width = 475
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 16
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
  object leOnset: TEdit
    Left = 62
    Top = 11
    Width = 161
    Height = 22
    TabOrder = 0
  end
  object leColor: TEdit
    Left = 62
    Top = 75
    Width = 161
    Height = 22
    TabOrder = 3
    Visible = False
  end
  object cbProdCY: TCheckBox
    Tag = 1
    Left = 138
    Top = 46
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = cbProdCYClick
  end
  object cbProdCN: TCheckBox
    Tag = 2
    Left = 187
    Top = 46
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = cbProdCYClick
  end
  object cbBloodY: TCheckBox
    Tag = 1
    Left = 138
    Top = 111
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
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
    TabOrder = 5
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
    TabOrder = 6
    OnClick = cbNasalYClick
  end
  object cbNasalN: TCheckBox
    Tag = 2
    Left = 428
    Top = 15
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = cbNasalYClick
  end
  object cbSinusY: TCheckBox
    Tag = 3
    Left = 375
    Top = 39
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = cbNasalYClick
  end
  object cbSinusN: TCheckBox
    Tag = 4
    Left = 428
    Top = 39
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = cbNasalYClick
  end
  object cbRhinY: TCheckBox
    Tag = 5
    Left = 375
    Top = 63
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 10
    OnClick = cbNasalYClick
  end
  object cbRhinN: TCheckBox
    Tag = 6
    Left = 428
    Top = 63
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 11
    OnClick = cbNasalYClick
  end
  object cbFeverY: TCheckBox
    Tag = 7
    Left = 375
    Top = 87
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 12
    OnClick = cbNasalYClick
  end
  object cbFeverN: TCheckBox
    Tag = 8
    Left = 428
    Top = 87
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 13
    OnClick = cbNasalYClick
  end
  object cbSOBY: TCheckBox
    Tag = 9
    Left = 375
    Top = 111
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 14
    OnClick = cbNasalYClick
  end
  object cbSOBN: TCheckBox
    Tag = 10
    Left = 428
    Top = 111
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 15
    OnClick = cbNasalYClick
  end
end
