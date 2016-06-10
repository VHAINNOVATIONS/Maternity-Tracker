object dlgFetalMov: TdlgFetalMov
  Left = 197
  Top = 176
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Change in Fetal Movement'
  ClientHeight = 387
  ClientWidth = 285
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
    Left = 16
    Top = 12
    Width = 143
    Height = 14
    Caption = 'Fetal movement present?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbContractions: TLabel
    Left = 16
    Top = 236
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
  object Label2: TLabel
    Left = 16
    Top = 144
    Width = 97
    Height = 14
    Caption = 'Vaginal bleeding?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 171
    Width = 95
    Height = 14
    Caption = 'Leakage of fluid?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText1: TLabel
    Left = 16
    Top = 39
    Width = 240
    Height = 14
    Caption = 'Date and time of last perceived movement?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText2: TLabel
    Left = 16
    Top = 89
    Width = 172
    Height = 14
    Caption = 'Character of fetal movements?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText3: TLabel
    Left = 16
    Top = 201
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
    Left = 16
    Top = 271
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
    Left = 16
    Top = 299
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
  object lbOnset1: TLabel
    Left = 16
    Top = 327
    Width = 33
    Height = 14
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 358
    Width = 285
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 14
    ExplicitTop = 355
    object bbtnOK: TBitBtn
      Left = 128
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
      Left = 209
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
    Left = 58
    Top = 198
    Width = 211
    Height = 22
    TabOrder = 8
  end
  object cbFetMovY: TCheckBox
    Tag = 1
    Left = 184
    Top = 12
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 0
    OnClick = checkboxClick
  end
  object cbFetMovN: TCheckBox
    Tag = 2
    Left = 233
    Top = 12
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 1
    OnClick = checkboxClick
  end
  object cbContY: TCheckBox
    Tag = 7
    Left = 184
    Top = 236
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 9
    OnClick = checkboxClick
  end
  object cbContN: TCheckBox
    Tag = 8
    Left = 233
    Top = 236
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 10
    OnClick = checkboxClick
  end
  object cbVagBleY: TCheckBox
    Tag = 3
    Left = 184
    Top = 144
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
    OnClick = checkboxClick
  end
  object cbVagBleN: TCheckBox
    Tag = 4
    Left = 233
    Top = 144
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 5
    OnClick = checkboxClick
  end
  object cbLeakY: TCheckBox
    Tag = 5
    Left = 184
    Top = 171
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = checkboxClick
  end
  object cbLeakN: TCheckBox
    Tag = 6
    Left = 233
    Top = 171
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = checkboxClick
  end
  object leLastMov: TORDateBox
    Left = 16
    Top = 58
    Width = 253
    Height = 22
    TabOrder = 2
    DateOnly = False
    RequireTime = False
    Caption = 'Date and time of last perceived movement'
  end
  object leCharFetal: TEdit
    Left = 16
    Top = 108
    Width = 253
    Height = 22
    TabOrder = 3
  end
  object leFreq: TEdit
    Left = 84
    Top = 268
    Width = 185
    Height = 22
    TabOrder = 11
    Visible = False
  end
  object leDur: TEdit
    Left = 84
    Top = 296
    Width = 185
    Height = 22
    TabOrder = 12
    Visible = False
  end
  object leOnset1: TEdit
    Left = 84
    Top = 324
    Width = 185
    Height = 22
    TabOrder = 13
    Visible = False
  end
end
