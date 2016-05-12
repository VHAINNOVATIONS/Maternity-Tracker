object dlgVisualChanges: TdlgVisualChanges
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Visual Changes'
  ClientHeight = 147
  ClientWidth = 525
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
  object Label2: TStaticText
    Left = 16
    Top = 56
    Width = 58
    Height = 18
    Caption = 'Character'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Label3: TStaticText
    Left = 16
    Top = 91
    Width = 51
    Height = 18
    Caption = 'Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object Label1: TStaticText
    Left = 260
    Top = 54
    Width = 129
    Height = 18
    Caption = 'Associated Symptoms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 118
    Width = 525
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
    object bbtnOK: TBitBtn
      Left = 368
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
      Left = 449
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
    Left = 77
    Top = 14
    Width = 164
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object cmbChar: TORComboBox
    Left = 77
    Top = 52
    Width = 164
    Height = 22
    Style = orcsDropDown
    AutoSelect = True
    Caption = 'Character'
    Color = clWindow
    DropDownCount = 8
    ItemHeight = 14
    ItemTipColor = clWindow
    ItemTipEnable = True
    ListItemsOnly = False
    LongList = False
    LookupPiece = 0
    MaxLength = 0
    Sorted = False
    SynonymChars = '<>'
    TabOrder = 3
    TabStop = True
    Text = ''
    CharsNeedMatch = 1
  end
  object cmbLoc: TORComboBox
    Left = 77
    Top = 87
    Width = 164
    Height = 22
    Style = orcsDropDown
    AutoSelect = True
    Caption = 'Location'
    Color = clWindow
    DropDownCount = 8
    ItemHeight = 14
    ItemTipColor = clWindow
    ItemTipEnable = True
    ListItemsOnly = False
    LongList = False
    LookupPiece = 0
    MaxLength = 0
    Sorted = False
    SynonymChars = '<>'
    TabOrder = 5
    TabStop = True
    Text = ''
    CharsNeedMatch = 1
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 18
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
    TabStop = True
  end
  object leAssociatedSymp: TCaptionEdit
    Left = 260
    Top = 74
    Width = 251
    Height = 22
    TabOrder = 9
    Caption = 'Associated Symptoms'
  end
  object leDur: TCaptionEdit
    Left = 313
    Top = 14
    Width = 198
    Height = 22
    TabOrder = 7
    Caption = 'Duration'
  end
  object StaticText3: TStaticText
    Left = 260
    Top = 18
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
end
