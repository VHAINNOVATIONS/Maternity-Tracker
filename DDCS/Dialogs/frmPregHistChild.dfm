object fChild: TfChild
  Left = 0
  Top = 0
  Width = 512
  Height = 364
  TabOrder = 0
  object lbG: TLabel
    Left = 432
    Top = 77
    Width = 8
    Height = 13
    Caption = 'g'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTotalWeight: TLabel
    Left = 266
    Top = 77
    Width = 74
    Height = 13
    Caption = 'Total Weight'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbComplications: TLabel
    Left = 11
    Top = 155
    Width = 142
    Height = 13
    Caption = 'Complications/Anomalies'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbLbs: TLabel
    Left = 432
    Top = 105
    Width = 17
    Height = 13
    Caption = 'lbs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbAPGAR: TLabel
    Left = 11
    Top = 77
    Width = 43
    Height = 13
    Caption = 'APGAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbOz: TLabel
    Left = 432
    Top = 133
    Width = 20
    Height = 13
    Caption = 'ozs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object meComplications: TCaptionMemo
    Left = 11
    Top = 173
    Width = 486
    Height = 180
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
    Caption = 'Complications and or Anomalies'
  end
  object rgSex: TRadioGroup
    Left = 11
    Top = 9
    Width = 244
    Height = 54
    Caption = 'Gender'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'Male'
      'Female'
      'Unknown')
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object spnLb: TSpinEdit
    Left = 346
    Top = 102
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object edAPGARfive: TEdit
    Left = 120
    Top = 74
    Width = 54
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object spnG: TSpinEdit
    Left = 346
    Top = 74
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object rgLife: TRadioGroup
    Left = 266
    Top = 9
    Width = 173
    Height = 54
    Caption = 'Status'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'Living'
      'Demise')
    ParentFont = False
    TabOrder = 6
    TabStop = True
  end
  object ckNICU: TCheckBox
    Left = 11
    Top = 107
    Width = 244
    Height = 17
    Caption = 'Neonatal Intensive Care Unit Admission'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object spnOz: TSpinEdit
    Left = 346
    Top = 130
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object edAPGARone: TEdit
    Left = 60
    Top = 74
    Width = 54
    Height = 21
    NumbersOnly = True
    TabOrder = 9
  end
  object BitBtn1: TBitBtn
    Left = 477
    Top = 7
    Width = 28
    Height = 25
    Cancel = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 10
  end
end
