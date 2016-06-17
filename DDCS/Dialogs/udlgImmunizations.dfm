object dlgImmunizations: TdlgImmunizations
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Immunization History'
  ClientHeight = 293
  ClientWidth = 621
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
    Left = 8
    Top = 31
    Width = 151
    Height = 39
    Caption = 
      'Combined Tetanus, Diphtheria, and Pertussis or Tetanus and Dipht' +
      'heria'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object lbInfluenza: TLabel
    Left = 8
    Top = 80
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
    Left = 8
    Top = 103
    Width = 151
    Height = 26
    Caption = 'Measles, Mumps, and Rubella'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object lbVaricella: TLabel
    Left = 8
    Top = 139
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
    Left = 8
    Top = 171
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
    Left = 8
    Top = 194
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
    Left = 8
    Top = 217
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
    Left = 8
    Top = 240
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
    Top = 264
    Width = 621
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 21
    ExplicitTop = 276
    ExplicitWidth = 557
    object bbtnOK: TBitBtn
      Left = 464
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
      ExplicitLeft = 400
    end
    object bbtnCancel: TBitBtn
      Left = 545
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      ExplicitLeft = 481
    end
  end
  object lbInformation: TStaticText
    Left = 8
    Top = 8
    Width = 283
    Height = 17
    Caption = 'Please provide an approximate date of last immunizations.'
    TabOrder = 0
    TabStop = True
  end
  object dtTDAP: TORDateBox
    Left = 175
    Top = 28
    Width = 153
    Height = 21
    TabOrder = 1
    DateOnly = True
    RequireTime = False
    Caption = 'T D A P or T D'
  end
  object dtInfluenza: TORDateBox
    Left = 175
    Top = 77
    Width = 153
    Height = 21
    TabOrder = 3
    DateOnly = True
    RequireTime = False
    Caption = 'Influenza'
  end
  object dtMMR: TORDateBox
    Left = 175
    Top = 100
    Width = 153
    Height = 21
    TabOrder = 5
    DateOnly = True
    RequireTime = False
    Caption = 'M M R'
  end
  object dtVaricella: TORDateBox
    Left = 175
    Top = 136
    Width = 153
    Height = 21
    TabOrder = 7
    DateOnly = True
    RequireTime = False
    Caption = 'Varicella'
  end
  object edTDAP: TEdit
    Left = 334
    Top = 28
    Width = 280
    Height = 21
    TabOrder = 2
  end
  object edInfluenza: TEdit
    Left = 334
    Top = 77
    Width = 280
    Height = 21
    TabOrder = 4
  end
  object edMMR: TEdit
    Left = 334
    Top = 100
    Width = 280
    Height = 21
    TabOrder = 6
  end
  object edVaricella: TEdit
    Left = 334
    Top = 136
    Width = 280
    Height = 21
    TabOrder = 8
  end
  object dtOther1: TORDateBox
    Left = 232
    Top = 168
    Width = 153
    Height = 21
    TabOrder = 10
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther1: TEdit
    Left = 391
    Top = 168
    Width = 223
    Height = 21
    TabOrder = 11
  end
  object dtOther2: TORDateBox
    Left = 232
    Top = 191
    Width = 153
    Height = 21
    TabOrder = 13
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther2: TEdit
    Left = 391
    Top = 191
    Width = 223
    Height = 21
    TabOrder = 14
  end
  object dtOther3: TORDateBox
    Left = 232
    Top = 214
    Width = 153
    Height = 21
    TabOrder = 16
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther3: TEdit
    Left = 391
    Top = 214
    Width = 223
    Height = 21
    TabOrder = 17
  end
  object dtOther4: TORDateBox
    Left = 232
    Top = 237
    Width = 153
    Height = 21
    TabOrder = 19
    DateOnly = True
    RequireTime = False
    Caption = 'Other'
  end
  object edOther4: TEdit
    Left = 391
    Top = 237
    Width = 223
    Height = 21
    TabOrder = 20
  end
  object edLabelOther1: TEdit
    Left = 46
    Top = 168
    Width = 180
    Height = 21
    TabOrder = 9
  end
  object edLabelOther2: TEdit
    Left = 46
    Top = 191
    Width = 180
    Height = 21
    TabOrder = 12
  end
  object edLabelOther3: TEdit
    Left = 46
    Top = 213
    Width = 180
    Height = 21
    TabOrder = 15
  end
  object edLabelOther4: TEdit
    Left = 46
    Top = 238
    Width = 180
    Height = 21
    TabOrder = 18
  end
end
