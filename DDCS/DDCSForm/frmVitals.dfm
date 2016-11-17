object DDCSVitals: TDDCSVitals
  Left = 0
  Top = 0
  Width = 698
  Height = 334
  DoubleBuffered = False
  ParentDoubleBuffered = False
  TabOrder = 0
  object fVitalsControl: TPageControl
    Left = 0
    Top = 0
    Width = 698
    Height = 334
    ActivePage = PageMain
    Align = alClient
    DoubleBuffered = False
    MultiLine = True
    ParentDoubleBuffered = False
    TabOrder = 0
    TabPosition = tpRight
    OnChange = fVitalsControlChange
    object PageMain: TTabSheet
      Caption = 'Vitals'
      DesignSize = (
        670
        326)
      object FTempdt: TLabel
        Left = 92
        Top = 125
        Width = 3
        Height = 13
        Anchors = []
        ExplicitTop = 143
      end
      object FHeightdt: TLabel
        Left = 92
        Top = 173
        Width = 3
        Height = 13
        Anchors = []
      end
      object FWeightdt: TLabel
        Left = 92
        Top = 221
        Width = 3
        Height = 13
        Anchors = []
      end
      object FTempl: TLabel
        Left = 12
        Top = 105
        Width = 75
        Height = 13
        Anchors = []
        Caption = 'Temperature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 120
      end
      object FHeightl: TLabel
        Left = 50
        Top = 151
        Width = 37
        Height = 13
        Anchors = []
        Caption = 'Height'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FWeightl: TLabel
        Left = 47
        Top = 199
        Width = 40
        Height = 13
        Anchors = []
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FPulsedt: TLabel
        Left = 336
        Top = 125
        Width = 3
        Height = 13
        Anchors = []
        ExplicitTop = 143
      end
      object FPulsel: TLabel
        Left = 301
        Top = 105
        Width = 30
        Height = 13
        Anchors = []
        Caption = 'Pulse'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 120
      end
      object FRespl: TLabel
        Left = 266
        Top = 151
        Width = 65
        Height = 13
        Anchors = []
        Caption = 'Respiration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FRespdt: TLabel
        Left = 336
        Top = 173
        Width = 3
        Height = 13
        Anchors = []
      end
      object FPainl: TLabel
        Left = 307
        Top = 199
        Width = 24
        Height = 13
        Anchors = []
        Caption = 'Pain'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FPaindt: TLabel
        Left = 336
        Top = 221
        Width = 3
        Height = 13
        Anchors = []
      end
      object FSystolicl: TLabel
        Left = 457
        Top = 105
        Width = 44
        Height = 13
        Anchors = []
        Caption = 'Systolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 120
      end
      object FSystolicdt: TLabel
        Left = 506
        Top = 125
        Width = 3
        Height = 13
        Anchors = []
        ExplicitTop = 143
      end
      object FDiastolicl: TLabel
        Left = 453
        Top = 151
        Width = 48
        Height = 13
        Anchors = []
        Caption = 'Diastolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FDiastolicdt: TLabel
        Left = 506
        Top = 173
        Width = 3
        Height = 13
        Anchors = []
      end
      object FTemps: TEdit
        Left = 92
        Top = 101
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 1
      end
      object FHeights: TEdit
        Left = 92
        Top = 148
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 3
      end
      object FWeights: TEdit
        Left = 92
        Top = 196
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 5
      end
      object FTempe: TEdit
        Left = 201
        Top = 101
        Width = 49
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 2
      end
      object FHeighte: TEdit
        Left = 201
        Top = 148
        Width = 49
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 4
      end
      object FWeighte: TEdit
        Left = 201
        Top = 196
        Width = 49
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 6
      end
      object FPulses: TEdit
        Left = 336
        Top = 101
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 7
      end
      object FResps: TEdit
        Left = 336
        Top = 148
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 8
      end
      object FPains: TEdit
        Left = 336
        Top = 196
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 9
      end
      object FSystolics: TEdit
        Left = 506
        Top = 101
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 10
      end
      object FDiastolics: TEdit
        Left = 506
        Top = 148
        Width = 103
        Height = 21
        Anchors = []
        ReadOnly = True
        TabOrder = 11
      end
      object Panel2: TPanel
        Left = 9
        Top = 1
        Width = 238
        Height = 96
        Anchors = []
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          238
          96)
        object FAge: TLabel
          Left = 21
          Top = 13
          Width = 31
          Height = 16
          Anchors = []
          Caption = 'Age:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object FSex: TLabel
          Left = 24
          Top = 39
          Width = 28
          Height = 16
          Anchors = []
          Caption = 'Sex:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object FBMI: TLabel
          Left = 23
          Top = 65
          Width = 29
          Height = 16
          Anchors = []
          Caption = 'BMI:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object FAgeValue: TStaticText
          Left = 58
          Top = 16
          Width = 4
          Height = 4
          Anchors = []
          TabOrder = 0
          TabStop = True
        end
        object FSexValue: TStaticText
          Left = 58
          Top = 42
          Width = 4
          Height = 4
          Anchors = []
          TabOrder = 1
          TabStop = True
        end
        object FBMIValue: TStaticText
          Left = 58
          Top = 68
          Width = 4
          Height = 4
          Anchors = []
          TabOrder = 2
          TabStop = True
        end
      end
      object gbPreg: TGroupBox
        Left = 30
        Top = 240
        Width = 579
        Height = 65
        Anchors = []
        Caption = 'Pregnancy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        TabStop = True
        DesignSize = (
          579
          65)
        object Label16: TLabel
          Left = 36
          Top = 31
          Width = 127
          Height = 13
          Anchors = []
          Caption = 'Pre-pregnancy Weight'
        end
        object Label17: TLabel
          Left = 241
          Top = 31
          Width = 13
          Height = 13
          Anchors = []
          Caption = 'lbs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object spnPrePregWt: TSpinEdit
          Left = 169
          Top = 28
          Width = 66
          Height = 22
          Anchors = []
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
          OnChange = spincheck
        end
      end
    end
    object PageEDD: TTabSheet
      Caption = 'Estimated Delivery Date'
      DoubleBuffered = False
      ImageIndex = 1
      ParentDoubleBuffered = False
      OnResize = PageEDDResize
      OnShow = PageEDDShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        670
        326)
      object Label14: TLabel
        Left = 18
        Top = 16
        Width = 140
        Height = 13
        Caption = 'Gestational Age Today is'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblLMP: TLabel
        Left = 18
        Top = 95
        Width = 103
        Height = 13
        Anchors = []
        Caption = 'Last Menstrual Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitTop = 109
      end
      object lblECD: TLabel
        Left = 18
        Top = 131
        Width = 130
        Height = 13
        Anchors = []
        Caption = 'Estimated Conception Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitTop = 150
      end
      object lblUltra: TLabel
        Left = 18
        Top = 167
        Width = 52
        Height = 13
        Anchors = []
        Caption = 'Ultrasound'
        Layout = tlCenter
        ExplicitTop = 190
      end
      object lblUnknown: TLabel
        Left = 18
        Top = 277
        Width = 44
        Height = 13
        Anchors = []
        Caption = 'Unknown'
        Layout = tlCenter
        ExplicitTop = 315
      end
      object Label9: TLabel
        Left = 18
        Top = 60
        Width = 149
        Height = 13
        Alignment = taCenter
        Anchors = []
        AutoSize = False
        Caption = 'EDD Criteria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 69
      end
      object Label10: TLabel
        Left = 183
        Top = 60
        Width = 100
        Height = 13
        Alignment = taCenter
        Anchors = []
        AutoSize = False
        Caption = 'Event Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 69
      end
      object Label11: TLabel
        Left = 300
        Top = 48
        Width = 103
        Height = 26
        Alignment = taCenter
        Anchors = []
        AutoSize = False
        Caption = 'Gestational Age'#13#10'Weeks   Days'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 56
      end
      object Label12: TLabel
        Left = 421
        Top = 60
        Width = 103
        Height = 13
        Alignment = taCenter
        Anchors = []
        AutoSize = False
        Caption = 'EDD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 69
      end
      object Label13: TLabel
        Left = 558
        Top = 60
        Width = 75
        Height = 13
        Alignment = taCenter
        Anchors = []
        AutoSize = False
        Caption = 'Is Final?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 69
      end
      object dtLMP: TORDateBox
        Left = 183
        Top = 92
        Width = 100
        Height = 21
        Anchors = []
        TabOrder = 2
        Text = 'Today'
        OnExit = dtLMPExit
        DateOnly = True
        RequireTime = False
        Caption = 'Last Menstrual Period Event Date'
      end
      object edtEDDLMP: TORDateBox
        Left = 421
        Top = 92
        Width = 103
        Height = 21
        Anchors = []
        Color = clSilver
        ReadOnly = True
        TabOrder = 3
        DateOnly = True
        RequireTime = False
        Caption = ''
      end
      object dtECD: TORDateBox
        Left = 183
        Top = 128
        Width = 100
        Height = 21
        Anchors = []
        TabOrder = 5
        Text = 'Today'
        OnExit = dtECDExit
        DateOnly = True
        RequireTime = False
        Caption = 'Estimated Conception Date Event Date'
      end
      object edtEDDECD: TORDateBox
        Left = 421
        Top = 128
        Width = 103
        Height = 21
        Anchors = []
        Color = clSilver
        ReadOnly = True
        TabOrder = 6
        DateOnly = True
        RequireTime = False
        Caption = ''
      end
      object dtUltra: TORDateBox
        Left = 183
        Top = 164
        Width = 100
        Height = 21
        Anchors = []
        TabOrder = 8
        Text = 'Today'
        OnExit = dtUltraExit
        DateOnly = True
        RequireTime = False
        Caption = 'Ultrasound Event Date'
      end
      object spnWeekUltra: TSpinEdit
        Left = 300
        Top = 163
        Width = 49
        Height = 22
        Anchors = []
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 0
        OnChange = spnWeekUltraChange
      end
      object spnDayUltra: TSpinEdit
        Left = 355
        Top = 163
        Width = 48
        Height = 22
        Anchors = []
        MaxValue = 0
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnChange = spnDayUltraChange
      end
      object edtEDDUltra: TORDateBox
        Left = 421
        Top = 164
        Width = 103
        Height = 21
        Anchors = []
        Color = clSilver
        ReadOnly = True
        TabOrder = 11
        DateOnly = True
        RequireTime = False
        Caption = ''
      end
      object dtEmbryo: TORDateBox
        Left = 183
        Top = 201
        Width = 100
        Height = 21
        Anchors = []
        TabOrder = 14
        Text = 'Today'
        OnExit = dtEmbryoExit
        DateOnly = True
        RequireTime = False
        Caption = 'Embryo Transfer Event Date'
      end
      object edtEDDEmbryo: TORDateBox
        Left = 421
        Top = 201
        Width = 103
        Height = 21
        Anchors = []
        Color = clSilver
        ReadOnly = True
        TabOrder = 15
        DateOnly = True
        RequireTime = False
        Caption = ''
      end
      object dtOther: TORDateBox
        Left = 183
        Top = 237
        Width = 100
        Height = 21
        Anchors = []
        TabOrder = 18
        Text = 'Today'
        OnExit = lblOtherExit
        DateOnly = True
        RequireTime = False
        Caption = 'Other Criteria Event Date'
      end
      object spnWeekOther: TSpinEdit
        Left = 300
        Top = 236
        Width = 49
        Height = 22
        Anchors = []
        MaxValue = 0
        MinValue = 0
        TabOrder = 19
        Value = 0
        OnChange = spnWeekOtherChange
      end
      object spnDayOther: TSpinEdit
        Left = 355
        Top = 236
        Width = 48
        Height = 22
        Anchors = []
        MaxValue = 0
        MinValue = 0
        TabOrder = 20
        Value = 0
        OnChange = spnDayOtherChange
      end
      object edtEDDOther: TORDateBox
        Left = 421
        Top = 237
        Width = 103
        Height = 21
        Anchors = []
        Color = clSilver
        ReadOnly = True
        TabOrder = 21
        DateOnly = True
        RequireTime = False
        Caption = ''
      end
      object lblOther: TEdit
        Left = 18
        Top = 237
        Width = 149
        Height = 21
        Anchors = []
        MaxLength = 75
        TabOrder = 17
        Text = 'Other Criteria'
        OnChange = lblOtherChange
        OnExit = lblOtherExit
        OnMouseEnter = lblOtherMouseEnter
      end
      object dtEDDUnknown: TORDateBox
        Left = 421
        Top = 274
        Width = 103
        Height = 21
        Anchors = []
        TabOrder = 23
        OnExit = dtEDDUnknownExit
        DateOnly = True
        RequireTime = False
        Caption = 'Unknown Estimated Delivery Date'
      end
      object Panel1: TPanel
        Left = 18
        Top = 191
        Width = 150
        Height = 41
        Anchors = []
        BevelOuter = bvNone
        TabOrder = 13
        DesignSize = (
          150
          41)
        object lblEmbryo: TLabel
          Left = 0
          Top = 13
          Width = 80
          Height = 13
          Anchors = []
          Caption = 'Embryo Transfer'
          Layout = tlCenter
        end
        object cbTransferDay: TCaptionComboBox
          Left = 89
          Top = 10
          Width = 60
          Height = 21
          Style = csDropDownList
          Anchors = []
          DropDownCount = 3
          TabOrder = 0
          OnChange = spnTransferDayChange
          Items.Strings = (
            '3'
            '3-5'
            '5')
          Caption = 'Embryo Transfer Blastocyst Transfer'
        end
      end
      object edtFinalGA: TEdit
        Left = 164
        Top = 13
        Width = 65
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 322
        Top = 4
        Width = 342
        Height = 41
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 1
        object lbFinalEDD: TLabel
          Left = 49
          Top = 12
          Width = 58
          Height = 13
          Caption = 'Final EDD'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 230
          Top = 12
          Width = 16
          Height = 13
          Caption = 'GA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCurrentEDD: TORDateBox
          Left = 113
          Top = 9
          Width = 103
          Height = 21
          Color = clSilver
          ReadOnly = True
          TabOrder = 0
          DateOnly = True
          RequireTime = False
          Caption = ''
        end
        object edtEDDGA: TEdit
          Left = 252
          Top = 9
          Width = 65
          Height = 21
          Color = clSilver
          ReadOnly = True
          TabOrder = 1
        end
      end
      object ckFinalEDDLMP: TCheckBox
        Tag = 1
        Left = 578
        Top = 94
        Width = 40
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 4
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDUltra: TCheckBox
        Tag = 3
        Left = 578
        Top = 166
        Width = 40
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 12
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDEmbryo: TCheckBox
        Tag = 4
        Left = 578
        Top = 203
        Width = 40
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 16
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDOther: TCheckBox
        Tag = 5
        Left = 578
        Top = 239
        Width = 40
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 22
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDUnknown: TCheckBox
        Tag = 6
        Left = 578
        Top = 276
        Width = 40
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 24
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDECD: TCheckBox
        Tag = 2
        Left = 578
        Top = 130
        Width = 40
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 7
        OnClick = IsFinalEDDClick
      end
    end
    object PageLMP: TTabSheet
      Caption = 'Menstrual History'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        670
        326)
      object Label7: TLabel
        Left = 309
        Top = 111
        Width = 295
        Height = 13
        Anchors = []
        Caption = 'What type(s) of contraception were you using most recently?'
        ExplicitTop = 127
      end
      object Label6: TLabel
        Left = 309
        Top = 157
        Width = 61
        Height = 13
        Anchors = []
        Caption = 'Comments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 179
      end
      object Label5: TLabel
        Left = 406
        Top = 62
        Width = 98
        Height = 13
        Anchors = []
        Caption = 'On Contraception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 71
      end
      object lbLMP: TLabel
        Left = 18
        Top = 15
        Width = 123
        Height = 13
        Anchors = []
        Caption = 'Last Menstrual Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 18
      end
      object Label1: TLabel
        Left = 309
        Top = 86
        Width = 195
        Height = 13
        Anchors = []
        Caption = 'On Birth Control Pills at Conception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 98
      end
      object lbHCG: TLabel
        Left = 426
        Top = 33
        Width = 31
        Height = 13
        Anchors = []
        Caption = 'hCG+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 38
      end
      object lbMenarche: TLabel
        Left = 39
        Top = 262
        Width = 56
        Height = 13
        Anchors = []
        Caption = 'Menarche'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 298
      end
      object Label3: TLabel
        Left = 175
        Top = 262
        Width = 64
        Height = 13
        Anchors = []
        Caption = 'Age of Onset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 298
      end
      object edtContraceptionType: TCaptionComboBox
        Left = 309
        Top = 126
        Width = 339
        Height = 21
        Style = csDropDownList
        Anchors = []
        TabOrder = 9
        Caption = 
          'What type or types of contraception were you using most recently' +
          '?'
      end
      object memLMP: TCaptionMemo
        Left = 309
        Top = 176
        Width = 339
        Height = 111
        Anchors = []
        ScrollBars = ssVertical
        TabOrder = 10
        Caption = 'Comments'
      end
      object ckContraceptionNo: TCheckBox
        Tag = 6
        Left = 586
        Top = 61
        Width = 37
        Height = 17
        Anchors = []
        Caption = 'No'
        TabOrder = 6
        OnClick = ToggleCheckBoxes
      end
      object ckContraceptionYes: TCheckBox
        Tag = 5
        Left = 521
        Top = 61
        Width = 52
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 5
        OnClick = ToggleCheckBoxes
      end
      object ckLMPQualifier: TCheckBox
        Left = 209
        Top = 32
        Width = 80
        Height = 17
        Anchors = []
        Caption = 'Approximate'
        TabOrder = 1
      end
      object edtLMP: TORDateBox
        Left = 18
        Top = 30
        Width = 185
        Height = 21
        Anchors = []
        TabOrder = 0
        OnExit = edtLMPExit
        DateOnly = True
        RequireTime = False
        Caption = 'Last Menstrual Period'
      end
      object gbMenses: TGroupBox
        Left = 18
        Top = 51
        Width = 271
        Height = 199
        Anchors = []
        Caption = 'Menses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        DesignSize = (
          271
          199)
        object lbFrequency: TLabel
          Left = 17
          Top = 135
          Width = 153
          Height = 13
          Anchors = []
          Caption = 'Duration of Flow Frequency'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 108
          Top = 157
          Width = 35
          Height = 13
          Anchors = []
          Caption = '# Days'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ckMensesYes: TCheckBox
          Tag = 1
          Left = 76
          Top = 22
          Width = 63
          Height = 17
          Anchors = []
          Caption = 'Normal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = ToggleCheckBoxes
        end
        object ckMensesNo: TCheckBox
          Tag = 2
          Left = 150
          Top = 22
          Width = 80
          Height = 17
          Anchors = []
          Caption = 'Abnormal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ToggleCheckBoxes
        end
        object spnFreq: TSpinEdit
          Left = 34
          Top = 154
          Width = 68
          Height = 22
          Anchors = []
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 3
          Value = 0
          OnChange = spincheck
        end
        object Panel3: TPanel
          Left = 11
          Top = 45
          Width = 251
          Height = 82
          Anchors = []
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          DesignSize = (
            251
            82)
          object Label4: TLabel
            Left = 10
            Top = 34
            Width = 45
            Height = 13
            Anchors = []
            Caption = 'Amount'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 6
            Top = 59
            Width = 49
            Height = 13
            Anchors = []
            Caption = 'Duration'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbMonthly: TLabel
            Left = 9
            Top = 10
            Width = 46
            Height = 13
            Anchors = []
            Caption = 'Monthly'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ckAmountNo: TCheckBox
            Tag = 4
            Left = 139
            Top = 33
            Width = 66
            Height = 17
            Anchors = []
            Caption = 'Abnormal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = ToggleCheckBoxes
          end
          object ckAmountYes: TCheckBox
            Tag = 3
            Left = 65
            Top = 33
            Width = 61
            Height = 17
            Anchors = []
            Caption = 'Normal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ToggleCheckBoxes
          end
          object ckDurationNo: TCheckBox
            Tag = 8
            Left = 139
            Top = 58
            Width = 66
            Height = 17
            Anchors = []
            Caption = 'Abnormal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = ToggleCheckBoxes
          end
          object ckDurationYes: TCheckBox
            Tag = 7
            Left = 65
            Top = 58
            Width = 61
            Height = 17
            Anchors = []
            Caption = 'Normal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = ToggleCheckBoxes
          end
          object ckMonthlyYes: TCheckBox
            Tag = 11
            Left = 65
            Top = 9
            Width = 47
            Height = 17
            Anchors = []
            Caption = 'Yes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ToggleCheckBoxes
          end
          object ckMonthlyNo: TCheckBox
            Tag = 12
            Left = 139
            Top = 9
            Width = 47
            Height = 17
            Anchors = []
            Caption = 'No'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ToggleCheckBoxes
          end
        end
      end
      object ckBirthPillsYes: TCheckBox
        Tag = 9
        Left = 521
        Top = 85
        Width = 52
        Height = 17
        Anchors = []
        Caption = 'Yes'
        TabOrder = 7
        OnClick = ToggleCheckBoxes
      end
      object ckBirthPillsNo: TCheckBox
        Tag = 10
        Left = 586
        Top = 85
        Width = 37
        Height = 17
        Anchors = []
        Caption = 'No'
        TabOrder = 8
        OnClick = ToggleCheckBoxes
      end
      object edthcg: TORDateBox
        Left = 463
        Top = 30
        Width = 185
        Height = 21
        Anchors = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        DateOnly = True
        RequireTime = False
        Caption = 'Human Chorionic Gonadotropin'
      end
      object spnMenarche: TSpinEdit
        Left = 101
        Top = 259
        Width = 68
        Height = 22
        Anchors = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 3
        Value = 0
        OnChange = spincheck
      end
    end
  end
end
