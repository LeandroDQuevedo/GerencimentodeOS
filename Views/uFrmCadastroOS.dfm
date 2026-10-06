object FrmCadastroOS: TFrmCadastroOS
  Left = 617
  Top = 309
  Caption = 'FrmCadastroOS'
  ClientHeight = 543
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 32
    Top = 8
    Width = 177
    Height = 161
    Center = True
    Proportional = True
  end
  object lbDataEnt: TLabel
    Left = 268
    Top = 102
    Width = 93
    Height = 15
    Caption = 'Data de Entrada:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbDataPrev: TLabel
    Left = 471
    Top = 105
    Width = 44
    Height = 15
    Caption = 'Previs'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbCliente: TLabel
    Left = 268
    Top = 39
    Width = 37
    Height = 13
    Caption = 'Cliente:'
  end
  object btnAdicionarFoto: TButton
    Left = 32
    Top = 184
    Width = 177
    Height = 41
    Caption = 'Adicionar Foto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnAdicionarFotoClick
  end
  object edtDataEnt: TMaskEdit
    Left = 268
    Top = 123
    Width = 118
    Height = 21
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object edtDataPrev: TMaskEdit
    Left = 471
    Top = 126
    Width = 118
    Height = 21
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
  object cbxCliente: TDBLookupComboBox
    Left = 268
    Top = 60
    Width = 139
    Height = 21
    KeyField = 'ID'
    ListField = 'NOME'
    ListSource = dmPrincipal.dsCliente
    TabOrder = 3
  end
  object btnAddCliente: TButton
    Left = 311
    Top = 39
    Width = 41
    Height = 15
    Caption = '+ add'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnAddClienteClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 484
    Width = 771
    Height = 59
    Align = alBottom
    TabOrder = 5
    ExplicitTop = 431
    ExplicitWidth = 725
    object btnSalvar: TButton
      Left = 56
      Top = 6
      Width = 97
      Height = 35
      Caption = 'Salvar'
      Default = True
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 517
      Top = 14
      Width = 97
      Height = 35
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 231
    Width = 771
    Height = 253
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 6
    ExplicitTop = 239
    ExplicitWidth = 725
    DesignSize = (
      771
      253)
    object lbDescricao: TLabel
      Left = 84
      Top = 21
      Width = 55
      Height = 15
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 260
      Top = 56
      Width = 112
      Height = 18
      Caption = 'R$'
    end
    object Label2: TLabel
      Left = 382
      Top = 56
      Width = 6
      Height = 13
      Caption = 'X'
    end
    object Label3: TLabel
      Left = 473
      Top = 57
      Width = 8
      Height = 13
      Caption = '='
    end
    object edtDescricao: TEdit
      Left = 16
      Top = 40
      Width = 217
      Height = 207
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TextHint = 'Descreva o servi'#231'o...'
    end
    object LsvMovimentacoes: TListView
      Left = 260
      Top = 80
      Width = 493
      Height = 167
      Anchors = [akLeft, akTop, akRight]
      Columns = <>
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
    object edtDescricaoItem: TEdit
      Left = 260
      Top = 21
      Width = 301
      Height = 21
      TabOrder = 2
      TextHint = 'Descri'#231#227'o...'
    end
    object edtQntd: TEdit
      Left = 394
      Top = 53
      Width = 73
      Height = 21
      TabOrder = 3
      TextHint = 'Quantidade...'
      OnChange = edtValorChange
    end
    object edtValor: TEdit
      Left = 276
      Top = 53
      Width = 97
      Height = 21
      TabOrder = 4
      TextHint = 'Valor Unit'#225'rio'
      OnChange = edtValorChange
    end
    object btnAdicionarItem: TButton
      Left = 573
      Top = 10
      Width = 100
      Height = 21
      Caption = 'Adicionar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnAdicionarItemClick
    end
    object btnRemoveItem: TButton
      Left = 573
      Top = 54
      Width = 100
      Height = 21
      Caption = 'Remover'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = btnRemoveItemClick
    end
    object btnAlterarItem: TButton
      Left = 573
      Top = 32
      Width = 100
      Height = 21
      Caption = 'Alterar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btnAlterarItemClick
    end
    object edtTotal: TEdit
      Left = 486
      Top = 53
      Width = 75
      Height = 21
      Enabled = False
      TabOrder = 8
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf;*.tif;*.ti' +
      'ff)|*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf;*.tif;*.tif' +
      'f|GIF Image (*.gif)|*.gif|Portable Network Graphics (*.png)|*.pn' +
      'g|AAAAAAAAAA|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bm' +
      'p)|*.jpg|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf|Me' +
      'tafiles (*.wmf)|*.wmf|TIFF Images (*.tif)|*.tif|TIFF Images (*.t' +
      'iff)|*.tiff'
    Left = 248
    Top = 176
  end
end
