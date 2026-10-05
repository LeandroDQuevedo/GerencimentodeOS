object FrmCadastroCliente: TFrmCadastroCliente
  Left = 617
  Top = 309
  Caption = 'FrmCadastroCliente'
  ClientHeight = 575
  ClientWidth = 868
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object pnTipoinfo: TPanel
    Left = 0
    Top = 0
    Width = 868
    Height = 49
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -179
    ExplicitWidth = 814
  end
  object pnBtnFinal: TPanel
    Left = 0
    Top = 534
    Width = 868
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = -179
    ExplicitTop = 466
    ExplicitWidth = 814
    object BtnSalvar: TButton
      Left = 604
      Top = 6
      Width = 89
      Height = 25
      Caption = 'Salvar'
      Default = True
      TabOrder = 0
      OnClick = BtnSalvarClick
    end
    object BtnCancelar: TButton
      Left = 763
      Top = 6
      Width = 89
      Height = 25
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = BtnCancelarClick
    end
    object btnDeletar: TButton
      Left = 16
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Deletar'
      Enabled = False
      TabOrder = 2
    end
  end
  object pnCampos: TPanel
    Left = 565
    Top = 49
    Width = 303
    Height = 485
    Align = alRight
    TabOrder = 2
    ExplicitLeft = 296
    object lbCPF: TLabel
      Left = 158
      Top = 193
      Width = 23
      Height = 13
      Caption = 'CPF:'
    end
    object lbEmail: TLabel
      Left = 158
      Top = 147
      Width = 28
      Height = 13
      Caption = 'Email:'
    end
    object lbTelefone: TLabel
      Left = 31
      Top = 193
      Width = 46
      Height = 13
      Caption = 'Telefone:'
    end
    object lbNome: TLabel
      Left = 31
      Top = 147
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object edtEmail: TEdit
      Left = 158
      Top = 166
      Width = 121
      Height = 21
      TabOrder = 1
      TextHint = 'Email...'
    end
    object edtTelefone: TEdit
      Left = 31
      Top = 214
      Width = 121
      Height = 21
      TabOrder = 2
      TextHint = 'Telefone...'
    end
    object edtNome: TEdit
      Left = 31
      Top = 166
      Width = 121
      Height = 21
      TabOrder = 0
      TextHint = 'Nome...'
    end
    object mktCPF: TMaskEdit
      Left = 158
      Top = 214
      Width = 119
      Height = 21
      EditMask = '!999.999.999-99;1;_'
      MaxLength = 14
      TabOrder = 3
      Text = '   .   .   -  '
    end
  end
  object grListaAdd: TDBGrid
    Left = 0
    Top = 49
    Width = 565
    Height = 485
    Align = alClient
    DataSource = dmPrincipal.dsCliente
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = grListaAddCellClick
    OnKeyUp = grListaAddKeyUp
  end
end
