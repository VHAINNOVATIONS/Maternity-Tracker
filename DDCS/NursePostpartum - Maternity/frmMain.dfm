object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = lbFeedingMethod
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Nurse Postpartum - Maternal'
  ClientHeight = 443
  ClientWidth = 712
  Color = clBtnFace
  Constraints.MinHeight = 470
  Constraints.MinWidth = 720
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -7
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000000000000B7B7B7B7B7B7B7B7B7B7B00000
    00000070000B000070000B00007000000000000FFBF0FBFF0BFFF0FFFB000000
    000000FFFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFFFF00000
    000000FF88888888888888888FF00000000000FFFBFFFBFFFBFFFBFFFBF00000
    000000FFFFFFFFFFFFFFFFFFFFF000000000007788888888888888888FF00000
    0000000000000000007FFFFFFFF000FBFBFBFBFBFBFBFBFBFB07FBFFFBF000BF
    BFBFBFBFBFBFBFBFBFB07FFFFFF000FBFBFBFBFBFBFBFBFBFBF088888FF0000F
    BFBFBFBFBFBFBFBFBFBF07FFFFF0000BFBFBFBFBFBFBFBFBFBFB07FFFBF00000
    BFBFBFBFBFBFBFBFBFBFB07FFFF00000FBFBFBFBFBFBFBFBFBFBF0888FF00000
    0FBFBFBFBFBFBFBFBFBFBF07FFF000000BFBFBFBFBFBFBFBFBFBFB07FBF00000
    00BFBF0000000000000FBFB07FF0000000FBFB0FFFFFFFFFFF0BFBF08FF00000
    000FBFB0F0F0F0F0FFF0BFBF07F00000000BFBF0FF0F0F0F0FF0FBFB07F00000
    0000BFBF0FFFFFFFFFFF0FBFB07000000000FBFB0000000000000BFBF0700000
    00000FBFBFBFBFBFBFBFBFBFBF00000000000BFBFBFBFBFBFBFBFBFBFB000000
    000000BF8FBF8FBF8FBF8FBF8FB0000000000000800080008000800080000000
    000000008080808080808080808000000000000008000800080008000800FFC0
    0001FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF80
    0000FF800000C0000000800000008000000080000000C0000000C0000000E000
    0000E0000000F0000000F0000000F8000000F8000000FC000000FC000000FE00
    0000FE000000FF000000FF000000FF800000FF800000FFF55555FFFBBBBB}
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 8
  object DDCSForm1: TDDCSForm
    Left = 0
    Top = 0
    Width = 712
    Height = 443
    ActivePage = TabSheet1
    Align = alClient
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OwnerDraw = True
    ParentDoubleBuffered = False
    ParentFont = False
    Style = tsButtons
    TabHeight = 25
    TabOrder = 0
    TabStop = False
    ReportCollection = <
      item
        Order = 0
        IdentifyingName = 'Feeding Method'
        DoNotSpace = True
        DoNotSave = True
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = lbFeedingMethod
        Required = False
      end
      item
        Order = 1
        IdentifyingName = 'Breast Milk'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckBreastMilk
        Required = False
      end
      item
        Order = 2
        IdentifyingName = 'Bottle'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckBottle
        Required = False
      end
      item
        Order = 3
        IdentifyingName = 'Formula'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckFormula
        Required = False
      end
      item
        Order = 4
        IdentifyingName = 'Ongoing Chronic Medical Conditions'
        DoNotSpace = True
        DoNotSave = True
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = lbOngoingChronic
        Required = False
      end
      item
        Order = 5
        IdentifyingName = 'Asthma'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckAsthma
        Required = False
      end
      item
        Order = 6
        IdentifyingName = 'Diabetes'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckDiabetes
        Required = False
      end
      item
        Order = 7
        IdentifyingName = 'Hypertension'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckHypertension
        Required = False
      end
      item
        SayOnFocus = 'Ongoing Chronic Medical Conditions Other'
        Order = 8
        IdentifyingName = 'Ongoing Chronic Medical Conditions Other'
        Prefix = '   Other: '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ledOngoingChronicOther
        Required = False
      end
      item
        Order = 9
        IdentifyingName = 'Maternal Complications'
        DoNotSpace = True
        DoNotSave = True
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = lbMaternalComplications
        Required = False
      end
      item
        Order = 10
        IdentifyingName = 'None'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckNone
        Required = False
      end
      item
        Order = 11
        IdentifyingName = 'Postpartum Hemorrhage'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckPostpartumHemorrhage
        Required = False
      end
      item
        Order = 12
        IdentifyingName = 'Infection'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckInfection
        Required = False
      end
      item
        Order = 13
        IdentifyingName = 'Pre-eclampsia'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ckPreEclampsia
        Required = False
      end
      item
        SayOnFocus = 'Maternal Complications Other'
        Order = 14
        IdentifyingName = 'Maternal Complications Other'
        Prefix = '   Other: '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ledMaternalComplicationsOther
        Required = False
      end
      item
        Order = 15
        IdentifyingName = 'Contraceptive Method'
        DoNotSpace = True
        DoNotSave = True
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = lbContraceptiveMethod
        Required = False
      end
      item
        Order = 16
        IdentifyingName = 'Contraceptive Method'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = cbContraceptiveMethod
        Required = False
      end
      item
        SayOnFocus = 'Contraceptive Method Other'
        Order = 17
        IdentifyingName = 'Contraceptive Method Other'
        Prefix = '   Other: '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ledContraceptiveMethodOther
        Required = False
      end
      item
        Order = 18
        IdentifyingName = 'Comments'
        DoNotSpace = True
        DoNotSave = True
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = lbComments
        Required = False
      end
      item
        Order = 19
        IdentifyingName = 'Comments'
        Prefix = '   '
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = meComments
        Required = False
      end>
    object TabSheet1: TTabSheet
      Caption = 'Overview'
      object lbFeedingMethod: TStaticText
        Left = 20
        Top = 5
        Width = 95
        Height = 17
        Caption = 'Feeding Method'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object lbOngoingChronic: TStaticText
        Left = 355
        Top = 5
        Width = 209
        Height = 17
        Caption = 'Ongoing Chronic Medical Conditions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        TabStop = True
      end
      object lbMaternalComplications: TStaticText
        Left = 20
        Top = 111
        Width = 135
        Height = 17
        Caption = 'Maternal Complications'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        TabStop = True
      end
      object lbContraceptiveMethod: TStaticText
        Left = 355
        Top = 111
        Width = 129
        Height = 17
        Caption = 'Contraceptive Method'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 17
        TabStop = True
      end
      object lbComments: TStaticText
        Left = 20
        Top = 225
        Width = 61
        Height = 17
        Caption = 'Comments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 21
      end
      object ckBreastMilk: TCheckBox
        Left = 36
        Top = 24
        Width = 81
        Height = 17
        Caption = 'Breast Milk'
        TabOrder = 1
      end
      object cbContraceptiveMethod: TCaptionComboBox
        Left = 377
        Top = 130
        Width = 304
        Height = 21
        TabOrder = 18
        Caption = 'Contraceptive Method'
      end
      object ckPreEclampsia: TCheckBox
        Left = 212
        Top = 153
        Width = 97
        Height = 17
        Caption = 'Pre-eclampsia'
        TabOrder = 14
        OnClick = MaternalComplicationsUpdate
      end
      object ckInfection: TCheckBox
        Left = 212
        Top = 130
        Width = 65
        Height = 17
        Caption = 'Infection'
        TabOrder = 13
        OnClick = MaternalComplicationsUpdate
      end
      object ckNone: TCheckBox
        Left = 36
        Top = 130
        Width = 97
        Height = 17
        Caption = 'None'
        TabOrder = 11
        OnClick = MaternalComplicationsUpdate
      end
      object ledMaternalComplicationsOther: TEdit
        Left = 68
        Top = 176
        Width = 245
        Height = 21
        TabOrder = 16
        OnChange = MaternalComplicationsUpdate
      end
      object ledOngoingChronicOther: TEdit
        Left = 410
        Top = 68
        Width = 271
        Height = 21
        TabOrder = 9
      end
      object ckAsthma: TCheckBox
        Left = 377
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Asthma'
        TabOrder = 5
      end
      object ledContraceptiveMethodOther: TEdit
        Left = 410
        Top = 157
        Width = 271
        Height = 21
        TabOrder = 20
      end
      object ckBottle: TCheckBox
        Left = 36
        Top = 47
        Width = 56
        Height = 17
        Caption = 'Bottle'
        TabOrder = 2
      end
      object ckFormula: TCheckBox
        Left = 36
        Top = 70
        Width = 67
        Height = 17
        Caption = 'Formula'
        TabOrder = 3
      end
      object ckDiabetes: TCheckBox
        Left = 377
        Top = 45
        Width = 97
        Height = 17
        Caption = 'Diabetes'
        TabOrder = 6
      end
      object ckHypertension: TCheckBox
        Left = 536
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Hypertension'
        TabOrder = 7
      end
      object ckPostpartumHemorrhage: TCheckBox
        Left = 36
        Top = 153
        Width = 146
        Height = 17
        Caption = 'Postpartum Hemorrhage'
        TabOrder = 12
        OnClick = MaternalComplicationsUpdate
      end
      object meComments: TCaptionMemo
        Left = 20
        Top = 244
        Width = 661
        Height = 117
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 22
        Caption = 'Comments'
      end
      object lbOngoingOther: TStaticText
        Left = 377
        Top = 72
        Width = 30
        Height = 17
        Caption = 'Other'
        TabOrder = 8
      end
      object lbMaternalOther: TStaticText
        Left = 36
        Top = 180
        Width = 30
        Height = 17
        Caption = 'Other'
        TabOrder = 15
      end
      object lbContraceptiveOther: TStaticText
        Left = 377
        Top = 161
        Width = 30
        Height = 17
        Caption = 'Other'
        TabOrder = 19
      end
    end
  end
end
