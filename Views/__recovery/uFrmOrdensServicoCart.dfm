object FrmOrdensServicoCart: TFrmOrdensServicoCart
  Left = 0
  Top = 0
  Caption = 'Ordem de Servi'#231'o: '#39'ID'#39
  ClientHeight = 412
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 412
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitHeight = 523
    DesignSize = (
      419
      412)
    object imOS: TImage
      Left = 112
      Top = 95
      Width = 201
      Height = 153
      Anchors = [akTop]
    end
    object lbCliente: TLabel
      Left = 24
      Top = 281
      Width = 137
      Height = 33
      Alignment = taCenter
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbDataEnt: TLabel
      Left = 256
      Top = 281
      Width = 137
      Height = 40
      Alignment = taCenter
      Caption = 'Data Ent:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbStatus: TLabel
      Left = 0
      Top = 0
      Width = 419
      Height = 40
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtCliente: TEdit
      Left = 24
      Top = 320
      Width = 137
      Height = 38
      Alignment = taCenter
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtDataEnt: TEdit
      Left = 256
      Top = 320
      Width = 137
      Height = 38
      Alignment = taCenter
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
