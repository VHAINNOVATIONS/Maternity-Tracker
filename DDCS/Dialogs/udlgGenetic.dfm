object dlgGenetic: TdlgGenetic
  Tag = 4
  Left = 212
  Top = 164
  BorderStyle = bsDialog
  ClientHeight = 547
  ClientWidth = 537
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
  object Label3: TLabel
    Left = 11
    Top = 48
    Width = 341
    Height = 14
    Caption = 
      'Includes patient, baby'#39's father, or anyone in either family with' +
      ':'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label6: TLabel
    Left = 20
    Top = 68
    Width = 280
    Height = 14
    Hint = 'Patient'#39's age >/= 35 years as of estimated date of delivery: Yes'
    Caption = 'Patient'#39's age >/= 35 years as of estimated date of delivery'
  end
  object Label1: TLabel
    Left = 20
    Top = 87
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 
      'Thalassemia (Italian, Greek, Mediterranean, or Asia Background):' +
      ' MCV<80'
    Color = clMoneyGreen
    Constraints.MinWidth = 490
    ParentColor = False
    Transparent = False
    Layout = tlCenter
    OnClick = CheckBox1Click
  end
  object Label2: TLabel
    Left = 20
    Top = 125
    Width = 492
    Height = 17
    Hint = 
      'Neural Tube Defect (Meningomyelocele, Spina Bifida, or Anencepha' +
      'ly): Yes'
    AutoSize = False
    Caption = 
      'Neural Tube Defect (Meningomyelocele, Spina Bifida, or Anencepha' +
      'ly)'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 20
    Top = 144
    Width = 490
    Height = 14
    Caption = 'Congenital Heart Defect'
    Color = clBtnFace
    Constraints.MinWidth = 490
    ParentColor = False
  end
  object Label5: TLabel
    Left = 20
    Top = 163
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'Down Syndrome'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 20
    Top = 182
    Width = 490
    Height = 14
    Caption = 'Tay-Sachs (EG, Ashkenazi, Cajun, French Canadian)'
    Color = clBtnFace
    Constraints.MinWidth = 490
    ParentColor = False
  end
  object Label8: TLabel
    Left = 20
    Top = 201
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'Canavan Disease'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label9: TLabel
    Left = 20
    Top = 220
    Width = 490
    Height = 14
    Caption = 'Sickle Cell Disease or Trait (African)'
    Color = clBtnFace
    Constraints.MinWidth = 490
    ParentColor = False
  end
  object Label10: TLabel
    Left = 20
    Top = 239
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'Hemophilia or Other Blood Disorders'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label11: TLabel
    Left = 20
    Top = 258
    Width = 490
    Height = 14
    Caption = 'Muscular Dystrophy'
    Color = clBtnFace
    Constraints.MinWidth = 490
    ParentColor = False
  end
  object Label12: TLabel
    Left = 20
    Top = 277
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'Cystic Fibrosis'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label13: TLabel
    Left = 20
    Top = 296
    Width = 490
    Height = 14
    Caption = 'Huntington'#39's Chorea'
    Color = clBtnFace
    Constraints.MinWidth = 490
    ParentColor = False
  end
  object Label14: TLabel
    Left = 20
    Top = 315
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'Mental Retardation/Autism'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label15: TLabel
    Left = 20
    Top = 334
    Width = 163
    Height = 14
    Caption = ' Was person tested for Fragile X?'
    Visible = False
  end
  object Label16: TLabel
    Left = 20
    Top = 353
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'Other inherited genetic or chromosomal disorder'
    Color = clMoneyGreen
    Constraints.MinWidth = 490
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label17: TLabel
    Left = 20
    Top = 372
    Width = 267
    Height = 14
    Caption = 'Maternal Metabolic Disorder (EG, Type 1 Diabetes, PKU)'
  end
  object Label18: TLabel
    Left = 21
    Top = 391
    Width = 492
    Height = 17
    AutoSize = False
    Caption = 
      'Patient or Baby'#39's father had a child with birth defects not list' +
      'ed above '
    Color = clMoneyGreen
    Constraints.MinWidth = 490
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label19: TLabel
    Left = 20
    Top = 442
    Width = 190
    Height = 14
    Hint = 'Recurrent pregnancy loss or a still birth: Yes'
    Caption = 'Recurrent pregnancy loss or a still birth'
  end
  object Label20: TLabel
    Left = 20
    Top = 461
    Width = 493
    Height = 17
    AutoSize = False
    Caption = 'History of multiple births'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label21: TLabel
    Left = 20
    Top = 106
    Width = 82
    Height = 14
    Caption = 'Jewish Ancestry'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 537
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
      Width = 150
      Height = 20
      Caption = 'Genetic Screening'
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
    Top = 518
    Width = 537
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 43
    object bbtnOK: TBitBtn
      Left = 378
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 459
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 4
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
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 423
    Top = 68
    Width = 45
    Height = 17
    Hint = 
      'Patient'#39's age >/= 35 years as of estimated date of delivery: Yes' +
      ' '
    Caption = 'Yes'
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Tag = 2
    Left = 474
    Top = 68
    Width = 39
    Height = 17
    Hint = 'Patient'#39's age >/= 35 years as of estimated date of delivery: No'
    Caption = 'No'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object CheckBox3: TCheckBox
    Tag = 3
    Left = 423
    Top = 87
    Width = 45
    Height = 17
    Hint = 
      'Thalassemia (Italian, Greek, Mediterranean, or Asia Background):' +
      ' MCV<80: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object CheckBox4: TCheckBox
    Tag = 4
    Left = 474
    Top = 87
    Width = 39
    Height = 17
    Hint = 
      'Thalassemia (Italian, Greek, Mediterranean, or Asia Background):' +
      ' MCV<80: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object CheckBox39: TCheckBox
    Tag = 39
    Left = 423
    Top = 106
    Width = 44
    Height = 17
    Hint = 'Jewish Ancestry: Yes'
    Caption = 'Yes'
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object CheckBox40: TCheckBox
    Tag = 40
    Left = 474
    Top = 106
    Width = 39
    Height = 17
    Hint = 'Jewish Ancestry: No'
    Caption = 'No'
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object CheckBox5: TCheckBox
    Tag = 5
    Left = 423
    Top = 125
    Width = 45
    Height = 17
    Hint = 
      'Neural Tube Defect (Meningomyelocele, Spina Bifida, or Anencepha' +
      'ly): Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 7
    OnClick = CheckBox1Click
  end
  object CheckBox6: TCheckBox
    Tag = 6
    Left = 474
    Top = 125
    Width = 39
    Height = 17
    Hint = 
      'Neural Tube Defect (Meningomyelocele, Spina Bifida, or Anencepha' +
      'ly): No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object CheckBox7: TCheckBox
    Tag = 7
    Left = 423
    Top = 144
    Width = 45
    Height = 17
    Hint = 'Congenital Heart Defect: Yes'
    Caption = 'Yes'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 9
    OnClick = CheckBox1Click
  end
  object CheckBox8: TCheckBox
    Tag = 8
    Left = 474
    Top = 144
    Width = 39
    Height = 17
    Hint = 'Congenital Heart Defect: No'
    Caption = 'No'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 10
    OnClick = CheckBox1Click
  end
  object CheckBox9: TCheckBox
    Tag = 9
    Left = 423
    Top = 163
    Width = 45
    Height = 17
    Hint = 'Down Syndrome: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 11
    OnClick = CheckBox1Click
  end
  object CheckBox10: TCheckBox
    Tag = 10
    Left = 474
    Top = 163
    Width = 39
    Height = 17
    Hint = 'Down Syndrome: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 12
    OnClick = CheckBox1Click
  end
  object CheckBox11: TCheckBox
    Tag = 11
    Left = 423
    Top = 182
    Width = 45
    Height = 17
    Hint = 'Tay-Sachs (EG, Jewish, Cajun, French Canadian): Yes'
    Caption = 'Yes'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 13
    OnClick = CheckBox1Click
  end
  object CheckBox12: TCheckBox
    Tag = 12
    Left = 474
    Top = 182
    Width = 39
    Height = 17
    Hint = 'Tay-Sachs (EG, Jewish, Cajun, French Canadian): No'
    Caption = 'No'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 14
    OnClick = CheckBox1Click
  end
  object CheckBox13: TCheckBox
    Tag = 13
    Left = 423
    Top = 201
    Width = 45
    Height = 17
    Hint = 'Canavan Disease: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 15
    OnClick = CheckBox1Click
  end
  object CheckBox14: TCheckBox
    Tag = 14
    Left = 474
    Top = 201
    Width = 39
    Height = 17
    Hint = 'Canavan Disease: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 16
    OnClick = CheckBox1Click
  end
  object CheckBox15: TCheckBox
    Tag = 15
    Left = 423
    Top = 220
    Width = 45
    Height = 17
    Hint = 'Sickle Cell Disease or Trait (African): Yes'
    Caption = 'Yes'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 17
    OnClick = CheckBox1Click
  end
  object CheckBox16: TCheckBox
    Tag = 16
    Left = 474
    Top = 220
    Width = 39
    Height = 17
    Hint = 'Sickle Cell Disease or Trait (African): No'
    Caption = 'No'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 18
    OnClick = CheckBox1Click
  end
  object CheckBox17: TCheckBox
    Tag = 17
    Left = 423
    Top = 239
    Width = 45
    Height = 17
    Hint = 'Hemophilia or Other Blood Disorders: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 19
    OnClick = CheckBox1Click
  end
  object CheckBox18: TCheckBox
    Tag = 18
    Left = 474
    Top = 239
    Width = 39
    Height = 17
    Hint = 'Hemophilia or Other Blood Disorders: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 20
    OnClick = CheckBox1Click
  end
  object CheckBox19: TCheckBox
    Tag = 19
    Left = 423
    Top = 258
    Width = 45
    Height = 17
    Hint = 'Muscular Dystrophy: Yes'
    Caption = 'Yes'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 21
    OnClick = CheckBox1Click
  end
  object CheckBox20: TCheckBox
    Tag = 20
    Left = 474
    Top = 258
    Width = 39
    Height = 17
    Hint = 'Muscular Dystrophy: No'
    Caption = 'No'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 22
    OnClick = CheckBox1Click
  end
  object CheckBox21: TCheckBox
    Tag = 21
    Left = 423
    Top = 277
    Width = 45
    Height = 17
    Hint = 'Cystic Fibrosis: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 23
    OnClick = CheckBox1Click
  end
  object CheckBox22: TCheckBox
    Tag = 22
    Left = 474
    Top = 277
    Width = 39
    Height = 17
    Hint = 'Cystic Fibrosis: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 24
    OnClick = CheckBox1Click
  end
  object CheckBox23: TCheckBox
    Tag = 23
    Left = 423
    Top = 296
    Width = 45
    Height = 17
    Hint = 'Huntington'#39's Chorea: Yes'
    Caption = 'Yes'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 25
    OnClick = CheckBox1Click
  end
  object CheckBox24: TCheckBox
    Tag = 24
    Left = 474
    Top = 296
    Width = 39
    Height = 17
    Hint = 'Huntington'#39's Chorea: No'
    Caption = 'No'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 26
    OnClick = CheckBox1Click
  end
  object CheckBox25: TCheckBox
    Tag = 25
    Left = 423
    Top = 315
    Width = 45
    Height = 17
    Hint = 'Mental Retardation/Autism: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 27
    OnClick = CheckBox1Click
  end
  object CheckBox26: TCheckBox
    Tag = 26
    Left = 474
    Top = 315
    Width = 39
    Height = 17
    Hint = 'Mental Retardation/Autism: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 28
    OnClick = CheckBox1Click
  end
  object CheckBox27: TCheckBox
    Tag = 27
    Left = 423
    Top = 334
    Width = 45
    Height = 17
    Hint = 'Was person tested for Fragile X?: Yes'
    Caption = 'Yes'
    TabOrder = 29
    Visible = False
    OnClick = CheckBox1Click
  end
  object CheckBox28: TCheckBox
    Tag = 28
    Left = 474
    Top = 334
    Width = 39
    Height = 17
    Hint = ' Was person tested for Fragile X?: No'
    Caption = 'No'
    TabOrder = 30
    Visible = False
    OnClick = CheckBox1Click
  end
  object CheckBox29: TCheckBox
    Tag = 29
    Left = 423
    Top = 353
    Width = 45
    Height = 17
    Hint = 'Other inherited genetic or chromosomal disorder: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 31
    OnClick = CheckBox1Click
  end
  object CheckBox30: TCheckBox
    Tag = 30
    Left = 474
    Top = 353
    Width = 39
    Height = 17
    Hint = 'Other inherited genetic or chromosomal disorder: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 32
    OnClick = CheckBox1Click
  end
  object CheckBox31: TCheckBox
    Tag = 31
    Left = 423
    Top = 372
    Width = 45
    Height = 17
    Hint = 'Maternal Metabolic Disorder (EG, Type 1 Diabetes, PKU): Yes'
    Caption = 'Yes'
    TabOrder = 33
    OnClick = CheckBox1Click
  end
  object CheckBox32: TCheckBox
    Tag = 32
    Left = 474
    Top = 372
    Width = 39
    Height = 17
    Hint = 'Maternal Metabolic Disorder (EG, Type 1 Diabetes, PKU): No'
    Caption = 'No'
    TabOrder = 34
    OnClick = CheckBox1Click
  end
  object CheckBox33: TCheckBox
    Tag = 33
    Left = 423
    Top = 391
    Width = 45
    Height = 17
    Hint = 
      'Patient or Baby'#39's father had a child with birth defects not list' +
      'ed above : Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 35
    OnClick = CheckBox1Click
  end
  object CheckBox34: TCheckBox
    Tag = 34
    Left = 474
    Top = 391
    Width = 39
    Height = 17
    Hint = 
      'Patient or Baby'#39's father had a child with birth defects not list' +
      'ed above: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 36
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 20
    Top = 416
    Width = 493
    Height = 22
    TabOrder = 37
    Visible = False
  end
  object CheckBox35: TCheckBox
    Tag = 35
    Left = 423
    Top = 442
    Width = 45
    Height = 17
    Hint = 'Recurrent pregnancy loss or a still birth: Yes'
    Caption = 'Yes'
    TabOrder = 38
    OnClick = CheckBox1Click
  end
  object CheckBox36: TCheckBox
    Tag = 36
    Left = 474
    Top = 442
    Width = 39
    Height = 17
    Hint = 'Recurrent pregnancy loss or a still birth: No'
    Caption = 'No'
    TabOrder = 39
    OnClick = CheckBox1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 60
    Top = 487
    Width = 453
    Height = 22
    EditLabel.Width = 30
    EditLabel.Height = 14
    EditLabel.Caption = 'Other:'
    LabelPosition = lpLeft
    TabOrder = 42
  end
  object CheckBox37: TCheckBox
    Tag = 37
    Left = 423
    Top = 461
    Width = 41
    Height = 17
    Hint = 'History of multiple births: Yes'
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 40
    OnClick = CheckBox1Click
  end
  object CheckBox38: TCheckBox
    Tag = 38
    Left = 474
    Top = 461
    Width = 39
    Height = 17
    Hint = 'History of multiple births: No'
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 41
    OnClick = CheckBox1Click
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = dlgGenetic'
        'Status = stsDefault'))
  end
end
