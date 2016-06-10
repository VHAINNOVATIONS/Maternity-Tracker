object dlgHeadache: TdlgHeadache
  Left = 217
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Headaches'
  ClientHeight = 180
  ClientWidth = 549
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
  object lbonset: TLabel
    Left = 17
    Top = 15
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
  object lbchar: TLabel
    Left = 17
    Top = 48
    Width = 54
    Height = 14
    Caption = 'Character'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbloc: TLabel
    Left = 17
    Top = 82
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
  object lbdur: TLabel
    Left = 17
    Top = 118
    Width = 46
    Height = 14
    Caption = 'Duration'
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
    Top = 151
    Width = 549
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = 148
    object bbtnOK: TBitBtn
      Left = 392
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
      Left = 473
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
    Left = 76
    Top = 12
    Width = 137
    Height = 22
    TabOrder = 0
  end
  object leChar: TEdit
    Left = 76
    Top = 45
    Width = 137
    Height = 22
    TabOrder = 1
  end
  object leLocat: TEdit
    Left = 76
    Top = 79
    Width = 137
    Height = 22
    TabOrder = 2
  end
  object leDur: TEdit
    Left = 76
    Top = 115
    Width = 137
    Height = 22
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 221
    Top = 8
    Width = 326
    Height = 137
    BevelOuter = bvNone
    TabOrder = 4
    object lbtreatments: TLabel
      Left = 17
      Top = 59
      Width = 71
      Height = 14
      Caption = 'Treatments?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbsymptoms: TLabel
      Left = 17
      Top = 7
      Width = 125
      Height = 14
      Caption = 'Associated Symptoms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbWhat: TLabel
      Left = 17
      Top = 86
      Width = 254
      Height = 14
      Caption = 'What was used? What was the effectiveness?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object leWhat: TEdit
      Left = 17
      Top = 107
      Width = 293
      Height = 22
      TabOrder = 3
      Visible = False
    end
    object cbTreatNo: TCheckBox
      Tag = 2
      Left = 150
      Top = 59
      Width = 36
      Height = 17
      Caption = 'No'
      TabOrder = 2
      OnClick = cbTreatYesClick
    end
    object cbTreatYes: TCheckBox
      Tag = 1
      Left = 100
      Top = 59
      Width = 43
      Height = 17
      Caption = 'Yes'
      TabOrder = 1
      OnClick = cbTreatYesClick
    end
    object leAssoc: TEdit
      Left = 17
      Top = 26
      Width = 293
      Height = 22
      TabOrder = 0
    end
  end
end
