object Form1: TForm1
  Left = 0
  Top = 0
  Width = 639
  Height = 526
  ActiveControl = edtCodigo
  AutoScroll = True
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblErro: TLabel
    Left = 0
    Top = 474
    Width = 623
    Height = 13
    Align = alBottom
    Caption = '...'
    Layout = tlCenter
    ExplicitWidth = 12
  end
  object sgProdutos: TStringGrid
    Left = 0
    Top = 73
    Width = 623
    Height = 401
    TabStop = False
    Align = alClient
    BorderStyle = bsNone
    DefaultColWidth = 100
    DoubleBuffered = True
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goRowSelect]
    ParentDoubleBuffered = False
    TabOrder = 0
    OnDrawCell = sgProdutosDrawCell
    ExplicitHeight = 414
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 4
      Width = 39
      Height = 16
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 101
      Top = 4
      Width = 38
      Height = 16
      Caption = 'Quant.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 186
      Top = 4
      Width = 52
      Height = 16
      Caption = 'Val. Unit.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblProduto: TLabel
      Left = 16
      Top = 50
      Width = 12
      Height = 16
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 16
      Top = 21
      Width = 80
      Height = 24
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
    end
    object edtQuantidade: TEdit
      Left = 101
      Top = 21
      Width = 80
      Height = 24
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtQuantidadeKeyPress
    end
    object edtValorUnitario: TEdit
      Left = 186
      Top = 21
      Width = 80
      Height = 24
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtQuantidadeKeyPress
    end
    object Button1: TButton
      Left = 272
      Top = 20
      Width = 161
      Height = 24
      Caption = 'Inserir'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
