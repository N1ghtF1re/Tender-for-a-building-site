object AddListForm: TAddListForm
  Left = 0
  Top = 0
  Caption = 'AddListForm'
  ClientHeight = 325
  ClientWidth = 533
  Color = clBtnFace
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
    Width = 533
    Height = 325
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMain'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object lblInput1: TLabel
      Left = 48
      Top = 24
      Width = 65
      Height = 13
      Caption = #1055#1086#1083#1077' '#1074#1074#1086#1076#1072'1'
    end
    object lblInput2: TLabel
      Left = 48
      Top = 80
      Width = 68
      Height = 13
      Caption = #1055#1086#1083#1077' '#1074#1074#1086#1076#1072' 2'
    end
    object lblInput3: TLabel
      Left = 48
      Top = 136
      Width = 68
      Height = 13
      Caption = #1055#1086#1083#1077' '#1074#1074#1086#1076#1072' 3'
    end
    object lblInput4: TLabel
      Left = 48
      Top = 192
      Width = 42
      Height = 13
      Caption = 'lblInput4'
    end
    object edtInput1: TEdit
      Left = 48
      Top = 43
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtInput2: TEdit
      Left = 48
      Top = 99
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtInput3: TEdit
      Left = 48
      Top = 155
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object btnAddList: TButton
      Left = 48
      Top = 256
      Width = 153
      Height = 57
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 3
      OnClick = btnAddListClick
    end
    object cbbSetCompany: TComboBox
      Left = 48
      Top = 99
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 4
    end
    object cbbSetObject: TComboBox
      Left = 48
      Top = 155
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 5
    end
    object edtInput4: TEdit
      Left = 48
      Top = 219
      Width = 121
      Height = 21
      TabOrder = 6
      Text = 'edtInput4'
    end
  end
end
