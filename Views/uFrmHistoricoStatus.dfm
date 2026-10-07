object FrmHistoricoStatus: TFrmHistoricoStatus
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auditoria'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbSemHistorico: TLabel
    Left = 0
    Top = 0
    Width = 645
    Height = 274
    Align = alClient
    Alignment = taCenter
    Caption = 'Nenhuma altera'#231#227'o de situa'#231#227'o registrada para esta OS.'
    Layout = tlCenter
    Visible = False
    ExplicitLeft = 280
    ExplicitTop = 144
    ExplicitWidth = 273
    ExplicitHeight = 13
  end
  object grHistorico: TDBGrid
    Left = 0
    Top = 0
    Width = 645
    Height = 274
    Align = alClient
    DataSource = dmPrincipal.dsHistoricoStatus
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 274
    Width = 645
    Height = 35
    Align = alBottom
    TabOrder = 1
    object btnFechar: TButton
      Left = 296
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      ModalResult = 2
      TabOrder = 0
    end
  end
end
