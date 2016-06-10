object dlgFamily: TdlgFamily
  Tag = 4
  Left = 192
  Top = 175
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Family History'
  ClientHeight = 257
  ClientWidth = 692
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
  object lbRelationship: TLabel
    Left = 13
    Top = 44
    Width = 68
    Height = 14
    Caption = 'Relationship'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblName: TLabel
    Left = 13
    Top = 16
    Width = 31
    Height = 14
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbComments: TLabel
    Left = 13
    Top = 176
    Width = 55
    Height = 14
    Caption = 'Comment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cbRelationship: TComboBox
    Left = 90
    Top = 41
    Width = 226
    Height = 22
    Style = csDropDownList
    TabOrder = 1
    OnChange = cbRelationshipChange
  end
  object cbName: TComboBox
    Left = 90
    Top = 13
    Width = 226
    Height = 22
    Hint = 'Name (LastName,FirstName)'
    TabOrder = 0
    OnChange = cbNameChange
    OnExit = cbNameExit
  end
  object pnlfooter: TPanel
    Left = 0
    Top = 228
    Width = 692
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object btnOK: TBitBtn
      Left = 535
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
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 616
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
  object rgLife: TRadioGroup
    Left = 176
    Top = 73
    Width = 140
    Height = 93
    Caption = 'Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'Living'
      'Deceased')
    ParentFont = False
    TabOrder = 3
    TabStop = True
    OnClick = rgLifeClick
  end
  object rgSex: TRadioGroup
    Left = 13
    Top = 73
    Width = 140
    Height = 93
    Caption = 'Gender'
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
    OnClick = rgSexClick
  end
  object edComment: TEdit
    Left = 13
    Top = 195
    Width = 667
    Height = 22
    MaxLength = 245
    TabOrder = 5
    OnExit = edCommentExit
  end
  object lvPersonList: TListView
    Left = 669
    Top = -115
    Width = 667
    Height = 136
    Columns = <>
    RowSelect = True
    TabOrder = 7
    TabStop = False
    ViewStyle = vsReport
    Visible = False
  end
  object pnlDiagnosis: TPanel
    Left = 322
    Top = 8
    Width = 367
    Height = 169
    BevelOuter = bvNone
    TabOrder = 4
    object lbDiagnosis: TLabel
      Left = 11
      Top = 5
      Width = 54
      Height = 14
      Caption = 'Diagnosis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cklstDiagnosisList: TCheckListBox
      Left = 11
      Top = 24
      Width = 293
      Height = 64
      ItemHeight = 14
      TabOrder = 0
    end
    object btnAdd: TButton
      Left = 310
      Top = 24
      Width = 49
      Height = 64
      Caption = 'Add'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object cklstDiagnosis: TCheckListBox
      Left = 11
      Top = 94
      Width = 293
      Height = 64
      ItemHeight = 14
      TabOrder = 2
    end
    object btnDelete: TButton
      Left = 310
      Top = 94
      Width = 49
      Height = 64
      Caption = 'Delete'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
  end
end
