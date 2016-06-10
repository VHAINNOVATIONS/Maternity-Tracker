object dlgCoughCongest: TdlgCoughCongest
  Left = 217
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Cough and Congestion'
  ClientHeight = 172
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
    Top = 143
    Width = 475
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 16
    ExplicitTop = 140
    object bbtnOK: TBitBtn
      Left = 318
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
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
