object SearchForm: TSearchForm
  Left = 0
  Top = 0
  Caption = 'SearchForm'
  ClientHeight = 342
  ClientWidth = 526
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
  end
end
