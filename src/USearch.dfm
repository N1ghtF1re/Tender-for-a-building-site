object SearchForm: TSearchForm
  Left = 0
  Top = 0
  Caption = #1055#1086#1080#1089#1082' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1089#1087#1080#1089#1082#1077
  ClientHeight = 342
  ClientWidth = 526
  Color = clBtnFace
  Constraints.MinHeight = 381
  Constraints.MinWidth = 542
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 342
    Align = alClient
    BevelOuter = bvNone
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 32
      Top = 88
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 32
      Top = 144
      Width = 31
      Height = 13
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 32
      Top = 200
      Width = 31
      Height = 13
      Caption = 'Label4'
    end
    object edt1: TEdit
      Left = 32
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'edt1'
    end
    object edt2: TEdit
      Left = 32
      Top = 107
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'edt2'
    end
    object edt3: TEdit
      Left = 32
      Top = 163
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'edt3'
    end
    object edt4: TEdit
      Left = 32
      Top = 219
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'edt4'
    end
    object btnSearch: TButton
      Left = 32
      Top = 280
      Width = 137
      Height = 41
      Caption = #1048#1089#1082#1072#1090#1100
      TabOrder = 4
      OnClick = btnSearchClick
    end
    object cbb1: TComboBox
      Left = 184
      Top = 51
      Width = 145
      Height = 21
      Style = csDropDownList
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 5
    end
    object cbb2: TComboBox
      Left = 184
      Top = 107
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 6
    end
    object cbb3: TComboBox
      Left = 184
      Top = 161
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 7
    end
    object cbb4: TComboBox
      Left = 184
      Top = 219
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 8
    end
    object pnlSidebar: TPanel
      Left = 341
      Top = 0
      Width = 185
      Height = 342
      Align = alRight
      BevelOuter = bvNone
      Color = clInfoBk
      ParentBackground = False
      TabOrder = 9
      object lblHelp: TLabel
        Left = 23
        Top = 54
        Width = 58
        Height = 13
        Caption = #1055#1086#1076#1089#1082#1072#1079#1082#1072': '
        Constraints.MaxHeight = 13
        Constraints.MaxWidth = 58
        Constraints.MinHeight = 13
        Constraints.MinWidth = 58
        WordWrap = True
      end
      object lblHelpText: TLabel
        Left = 24
        Top = 88
        Width = 145
        Height = 156
        Caption = 
          #1047#1072#1087#1086#1083#1085#1080#1090#1077' '#1080#1085#1090#1077#1088#1077#1089#1091#1102#1097#1080#1077' '#1074#1072#1089' '#1087#1086#1083#1103' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072'. '#1045#1089#1083#1080' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1087#1086#1083#1103 +
          ' '#1085#1077#1074#1072#1078#1085#1086' - '#1086#1089#1090#1072#1074#1100#1090#1077' '#1077#1075#1086' '#1087#1091#1089#1090#1099#1084'. '#1057#1087#1088#1072#1074#1072' '#1086#1090' '#1087#1086#1083#1077#1081' '#1077#1089#1090#1100' '#1092#1080#1083#1100#1090#1088#1099', '#1073#1083 +
          #1072#1075#1086#1076#1072#1088#1103' '#1082#1086#1090#1086#1088#1099#1084' '#1074#1099' '#1084#1086#1078#1077#1090#1077' '#1080#1089#1082#1072#1090#1100' '#1085#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1103', '#1072' '#1083#1080#1073 +
          #1086' '#1074#1093#1086#1078#1076#1077#1085#1080#1077' '#1101#1090#1086#1081' '#1087#1086#1076#1089#1090#1088#1086#1082#1080' '#1076#1083#1103' '#1089#1090#1088#1086#1082', '#1083#1080#1073#1086' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1073#1086#1083#1100#1096#1077'/'#1084#1077#1085#1100#1096 +
          #1077' '#1076#1083#1103' '#1094#1080#1092#1088#1086#1074#1099#1093' '#1087#1086#1083#1077#1081
        WordWrap = True
      end
    end
  end
end
