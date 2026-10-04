object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'FrmPrincipal'
  ClientHeight = 666
  ClientWidth = 1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 1088
    Height = 57
    Align = alTop
    TabOrder = 0
    ExplicitTop = 8
    DesignSize = (
      1088
      57)
    object cbxFiltros: TComboBox
      Left = 16
      Top = 21
      Width = 129
      Height = 21
      TabOrder = 0
      Text = 'Filtros...'
      Items.Strings = (
        'Produto'
        'Unidade de Medida'
        'Preco Custo'
        'Preco Venda'
        'Quantidade'
        'Categoria'
        'Marca'
        'Fornecedor')
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
      Left = 951
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
      ExplicitLeft = 641
    end
  end
  object pnBotoes: TPanel
    Left = 944
    Top = 57
    Width = 144
    Height = 609
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 949
    ExplicitTop = 53
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
    end
    object btnDeletarCard: TButton
      Left = 24
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 944
    Height = 609
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    ExplicitLeft = -6
    ExplicitTop = 63
    object ctrlGridOS: TDBCtrlGrid
      Left = 1
      Top = 1
      Width = 942
      Height = 607
      Align = alClient
      ColCount = 4
      DataSource = dmPrincipal.dsListaOS
      PanelHeight = 303
      PanelWidth = 231
      TabOrder = 0
      RowCount = 2
      ExplicitLeft = -4
      ExplicitTop = 6
      object txtNomeCliente: TDBText
        Left = 15
        Top = 165
        Width = 73
        Height = 28
        DataField = 'NOME_CLIENTE'
        DataSource = dmPrincipal.dsListaOS
      end
      object txtStatusOS: TDBText
        Left = 0
        Top = 5
        Width = 231
        Height = 28
        Alignment = taCenter
        DataField = 'STATUS'
        DataSource = dmPrincipal.dsListaOS
        ParentShowHint = False
        ShowHint = False
      end
      object txtDataOS: TDBText
        Left = 134
        Top = 165
        Width = 73
        Height = 18
        DataField = 'NOME_CLIENTE'
        DataSource = dmPrincipal.dsListaOS
      end
      object txtValorTotal: TDBText
        Left = 71
        Top = 215
        Width = 73
        Height = 28
        DataField = 'VALOR_TOTAL'
        DataSource = dmPrincipal.dsListaOS
      end
    end
  end
  object DBImage1: TDBImage
    Left = 56
    Top = 97
    Width = 105
    Height = 105
    DataField = 'FOTO'
    DataSource = dmPrincipal.dsListaOS
    TabOrder = 3
  end
end
