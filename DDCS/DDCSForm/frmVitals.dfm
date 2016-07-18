object DDCSVitals: TDDCSVitals
  Left = 0
  Top = 0
  Width = 698
  Height = 378
  DoubleBuffered = False
  ParentDoubleBuffered = False
  TabOrder = 0
  object fVitalsControl: TPageControl
    Left = 0
    Top = 0
    Width = 698
    Height = 378
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
      object FTempdt: TLabel
        Left = 92
        Top = 143
        Width = 3
        Height = 13
      end
      object FHeightdt: TLabel
        Left = 92
        Top = 214
        Width = 3
        Height = 13
      end
      object FWeightdt: TLabel
        Left = 92
        Top = 285
        Width = 3
        Height = 13
      end
      object FTempl: TLabel
        Left = 12
        Top = 120
        Width = 75
        Height = 13
        Caption = 'Temperature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FHeightl: TLabel
        Left = 50
        Top = 191
        Width = 37
        Height = 13
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
        Top = 262
        Width = 40
        Height = 13
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
        Top = 143
        Width = 3
        Height = 13
      end
      object FPulsel: TLabel
        Left = 301
        Top = 120
        Width = 30
        Height = 13
        Caption = 'Pulse'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FRespl: TLabel
        Left = 266
        Top = 191
        Width = 65
        Height = 13
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
        Top = 214
        Width = 3
        Height = 13
      end
      object FPainl: TLabel
        Left = 307
        Top = 262
        Width = 24
        Height = 13
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
        Top = 285
        Width = 3
        Height = 13
      end
      object FSystolicl: TLabel
        Left = 457
        Top = 120
        Width = 44
        Height = 13
        Caption = 'Systolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FSystolicdt: TLabel
        Left = 506
        Top = 143
        Width = 3
        Height = 13
      end
      object FDiastolicl: TLabel
        Left = 453
        Top = 191
        Width = 48
        Height = 13
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
        Top = 214
        Width = 3
        Height = 13
      end
      object FTemps: TEdit
        Left = 92
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object FHeights: TEdit
        Left = 92
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 3
      end
      object FWeights: TEdit
        Left = 92
        Top = 258
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object FTempe: TEdit
        Left = 201
        Top = 116
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 2
      end
      object FHeighte: TEdit
        Left = 201
        Top = 187
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 4
      end
      object FWeighte: TEdit
        Left = 201
        Top = 258
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 6
      end
      object FPulses: TEdit
        Left = 336
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 7
      end
      object FResps: TEdit
        Left = 336
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 8
      end
      object FPains: TEdit
        Left = 336
        Top = 258
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 9
      end
      object FSystolics: TEdit
        Left = 506
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 10
      end
      object FDiastolics: TEdit
        Left = 506
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 11
      end
      object Panel2: TPanel
        Left = 9
        Top = 8
        Width = 238
        Height = 96
        BevelOuter = bvNone
        TabOrder = 0
        object FAge: TLabel
          Left = 21
          Top = 13
          Width = 31
          Height = 16
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
          TabOrder = 0
          TabStop = True
        end
        object FSexValue: TStaticText
          Left = 58
          Top = 42
          Width = 4
          Height = 4
          TabOrder = 1
          TabStop = True
        end
        object FBMIValue: TStaticText
          Left = 58
          Top = 68
          Width = 4
          Height = 4
          TabOrder = 2
          TabStop = True
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
      DesignSize = (
        670
        370)
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
        Top = 109
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
      end
      object lblECD: TLabel
        Left = 18
        Top = 150
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
      end
      object lblUltra: TLabel
        Left = 18
        Top = 190
        Width = 52
        Height = 13
        Anchors = []
        Caption = 'Ultrasound'
        Layout = tlCenter
      end
      object lblUnknown: TLabel
        Left = 18
        Top = 315
        Width = 44
        Height = 13
        Anchors = []
        Caption = 'Unknown'
        Layout = tlCenter
      end
      object Label9: TLabel
        Left = 18
        Top = 69
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
      end
      object Label10: TLabel
        Left = 183
        Top = 69
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
      end
      object Label11: TLabel
        Left = 300
        Top = 56
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
      end
      object Label12: TLabel
        Left = 421
        Top = 69
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
      end
      object Label13: TLabel
        Left = 558
        Top = 69
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
      end
      object dtLMP: TORDateBox
        Left = 183
        Top = 106
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
        Top = 106
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
        Top = 147
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
        Top = 147
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
        Top = 188
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
        Top = 187
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
        Top = 187
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
        Top = 188
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
        Top = 229
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
        Top = 229
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
        Top = 270
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
        Top = 269
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
        Top = 269
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
        Top = 270
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
        Top = 270
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
      object ckFinalEDDLMP: TCheckBox
        Tag = 1
        Left = 575
        Top = 108
        Width = 50
        Height = 17
        Hint = 'IsFinal'
        Anchors = []
        Caption = 'Yes'
        TabOrder = 4
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDECD: TCheckBox
        Tag = 2
        Left = 575
        Top = 149
        Width = 50
        Height = 17
        Hint = 'IsFinal'
        Anchors = []
        Caption = 'Yes'
        TabOrder = 7
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDUltra: TCheckBox
        Tag = 3
        Left = 575
        Top = 190
        Width = 50
        Height = 17
        Hint = 'IsFinal'
        Anchors = []
        Caption = 'Yes'
        TabOrder = 12
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDEmbryo: TCheckBox
        Tag = 4
        Left = 575
        Top = 231
        Width = 50
        Height = 17
        Hint = 'IsFinal'
        Anchors = []
        Caption = 'Yes'
        TabOrder = 16
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDOther: TCheckBox
        Tag = 5
        Left = 575
        Top = 272
        Width = 50
        Height = 17
        Hint = 'IsFinal'
        Anchors = []
        Caption = 'Yes'
        TabOrder = 22
        OnClick = IsFinalEDDClick
      end
      object ckFinalEDDUnknown: TCheckBox
        Tag = 6
        Left = 575
        Top = 314
        Width = 50
        Height = 17
        Hint = 'IsFinal'
        Anchors = []
        Caption = 'Yes'
        TabOrder = 24
        OnClick = IsFinalEDDClick
      end
      object dtEDDUnknown: TORDateBox
        Left = 421
        Top = 312
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
        Top = 219
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
    end
    object PageLMP: TTabSheet
      Caption = 'Menstrual History'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label7: TLabel
        Left = 309
        Top = 127
        Width = 295
        Height = 13
        Caption = 'What type(s) of contraception were you using most recently?'
      end
      object Label6: TLabel
        Left = 309
        Top = 179
        Width = 61
        Height = 13
        Caption = 'Comments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 406
        Top = 71
        Width = 98
        Height = 13
        Caption = 'On Contraception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbLMP: TLabel
        Left = 18
        Top = 18
        Width = 123
        Height = 13
        Caption = 'Last Menstrual Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 309
        Top = 98
        Width = 195
        Height = 13
        Caption = 'On Birth Control Pills at Conception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbHCG: TLabel
        Left = 426
        Top = 38
        Width = 31
        Height = 13
        Caption = 'hCG+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMenarche: TLabel
        Left = 39
        Top = 298
        Width = 56
        Height = 13
        Caption = 'Menarche'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 175
        Top = 298
        Width = 64
        Height = 13
        Caption = 'Age of Onset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtContraceptionType: TCaptionComboBox
        Left = 309
        Top = 144
        Width = 339
        Height = 21
        Style = csDropDownList
        TabOrder = 9
        Caption = 
          'What type or types of contraception were you using most recently' +
          '?'
      end
      object memLMP: TCaptionMemo
        Left = 309
        Top = 196
        Width = 339
        Height = 121
        ScrollBars = ssVertical
        TabOrder = 10
        Caption = 'Comments'
      end
      object ckContraceptionNo: TCheckBox
        Tag = 6
        Left = 586
        Top = 70
        Width = 37
        Height = 17
        Caption = 'No'
        TabOrder = 6
        OnClick = ToggleCheckBoxes
      end
      object ckContraceptionYes: TCheckBox
        Tag = 5
        Left = 521
        Top = 70
        Width = 52
        Height = 17
        Caption = 'Yes'
        TabOrder = 5
        OnClick = ToggleCheckBoxes
      end
      object ckLMPQualifier: TCheckBox
        Left = 209
        Top = 37
        Width = 80
        Height = 17
        Caption = 'Approximate'
        TabOrder = 1
      end
      object edtLMP: TORDateBox
        Left = 18
        Top = 35
        Width = 185
        Height = 21
        TabOrder = 0
        OnExit = edtLMPExit
        DateOnly = True
        RequireTime = False
        Caption = 'Last Menstrual Period'
      end
      object gbMenses: TGroupBox
        Left = 18
        Top = 71
        Width = 271
        Height = 199
        Caption = 'Menses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lbMonthly: TLabel
          Left = 20
          Top = 55
          Width = 46
          Height = 13
          Caption = 'Monthly'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbFrequency: TLabel
          Left = 17
          Top = 143
          Width = 153
          Height = 13
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
          Top = 163
          Width = 35
          Height = 13
          Caption = '# Days'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 152
          Top = 55
          Width = 35
          Height = 13
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
          Left = 49
          Top = 22
          Width = 63
          Height = 17
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
          Left = 137
          Top = 22
          Width = 80
          Height = 17
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
        object spnMonthly: TSpinEdit
          Left = 78
          Top = 52
          Width = 68
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 0
          OnChange = spincheck
        end
        object spnFreq: TSpinEdit
          Left = 34
          Top = 160
          Width = 68
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 4
          Value = 0
          OnChange = spincheck
        end
        object Panel3: TPanel
          Left = 11
          Top = 78
          Width = 251
          Height = 62
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Label4: TLabel
            Left = 10
            Top = 11
            Width = 45
            Height = 13
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
            Top = 36
            Width = 49
            Height = 13
            Caption = 'Duration'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ckAmountNo: TCheckBox
            Tag = 4
            Left = 149
            Top = 10
            Width = 66
            Height = 17
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
          object ckAmountYes: TCheckBox
            Tag = 3
            Left = 67
            Top = 10
            Width = 61
            Height = 17
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
          object ckDurationNo: TCheckBox
            Tag = 8
            Left = 149
            Top = 35
            Width = 66
            Height = 17
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
          object ckDurationYes: TCheckBox
            Tag = 7
            Left = 67
            Top = 35
            Width = 61
            Height = 17
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
        end
      end
      object ckBirthPillsYes: TCheckBox
        Tag = 9
        Left = 521
        Top = 97
        Width = 52
        Height = 17
        Caption = 'Yes'
        TabOrder = 7
        OnClick = ToggleCheckBoxes
      end
      object ckBirthPillsNo: TCheckBox
        Tag = 10
        Left = 586
        Top = 97
        Width = 37
        Height = 17
        Caption = 'No'
        TabOrder = 8
        OnClick = ToggleCheckBoxes
      end
      object edthcg: TORDateBox
        Left = 463
        Top = 35
        Width = 185
        Height = 21
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
        Top = 295
        Width = 68
        Height = 22
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
