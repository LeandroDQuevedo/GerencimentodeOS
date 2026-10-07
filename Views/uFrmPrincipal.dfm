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
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 96
  TextHeight = 13
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 1107
    Height = 97
    Align = alTop
    TabOrder = 0
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
      Default = True
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
      Width = 80
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
      Left = 896
      Top = 21
      Width = 61
      Height = 21
      Alignment = taCenter
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 8
      Text = '50'
    end
    object Panel20: TPanel
      Left = 1
      Top = 58
      Width = 1105
      Height = 38
      Align = alBottom
      TabOrder = 9
      object Panel3: TPanel
        Left = 525
        Top = 1
        Width = 131
        Height = 36
        Align = alLeft
        TabOrder = 0
        object Label4: TLabel
          Left = -6
          Top = -1
          Width = 137
          Height = 20
          AutoSize = False
          Color = 4868863
          ParentColor = False
          Transparent = False
        end
        object lbEmAtraso: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 123
          Height = 15
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Em atraso:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 129
        end
        object txtTotalAtraso: TDBText
          Left = 1
          Top = 18
          Width = 129
          Height = 17
          Align = alClient
          Alignment = taCenter
          DataField = 'EM_ATRASO'
          DataSource = dmPrincipal.dsTotalizadores
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitTop = 23
          ExplicitHeight = 12
        end
      end
      object Panel4: TPanel
        Left = 263
        Top = 1
        Width = 131
        Height = 36
        Align = alLeft
        TabOrder = 1
        object Label3: TLabel
          Left = -6
          Top = -1
          Width = 137
          Height = 20
          AutoSize = False
          Color = 5283920
          ParentColor = False
          Transparent = False
        end
        object lbConcluidas: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 123
          Height = 15
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Conclu'#237'das:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 129
        end
        object txtTotalConcluidas: TDBText
          Left = 1
          Top = 18
          Width = 129
          Height = 17
          Align = alClient
          Alignment = taCenter
          DataField = 'CONCLUIDAS'
          DataSource = dmPrincipal.dsTotalizadores
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 120
          ExplicitTop = 17
          ExplicitWidth = 65
        end
      end
      object Panel5: TPanel
        Left = 132
        Top = 1
        Width = 131
        Height = 36
        Align = alLeft
        TabOrder = 2
        object txtTotalAndamento: TDBText
          Left = 1
          Top = 18
          Width = 129
          Height = 17
          Align = alClient
          Alignment = taCenter
          DataField = 'EM_ANDAMENTO'
          DataSource = dmPrincipal.dsTotalizadores
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 120
          ExplicitTop = 16
          ExplicitWidth = 65
        end
        object Label2: TLabel
          Left = -1
          Top = -1
          Width = 137
          Height = 20
          AutoSize = False
          Color = 33023
          ParentColor = False
          Transparent = False
        end
        object lbEmAndamento: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 123
          Height = 15
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Em andamento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 129
        end
      end
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 131
        Height = 36
        Align = alLeft
        TabOrder = 3
        object Label1: TLabel
          Left = 0
          Top = -1
          Width = 130
          Height = 20
          AutoSize = False
          Color = 12613680
          ParentColor = False
          Transparent = False
        end
        object lbAbertas: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 123
          Height = 15
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abertas:'
          Color = 12613680
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object txtTotalAberta: TDBText
          Left = 1
          Top = 18
          Width = 129
          Height = 17
          Align = alClient
          Alignment = taCenter
          DataField = 'ABERTAS'
          DataSource = dmPrincipal.dsTotalizadores
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 94
          ExplicitTop = 16
          ExplicitWidth = 65
        end
      end
      object Panel2: TPanel
        Left = 394
        Top = 1
        Width = 131
        Height = 36
        Align = alLeft
        TabOrder = 4
        object Label5: TLabel
          Left = -8
          Top = -1
          Width = 140
          Height = 20
          AutoSize = False
          Color = 9474192
          ParentColor = False
          Transparent = False
        end
        object lbCanceladas: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 3
          Width = 123
          Height = 15
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Canceladas:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 8
          ExplicitTop = 11
          ExplicitWidth = 96
        end
        object txtTotalCanceladas: TDBText
          Left = 1
          Top = 18
          Width = 129
          Height = 17
          Align = alClient
          Alignment = taCenter
          DataField = 'CONCLUIDAS'
          DataSource = dmPrincipal.dsTotalizadores
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 2
          ExplicitTop = 19
          ExplicitWidth = 102
        end
      end
    end
  end
  object pnBotoes: TPanel
    Left = 963
    Top = 97
    Width = 144
    Height = 629
    Align = alRight
    TabOrder = 1
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
      Top = 71
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAbrirCardClick
    end
    object btnDeletarCard: TButton
      Left = 24
      Top = 102
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnDeletarCardClick
    end
    object btnAlterarStatus: TButton
      Left = 24
      Top = 133
      Width = 75
      Height = 25
      Caption = 'Alterar Status'
      TabOrder = 3
      OnClick = btnAlterarStatusClick
    end
    object btnClientes: TButton
      Left = 24
      Top = 164
      Width = 75
      Height = 25
      Caption = 'Clientes'
      TabOrder = 4
      OnClick = btnClientesClick
    end
    object btnRelatorio: TButton
      Left = 24
      Top = 195
      Width = 75
      Height = 25
      Caption = 'Relat'#243'rio'
      TabOrder = 5
      OnClick = btnRelatorioClick
    end
    object btnHistorico: TButton
      Left = 24
      Top = 226
      Width = 75
      Height = 25
      Caption = 'Auditoria'
      TabOrder = 6
      OnClick = btnHistoricoClick
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
    object ctrlGridOS: TDBCtrlGrid
      Left = 1
      Top = 1
      Width = 961
      Height = 627
      Align = alClient
      ColCount = 7
      Color = clBtnFace
      DataSource = dmPrincipal.dsListaOS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      PanelHeight = 209
      PanelWidth = 134
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      OnPaintPanel = ctrlGridOSPaintPanel
      object lbNomeCliente: TLabel
        Left = 7
        Top = 198
        Width = 55
        Height = 13
        AutoSize = False
        Caption = 'CLIENTE'
        Color = 7456511
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object txtNomeCliente: TDBText
        Left = 7
        Top = 215
        Width = 224
        Height = 15
        Color = clBlack
        DataField = 'NOME_CLIENTE'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object txtStatusOS: TDBText
        Left = 0
        Top = 5
        Width = 236
        Height = 28
        Alignment = taCenter
        DataField = 'STATUS'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object txtValorTotal: TDBText
        Left = 122
        Top = 244
        Width = 109
        Height = 24
        Alignment = taRightJustify
        DataField = 'VALOR_TOTAL'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtDataOS: TDBText
        Left = 127
        Top = 38
        Width = 109
        Height = 12
        Alignment = taRightJustify
        DataField = 'DATA_ABERTURA'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtNumeroOS: TDBText
        Left = 6
        Top = 38
        Width = 115
        Height = 28
        DataField = 'ID'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Bevel1: TBevel
        Left = 0
        Top = 236
        Width = 236
        Height = 2
        Shape = bsTopLine
      end
      object txtDataPrev: TDBText
        Left = 7
        Top = 247
        Width = 109
        Height = 12
        DataField = 'DATA_PREVISTA'
        DataSource = dmPrincipal.dsListaOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBImage1: TDBImage
        Left = 60
        Top = 72
        Width = 120
        Height = 120
        DataField = 'MINIATURA'
        DataSource = dmPrincipal.dsListaOS
        Proportional = True
        Stretch = True
        TabOrder = 0
      end
    end
  end
end
