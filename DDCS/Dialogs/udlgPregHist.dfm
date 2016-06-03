object dlgPregHist: TdlgPregHist
  Left = 197
  Top = 155
  BorderStyle = bsDialog
  Caption = 'Pregnancy History'
  ClientHeight = 582
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
  object lbFullTerm: TLabel
    Left = 17
    Top = 42
    Width = 51
    Height = 14
    Caption = 'Full Term'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbPremature: TLabel
    Left = 17
    Top = 70
    Width = 59
    Height = 14
    Caption = 'Premature'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbInduced: TLabel
    Left = 17
    Top = 98
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
  object lbMultipleBirths: TLabel
    Left = 244
    Top = 70
    Width = 80
    Height = 14
    Caption = 'Multiple Births'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbLiving: TLabel
    Left = 244
    Top = 98
    Width = 33
    Height = 14
    Caption = 'Living'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PregListView: TListView
    Left = 48
    Top = 208
    Width = 422
    Height = 238
    Columns = <>
    TabOrder = 10
    ViewStyle = vsReport
    Visible = False
  end
  object pnlfooter: TPanel
    Left = 0
    Top = 553
    Width = 524
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 9
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
    Top = 135
    Width = 520
    Height = 415
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 8
  end
  object edtAbInduced: TSpinEdit
    Tag = 2
    Left = 121
    Top = 95
    Width = 85
    Height = 23
    Hint = 'Induced Abortion'
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
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
    TabOrder = 4
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
    TabOrder = 5
    Value = 0
    OnChange = TotPregChange
  end
  object lbFullTermValue: TStaticText
    Left = 121
    Top = 42
    Width = 85
    Height = 18
    AutoSize = False
    Caption = '0'
    TabOrder = 1
    TabStop = True
  end
  object lbPrematureValue: TStaticText
    Left = 121
    Top = 70
    Width = 85
    Height = 18
    AutoSize = False
    Caption = '0'
    TabOrder = 2
    TabStop = True
  end
  object lbMultipleBirthsValue: TStaticText
    Left = 374
    Top = 70
    Width = 85
    Height = 18
    AutoSize = False
    Caption = '0'
    TabOrder = 6
    TabStop = True
  end
  object lbLivingValue: TStaticText
    Left = 374
    Top = 95
    Width = 85
    Height = 18
    AutoSize = False
    Caption = '0'
    TabOrder = 7
    TabStop = True
  end
end
