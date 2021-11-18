unit untVendas;

interface
  uses
    untConexao;
  type
  TAcao = (TInserindo, TAlterando);


  TCliente = class(TConexaoFireDAC)
    private
    public
  end;

  TProduto = class(TConexaoFireDAC)
    private
      FCodigo: Integer;
      FPreco_Venda: Currency;
      FDescricao: String;
      procedure ValidarDados;
      procedure LimparEstutura;
    public
      Acao : TAcao;
      procedure Insert; override;
      procedure Select; override;
      procedure Delete; override;
      procedure Update; override;


      property Codigo : Integer read FCodigo write FCodigo;
      property Descricao : String read FDescricao write FDescricao;
      property Preco_Venda : Currency read FPreco_Venda write FPreco_Venda;

  end;

  TProdutoVenda = class(TProduto)
  private
    FValor_Total: currency;
    FQuantidade: Double;
  public
    procedure Insert;override;
    procedure Update;override;
    procedure Delete;overload;override;

    property Valor_Total : currency read FValor_Total write FValor_Total;
    property Quantidade  : Double  read FQuantidade write FQuantidade;

    procedure LimparEstutura;
  end;

  TVendas = class(TCliente)
    private
    public
  end;

implementation
  uses
    System.SysUtils;

{ TProduto }

procedure TProduto.Delete;
begin
  SQL := 'DELETE FROM PRODUTOS WHERE CODIGO = ' + FCodigo.ToString;
  inherited;
end;

procedure TProduto.Insert;
begin
  ValidarDados;
  SQL := 'INSERT INTO PRODUTOS(DESCRICAO, PRECO_VENDA) VALUES ('+ QuotedStr(FDescricao) +', ' + CurrToStr(FPreco_Venda) +')';
  inherited;
end;

procedure TProdutoVenda.Delete;
begin
  SQL := 'DELETE FROM PRODUTOS WHERE CODIGO = ' + FCodigo.ToString;
  inherited;
end;

procedure TProdutoVenda.Insert;
begin
  try
    try
      FormatSettings.DecimalSeparator := '.';

      if FCodigo <= 0 then
        raise Exception.Create('Produto não foi informado.');

      Valor_Total := FQuantidade * FPreco_Venda;
      SQL := 'INSERT INTO PRODUTOS(DESCRICAO, PRECO_VENDA) VALUES ('+ QuotedStr(FDescricao) +', ' + CurrToStr(FPreco_Venda) +')';
      inherited insert;
    except
      raise;
    end;
  finally
   FormatSettings.DecimalSeparator := ',';
  end;
end;

procedure TProduto.LimparEstutura;
begin
  inherited;
  Codigo      := 0;
  Descricao   := '';
  Preco_Venda := 0;
end;

procedure TProduto.Select;
begin
  try
    case TipoPesquisa of
      TCodigo   : SQL := 'SELECT CODIGO, DESCRICAO, PRECO_VENDA FROM PRODUTOS WHERE CODIGO = ' + FCodigo.ToString;
      TDescricao: SQL := 'SELECT CODIGO, DESCRICAO, PRECO_VENDA FROM PRODUTOS WHERE DESCRICAO = ' + FDescricao;
    end;

    inherited;
    Codigo      := qry.FindField('CODIGO').AsInteger;
    Descricao   := qry.FindField('DESCRICAO').AsString;
    Preco_Venda := qry.FindField('PRECO_VENDA').AsCurrency;

  except
    on e: Exception do
    begin
      LimparEstutura;
      raise;
    end;
  end;
end;

procedure TProduto.Update;
begin
  inherited;

end;

procedure TProduto.ValidarDados;
begin
  if Trim(FDescricao).isEmpty then
    raise Exception.Create('Descrição não pode ser vazia.');

  if FPRECO_VENDA <= 0 then
    raise Exception.Create('Preço de venda não pode ser zero.');
end;

procedure TProdutoVenda.LimparEstutura;
begin
  inherited;
  Valor_Total := 0;
  Quantidade  := 0;
end;

procedure TProdutoVenda.Update;
begin
  try
    if FPRECO_VENDA <= 0 then
      raise Exception.Create('Preço de venda não pode ser zero.');

    Valor_Total := FQuantidade * FPreco_Venda;
    SQL := 'UPDATE PRODUTOS SET QUANTIDADE = ' +  CurrToStr(FPreco_Venda) + ' , PRECO_VENDA = ' + CurrToStr(Quantidade);

    inherited;
  except
    raise;
  end;

end;

end.
