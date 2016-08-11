object dlgPregHist: TdlgPregHist
  Left = 197
  Top = 155
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Pregnancy History'
  ClientHeight = 518
  ClientWidth = 524
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lbTotalPreg: TLabel
    Left = 17
    Top = 13
    Width = 98
    Height = 14
    Caption = 'Total Pregnancies'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbInduced: TLabel
    Left = 17
    Top = 42
    Width = 95
    Height = 14
    Caption = 'Induced Abortion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbSpontaneous: TLabel
    Left = 244
    Top = 13
    Width = 124
    Height = 14
    Caption = 'Spontaneous Abortion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbEctopics: TLabel
    Left = 244
    Top = 42
    Width = 39
    Height = 14
    Caption = 'Ectopic'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cbOutcome: TComboBox
    Left = 137
    Top = 291
    Width = 179
    Height = 22
    Align = alCustom
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object cbAnesthesia: TComboBox
    Left = 137
    Top = 319
    Width = 179
    Height = 22
    Align = alCustom
    Style = csDropDownList
    TabOrder = 7
  end
  object cbDeliveryPlace: TComboBox
    Left = 137
    Top = 347
    Width = 179
    Height = 22
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 8
  end
  object pnlfooter: TPanel
    Left = 0
    Top = 489
    Width = 524
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object btnOK: TBitBtn
      Left = 367
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
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
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 448
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
  object pgPregnancy: TPageControl
    Left = 2
    Top = 71
    Width = 520
    Height = 415
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
  end
  object edtAbInduced: TSpinEdit
    Tag = 2
    Left = 121
    Top = 39
    Width = 85
    Height = 23
    Hint = 'Induced Abortion'
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = TotPregChange
  end
  object edtAbSpont: TSpinEdit
    Tag = 3
    Left = 374
    Top = 10
    Width = 85
    Height = 23
    Hint = 'Spontaneous Abortion'
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = TotPregChange
  end
  object edtTotPreg: TSpinEdit
    Tag = 1
    Left = 121
    Top = 10
    Width = 85
    Height = 23
    Hint = 'Normal Pregnancy'
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = TotPregChange
  end
  object edtEctopic: TSpinEdit
    Tag = 4
    Left = 374
    Top = 39
    Width = 85
    Height = 23
    Hint = 'Ectopic'
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnChange = TotPregChange
  end
  object NavControl: TActionList
    Left = 376
    Top = 200
  end
end
