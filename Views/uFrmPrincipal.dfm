object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'FrmPrincipal'
  ClientHeight = 666
  ClientWidth = 1042
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 1042
    Height = 57
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1088
    DesignSize = (
      1042
      57)
    object cbxFiltros: TComboBox
      Left = 16
      Top = 21
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'N'#186' da OS'
      Items.Strings = (
        'N'#186' da OS'
        'Cliente')
    end
    object edtPesquisa: TEdit
      Left = 167
      Top = 21
      Width = 170
      Height = 21
      TabOrder = 1
      TextHint = '...'
    end
    object btnLocalizar: TButton
      Left = 905
      Top = 8
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
      TabOrder = 2
      OnClick = btnLocalizarClick
      ExplicitLeft = 951
    end
  end
  object pnBotoes: TPanel
    Left = 898
    Top = 57
    Width = 144
    Height = 609
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 944
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
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnDeletarCardClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 898
    Height = 609
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    ExplicitWidth = 944
    object ctrlGridOS: TDBCtrlGrid
      Left = 1
      Top = 1
      Width = 896
      Height = 607
      Align = alClient
      ColCount = 4
      DataSource = dmPrincipal.dsListaOS
      PanelHeight = 303
      PanelWidth = 219
      TabOrder = 0
      RowCount = 2
      OnPaintPanel = ctrlGridOSPaintPanel
      ExplicitLeft = 33
      ExplicitTop = -9
      object lbNomeCliente: TLabel
        Left = 15
        Top = 165
        Width = 73
        Height = 28
        Alignment = taCenter
        Caption = 'Cliente'
        Transparent = False
      end
      object Label1: TLabel
        Left = 127
        Top = 165
        Width = 73
        Height = 28
        Alignment = taCenter
        Caption = 'Data Entrada'
      end
      object txtNomeCliente: TDBText
        Left = 15
        Top = 181
        Width = 73
        Height = 28
        DataField = 'NOME_CLIENTE'
        DataSource = dmPrincipal.dsListaOS
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
