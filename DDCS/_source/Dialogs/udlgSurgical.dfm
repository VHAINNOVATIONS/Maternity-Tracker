object dlgSurgical: TdlgSurgical
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 446
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 245
    Width = 608
    Height = 42
    Caption = 
      '*** Enter surgical narrative history information in the space be' +
      'low.  Please enter problems onto PROBLEMS tab in the Electronic ' +
      'Chart. Problems entered in this section of the Note Template wil' +
      'l only be entered as Note Text and will not copy to the Problem ' +
      'List.'
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 162
    Top = 48
    Width = 20
    Height = 13
    Caption = 'POS'
  end
  object Label3: TLabel
    Left = 195
    Top = 48
    Width = 20
    Height = 13
    Caption = 'NEG'
  end
  object Label34: TLabel
    Left = 16
    Top = 118
    Width = 217
    Height = 13
    Caption = 'Oophorectomy'
    Color = clBtnFace
    Constraints.MinWidth = 217
    ParentColor = False
  end
  object Label36: TLabel
    Left = 16
    Top = 167
    Width = 217
    Height = 13
    Caption = 'Laparoscopy'
    Color = clBtnFace
    Constraints.MinWidth = 217
    ParentColor = False
  end
  object Label4: TLabel
    Left = 235
    Top = 48
    Width = 214
    Height = 13
    Caption = 'COMMENTS - To include Date and Treatment'
  end
  object Label5: TLabel
    Left = 16
    Top = 67
    Width = 131
    Height = 13
    Caption = 'Operations/Hospitalizations'
  end
  object Label28: TLabel
    Left = 16
    Top = 139
    Width = 221
    Height = 21
    AutoSize = False
    Caption = 'Cholecystectomy'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label30: TLabel
    Left = 16
    Top = 189
    Width = 244
    Height = 21
    AutoSize = False
    Caption = 'D&&C'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label24: TLabel
    Left = 16
    Top = 88
    Width = 222
    Height = 21
    AutoSize = False
    Caption = 'Anesthetic Complications'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 16
    Top = 217
    Width = 46
    Height = 13
    Caption = 'C-Section'
  end
  object Panel1: TPanel
    Tag = 19641
    Left = 0
    Top = 0
    Width = 634
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
      Width = 127
      Height = 20
      Caption = 'Surgical History'
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
    Top = 417
    Width = 634
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 23
    object bbtnOK: TBitBtn
      Left = 476
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 557
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 2
      Top = 2
      Width = 96
      Height = 25
      Caption = 'Negative for all'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object CheckBox37: TCheckBox
    Tag = 37
    Left = 162
    Top = 65
    Width = 21
    Height = 17
    Hint = 'POS'
    TabOrder = 1
    OnClick = CheckBox37Click
  end
  object CheckBox38: TCheckBox
    Tag = 38
    Left = 195
    Top = 65
    Width = 17
    Height = 17
    Hint = 'NEG'
    TabOrder = 2
    OnClick = CheckBox37Click
  end
  object Edit19: TEdit
    Left = 235
    Top = 63
    Width = 387
    Height = 21
    TabOrder = 3
  end
  object CheckBox39: TCheckBox
    Tag = 39
    Left = 162
    Top = 90
    Width = 21
    Height = 17
    Hint = 'POS'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 4
    OnClick = CheckBox37Click
  end
  object CheckBox40: TCheckBox
    Tag = 40
    Left = 195
    Top = 90
    Width = 17
    Height = 17
    Hint = 'NEG'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 5
    OnClick = CheckBox37Click
  end
  object Edit18: TEdit
    Left = 235
    Top = 88
    Width = 387
    Height = 21
    TabOrder = 6
  end
  object CheckBox41: TCheckBox
    Tag = 41
    Left = 162
    Top = 116
    Width = 21
    Height = 17
    Hint = 'POS'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 7
    OnClick = CheckBox37Click
  end
  object CheckBox42: TCheckBox
    Tag = 42
    Left = 195
    Top = 116
    Width = 17
    Height = 17
    Hint = 'NEG'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 8
    OnClick = CheckBox37Click
  end
  object Edit24: TEdit
    Left = 235
    Top = 114
    Width = 387
    Height = 21
    TabOrder = 9
  end
  object CheckBox43: TCheckBox
    Tag = 43
    Left = 162
    Top = 141
    Width = 21
    Height = 17
    Hint = 'POS'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 10
    OnClick = CheckBox37Click
  end
  object CheckBox44: TCheckBox
    Tag = 44
    Left = 195
    Top = 141
    Width = 17
    Height = 17
    Hint = 'NEG'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 11
    OnClick = CheckBox37Click
  end
  object Edit25: TEdit
    Left = 235
    Top = 139
    Width = 387
    Height = 21
    TabOrder = 12
  end
  object CheckBox45: TCheckBox
    Tag = 45
    Left = 162
    Top = 166
    Width = 21
    Height = 17
    Hint = 'POS'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 13
    OnClick = CheckBox37Click
  end
  object CheckBox46: TCheckBox
    Tag = 46
    Left = 195
    Top = 166
    Width = 17
    Height = 17
    Hint = 'NEG'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 14
    OnClick = CheckBox37Click
  end
  object Edit26: TEdit
    Left = 235
    Top = 164
    Width = 387
    Height = 21
    TabOrder = 15
  end
  object CheckBox47: TCheckBox
    Tag = 47
    Left = 162
    Top = 191
    Width = 21
    Height = 17
    Hint = 'POS'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 16
    OnClick = CheckBox37Click
  end
  object CheckBox48: TCheckBox
    Tag = 48
    Left = 195
    Top = 191
    Width = 17
    Height = 17
    Hint = 'NEG'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 17
    OnClick = CheckBox37Click
  end
  object Edit27: TEdit
    Left = 235
    Top = 189
    Width = 387
    Height = 21
    TabOrder = 18
  end
  object CheckBox49: TCheckBox
    Tag = 49
    Left = 162
    Top = 216
    Width = 22
    Height = 17
    Hint = 'POS'
    TabOrder = 19
    OnClick = CheckBox37Click
  end
  object CheckBox50: TCheckBox
    Tag = 50
    Left = 195
    Top = 216
    Width = 29
    Height = 17
    Hint = 'NEG'
    TabOrder = 20
    OnClick = CheckBox37Click
  end
  object Edit1: TEdit
    Left = 235
    Top = 214
    Width = 387
    Height = 21
    TabOrder = 21
  end
  object Memo1: TMemo
    Left = 0
    Top = 292
    Width = 634
    Height = 125
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 22
  end
end
