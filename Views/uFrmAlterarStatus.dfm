object FrmAlterarStatus: TFrmAlterarStatus
  Left = 0
  Top = 0
  Caption = 'Alterar Status'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatusAtual: TLabel
    Left = 224
    Top = 48
    Width = 169
    Height = 25
    Caption = 'Alterar a Situa'#231#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
  end
  object cbxStatus: TComboBox
    Left = 232
    Top = 112
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'Aberta'
    Items.Strings = (
      'Aberta'
      'Em Andamento'
      'Conclu'#237'da'
      'Cancelada')
  end
  object btnConfirmar: TButton
    Left = 168
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    Default = True
    TabOrder = 1
    OnClick = btnConfirmarClick
  end
  object btnCancelar: TButton
    Left = 392
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
end
