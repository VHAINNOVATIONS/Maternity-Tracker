object dlgImmunizations: TdlgImmunizations
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Immunization History'
  ClientHeight = 305
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbTDAP: TLabel
    Left = 10
    Top = 34
    Width = 63
    Height = 13
    Caption = 'TDAP or TD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbInfluenza: TLabel
    Left = 10
    Top = 61
    Width = 53
    Height = 13
    Caption = 'Influenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbMMR: TLabel
    Left = 10
    Top = 88
    Width = 28
    Height = 13
    Caption = 'MMR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbVaricella: TLabel
    Left = 10
    Top = 115
    Width = 48
    Height = 13
    Caption = 'Varicella'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbOther1: TLabel
    Left = 10
    Top = 157
    Width = 32
    Height = 13
    Caption = 'Other'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbOther2: TLabel
    Left = 10
    Top = 184
    Width = 32
    Height = 13
    Caption = 'Other'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbOther3: TLabel
    Left = 10
    Top = 211
    Width = 32
    Height = 13
    Caption = 'Other'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbOther4: TLabel
    Left = 10
    Top = 237
    Width = 32
    Height = 13
    Caption = 'Other'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlfooter: TPanel
    Left = 0
    Top = 276
    Width = 557
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 21
    ExplicitTop = 273
    object bbtnOK: TBitBtn
      Left = 400
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
      Left = 481
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
  object lbInformation: TStaticText
    Left = 10
    Top = 8
    Width = 283
    Height = 17
    Caption = 'Please provide an approximate date of last immunizations.'
    TabOrder = 0
    TabStop = True
  end
  object dtTDAP: TORDateBox
    Left = 80
    Top = 31
    Width = 153
    Height = 21
    TabOrder = 1
    DateOnly = True
    RequireTime = False
    Caption = 'T D A P or T D'
  end
  object dtInfluenza: TORDateBox
    Left = 80
    Top = 58
    Width = 153
    Height = 21
    TabOrder = 3
    DateOnly = True
    RequireTime = False
    Caption = 'Influenza'
  end
  object dtMMR: TORDateBox
    Left = 80
    Top = 85
    Width = 153
    Height = 21
    TabOrder = 5
    DateOnly = True
    RequireTime = False
    Caption = 'M M R'
  end
  object dtVaricella: TORDateBox
    Left = 80
    Top = 112
    Width = 153
    Height = 21
    TabOrder = 7
    DateOnly = True
    RequireTime = False
    Caption = 'Varicella'
  end
  object edTDAP: TEdit
    Left = 239
    Top = 31
    Width = 308
    Height = 21
    TabOrder = 2
  end
  object edInfluenza: TEdit
    Left = 239
    Top = 58
    Width = 308
    Height = 21
    TabOrder = 4
  end
  object edMMR: TEdit
    Left = 239
    Top = 85
    Width = 308
    Height = 21
    TabOrder = 6
  end
  object edVaricella: TEdit
    Left = 239
    Top = 112
    Width = 308
    Height = 21
    TabOrder = 8
  end
  object dtOther1: TORDateBox
    Left = 167
    Top = 154
    Width = 153
    Height = 21
    TabOrder = 10
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther1: TEdit
    Left = 326
    Top = 154
    Width = 221
    Height = 21
    TabOrder = 11
  end
  object dtOther2: TORDateBox
    Left = 167
    Top = 181
    Width = 153
    Height = 21
    TabOrder = 13
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther2: TEdit
    Left = 326
    Top = 181
    Width = 221
    Height = 21
    TabOrder = 14
  end
  object dtOther3: TORDateBox
    Left = 167
    Top = 208
    Width = 153
    Height = 21
    TabOrder = 16
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther3: TEdit
    Left = 326
    Top = 208
    Width = 221
    Height = 21
    TabOrder = 17
  end
  object dtOther4: TORDateBox
    Left = 167
    Top = 234
    Width = 153
    Height = 21
    TabOrder = 19
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther4: TEdit
    Left = 326
    Top = 235
    Width = 221
    Height = 21
    TabOrder = 20
  end
  object edLabelOther1: TEdit
    Left = 48
    Top = 154
    Width = 113
    Height = 21
    TabOrder = 9
  end
  object edLabelOther2: TEdit
    Left = 48
    Top = 181
    Width = 113
    Height = 21
    TabOrder = 12
  end
  object edLabelOther3: TEdit
    Left = 48
    Top = 207
    Width = 113
    Height = 21
    TabOrder = 15
  end
  object edLabelOther4: TEdit
    Left = 48
    Top = 235
    Width = 113
    Height = 21
    TabOrder = 18
  end
end
