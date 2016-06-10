object dlgNausea: TdlgNausea
  Left = 217
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Nausea, Vomiting, and Diarrhea'
  ClientHeight = 206
  ClientWidth = 505
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
  object lbtoleratesolids: TLabel
    Left = 16
    Top = 48
    Width = 111
    Height = 14
    Caption = 'Can tolerate solids?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbtolerateliquids: TLabel
    Left = 16
    Top = 80
    Width = 114
    Height = 14
    Caption = 'Can tolerate liquids?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbfever: TLabel
    Left = 16
    Top = 144
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
  object lbabdominalpain: TLabel
    Left = 259
    Top = 48
    Width = 92
    Height = 14
    Caption = 'Abdominal pain?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbcontractions: TLabel
    Left = 259
    Top = 16
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
  object lbonset: TLabel
    Left = 16
    Top = 16
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
  object lbdur: TLabel
    Left = 16
    Top = 113
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
  object lbLocal1: TLabel
    Left = 259
    Top = 80
    Width = 65
    Height = 14
    Caption = 'Localization'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbDur1: TLabel
    Left = 259
    Top = 113
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 177
    Width = 505
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 14
    ExplicitTop = 174
    object bbtnOK: TBitBtn
      Left = 348
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
      Left = 429
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
    Left = 72
    Top = 12
    Width = 159
    Height = 22
    TabOrder = 0
  end
  object leLocal: TEdit
    Left = 332
    Top = 78
    Width = 156
    Height = 22
    TabOrder = 12
    Visible = False
  end
  object leDur: TEdit
    Left = 72
    Top = 109
    Width = 159
    Height = 22
    TabOrder = 5
  end
  object leDur1: TEdit
    Left = 332
    Top = 109
    Width = 156
    Height = 22
    TabOrder = 13
    Visible = False
  end
  object cbSolidY: TCheckBox
    Tag = 1
    Left = 146
    Top = 48
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = checkboxClick
  end
  object cbSolidN: TCheckBox
    Tag = 2
    Left = 195
    Top = 48
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = checkboxClick
  end
  object cbLiquidY: TCheckBox
    Tag = 3
    Left = 146
    Top = 80
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = checkboxClick
  end
  object cbLiquidN: TCheckBox
    Tag = 4
    Left = 195
    Top = 80
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = checkboxClick
  end
  object cbFeverY: TCheckBox
    Tag = 5
    Left = 146
    Top = 144
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = checkboxClick
  end
  object cbFeverN: TCheckBox
    Tag = 6
    Left = 195
    Top = 144
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = checkboxClick
  end
  object cbAbdomY: TCheckBox
    Tag = 7
    Left = 403
    Top = 48
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 10
    OnClick = checkboxClick
  end
  object cbAbdomN: TCheckBox
    Tag = 8
    Left = 452
    Top = 48
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 11
    OnClick = checkboxClick
  end
  object cbContY: TCheckBox
    Tag = 9
    Left = 403
    Top = 16
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = checkboxClick
  end
  object cbContN: TCheckBox
    Tag = 10
    Left = 452
    Top = 16
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = checkboxClick
  end
end
