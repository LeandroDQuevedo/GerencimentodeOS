object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Home'
  ClientHeight = 726
  ClientWidth = 1107
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 1107
    Height = 97
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 8
    DesignSize = (
      1107
      97)
    object lbDataEnt: TLabel
      Left = 279
      Top = 12
      Width = 68
      Height = 13
      Alignment = taCenter
      Caption = 'Data Entrada:'
    end
    object lbDataFin: TLabel
      Left = 405
      Top = 34
      Width = 26
      Height = 13
      Alignment = taCenter
      Caption = 'Final:'
    end
    object lbDataIn: TLabel
      Left = 244
      Top = 34
      Width = 29
      Height = 13
      Alignment = taCenter
      Caption = 'In'#237'cio:'
    end
    object lbNumOs: TLabel
      Left = 7
      Top = 12
      Width = 48
      Height = 13
      Alignment = taCenter
      Caption = 'N'#176' da OS:'
    end
    object lbCliente: TLabel
      Left = 95
      Top = 12
      Width = 37
      Height = 13
      Alignment = taCenter
      Caption = 'Cliente:'
    end
    object lbValores: TLabel
      Left = 607
      Top = 12
      Width = 39
      Height = 13
      Alignment = taCenter
      Caption = 'Valores:'
    end
    object lbVlrMax: TLabel
      Left = 702
      Top = 34
      Width = 24
      Height = 13
      Alignment = taCenter
      Caption = 'Max:'
    end
    object lbVlrMin: TLabel
      Left = 587
      Top = 34
      Width = 20
      Height = 13
      Alignment = taCenter
      Caption = 'Min:'
    end
    object lbStatus: TLabel
      Left = 865
      Top = 12
      Width = 35
      Height = 13
      Alignment = taCenter
      Caption = 'Status:'
    end
    object btnLocalizar: TButton
      Left = 963
      Top = 12
      Width = 129
      Height = 39
      Anchors = [akRight]
      Caption = 'Localizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ImageMargins.Right = -30
      Images = dmPrincipal.ListaImagens
      ParentFont = False
      TabOrder = 0
      OnClick = btnLocalizarClick
      ExplicitLeft = 918
    end
    object edtDataFim: TMaskEdit
      Left = 437
      Top = 31
      Width = 118
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object edtDataIni: TMaskEdit
      Left = 279
      Top = 31
      Width = 118
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
    end
    object edtNumOS: TEdit
      Left = 7
      Top = 31
      Width = 74
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      TextHint = 'N'#250'mero OS'
    end
    object edtCliente: TEdit
      Left = 95
      Top = 31
      Width = 125
      Height = 21
      TabOrder = 4
      TextHint = 'Nome do cliente...'
    end
    object cbxStatus: TComboBox
      Left = 865
      Top = 31
      Width = 64
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'Aberta'
        'Em Andamento'
        'Conclu'#237'da'
        'Cancelada')
    end
    object edtValorMax: TEdit
      Left = 726
      Top = 31
      Width = 90
      Height = 21
      TabOrder = 6
      TextHint = 'Valor m'#225'ximo'
    end
    object edtValorMin: TEdit
      Left = 607
      Top = 31
      Width = 90
      Height = 21
      TabOrder = 7
      TextHint = 'Valor m'#237'nimo'
    end
    object edtLimite: TEdit
      Left = 976
      Top = 57
      Width = 108
      Height = 21
      Alignment = taCenter
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 8
      Text = '50'
    end
  end
  object pnBotoes: TPanel
    Left = 963
    Top = 97
    Width = 144
    Height = 629
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 898
    ExplicitTop = 57
    ExplicitHeight = 609
    object btnInserir: TButton
      Left = 24
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Inserir'
      TabOrder = 0
      OnClick = btnInserirClick
    end
    object btnAbrirCard: TButton
      Left = 24
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAbrirCardClick
    end
    object btnDeletarCard: TButton
      Left = 24
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnDeletarCardClick
    end
    object btnAlterarStatus: TButton
      Left = 24
      Top = 185
      Width = 75
      Height = 25
      Caption = 'Alterar Status'
      TabOrder = 3
      OnClick = btnAlterarStatusClick
    end
    object btnClientes: TButton
      Left = 24
      Top = 232
      Width = 75
      Height = 25
      Caption = 'Clientes'
      TabOrder = 4
      OnClick = btnClientesClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 97
    Width = 963
    Height = 629
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    ExplicitTop = 57
    ExplicitWidth = 898
    ExplicitHeight = 609
    object ctrlGridOS: TDBCtrlGrid
      Left = 1
      Top = 1
      Width = 961
      Height = 627
      Align = alClient
      ColCount = 4
      Color = clBtnFace
      DataSource = dmPrincipal.dsListaOS
      PanelHeight = 313
      PanelWidth = 236
      ParentColor = False
      TabOrder = 0
      RowCount = 2
      OnPaintPanel = ctrlGridOSPaintPanel
      ExplicitWidth = 3533
      ExplicitHeight = 606
      object lbNomeCliente: TLabel
        Left = 6
        Top = 165
        Width = 95
        Height = 44
        Alignment = taCenter
        AutoSize = False
        Caption = 'Cliente'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object Label1: TLabel
        Left = 127
        Top = 165
        Width = 64
        Height = 13
        Alignment = taCenter
        Caption = 'Data Entrada'
      end
      object txtNomeCliente: TDBText
        Left = 6
        Top = 181
        Width = 95
        Height = 28
        Alignment = taCenter
        DataField = 'NOME_CLIENTE'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object txtStatusOS: TDBText
        Left = 0
        Top = 5
        Width = 219
        Height = 28
        Alignment = taCenter
        DataField = 'STATUS'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object txtValorTotal: TDBText
        Left = 61
        Top = 231
        Width = 83
        Height = 18
        Alignment = taCenter
        DataField = 'VALOR_TOTAL'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 15
        Font.Name = 'Roboto'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object txtDataOS: TDBText
        Left = 127
        Top = 181
        Width = 73
        Height = 12
        Alignment = taCenter
        DataField = 'DATA_ABERTURA'
        DataSource = dmPrincipal.dsListaOS
      end
      object DBImage1: TDBImage
        Left = 56
        Top = 39
        Width = 105
        Height = 105
        DataField = 'MINIATURA'
        DataSource = dmPrincipal.dsListaOS
        Proportional = True
        Stretch = True
        TabOrder = 0
      end
    end
  end
end
