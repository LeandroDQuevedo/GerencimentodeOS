object FrmRelatorio: TFrmRelatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio'
  ClientHeight = 299
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbDataIn: TLabel
    Left = 185
    Top = 98
    Width = 29
    Height = 13
    Alignment = taCenter
    Caption = 'In'#237'cio:'
  end
  object lbDataFin: TLabel
    Left = 346
    Top = 98
    Width = 26
    Height = 13
    Alignment = taCenter
    Caption = 'Final:'
  end
  object lbCliente: TLabel
    Left = 177
    Top = 59
    Width = 37
    Height = 13
    Alignment = taCenter
    Caption = 'Cliente:'
  end
  object lbVlrMin: TLabel
    Left = 194
    Top = 138
    Width = 20
    Height = 13
    Alignment = taCenter
    Caption = 'Min:'
  end
  object lbVlrMax: TLabel
    Left = 348
    Top = 139
    Width = 24
    Height = 13
    Alignment = taCenter
    Caption = 'Max:'
  end
  object edtDataIni: TMaskEdit
    Left = 220
    Top = 95
    Width = 117
    Height = 21
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object edtDataFim: TMaskEdit
    Left = 378
    Top = 95
    Width = 118
    Height = 21
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object edtCliente: TEdit
    Left = 220
    Top = 56
    Width = 276
    Height = 21
    TabOrder = 2
    TextHint = 'Nome do cliente...'
  end
  object clbStatus: TCheckListBox
    Left = 307
    Top = 173
    Width = 97
    Height = 58
    ItemHeight = 13
    TabOrder = 3
  end
  object edtValorMin: TEdit
    Left = 220
    Top = 135
    Width = 119
    Height = 21
    TabOrder = 4
    TextHint = 'Valor m'#237'nimo'
  end
  object edtValorMax: TEdit
    Left = 378
    Top = 135
    Width = 118
    Height = 21
    TabOrder = 5
    TextHint = 'Valor m'#225'ximo'
  end
  object pbBotoes: TPanel
    Left = 0
    Top = 237
    Width = 713
    Height = 62
    Align = alBottom
    Ctl3D = True
    DoubleBuffered = False
    ParentBackground = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    TabOrder = 6
    object lbExportar: TLabel
      Left = 485
      Top = 7
      Width = 212
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Exportar'
    end
    object btnGerar: TButton
      Left = 307
      Top = 20
      Width = 97
      Height = 25
      Caption = 'Gerar'
      TabOrder = 0
      OnClick = btnGerarClick
    end
    object btnPDF: TButton
      Left = 485
      Top = 26
      Width = 97
      Height = 25
      Caption = 'PDF'
      TabOrder = 1
    end
    object btnCSV: TButton
      Left = 600
      Top = 26
      Width = 97
      Height = 25
      Caption = 'CSV'
      TabOrder = 2
    end
  end
end
