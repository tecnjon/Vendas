unit untConexao;

interface
  uses
    FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef
    , FireDAC.Comp.UI, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf
    ;
  type
  TTipoPesquisa = (TCodigo, TDescricao);

  TConexaoFireDAC = class abstract
  private
    Conexao : TFDConnection;
    link    : TFDPhysMySQLDriverLink;
    curor   : TFDGUIxWaitCursor;
    FSQL: String;
    procedure conectaBase;
  public
    Qry     : TFDQuery;
    TipoPesquisa : TTipoPesquisa;
    constructor Create;
    destructor Destroy; override;
    procedure Insert; virtual;
    procedure Update; virtual;
    procedure Delete; virtual;
    procedure Select; virtual;
    procedure LimparDados; virtual;
    property SQL : String read FSQL write FSQL;

  end;

implementation
  uses
    System.SysUtils, FireDAC.Stan.Def, FireDAC.DApt, FireDAC.Stan.Async;

{ TConexaoFireDAC }

procedure TConexaoFireDAC.ConectaBase;
begin
  if Conexao.Connected then Exit;

  Conexao.LoginPrompt := False;
  Conexao.DriverName := 'MySQL';
  Conexao.Params.UserName := 'root';
  Conexao.Params.Password := 'ALEGRO';
  Conexao.Params.Database :='teste';
end;

constructor TConexaoFireDAC.Create;
begin
  inherited;
  conexao := TFDConnection.Create(Nil);
  Link    := TFDPhysMySQLDriverLink.Create(Nil);
  curor   := TFDGUIxWaitCursor.Create(Nil);;

  Link.DriverID := 'F:\testes\Vendas\executavel\libmysql.dll';

  qry     := TFDQuery.Create(Nil);
  qry.Connection := conexao;
end;

procedure TConexaoFireDAC.Delete;
begin
  try
    try
      ConectaBase;
      qry.SQL.Text := FSQL;
      qry.execSQL;
    except
      on e: Exception do
        raise;
    end;
  finally
    LimparDados;
  end;
end;

destructor TConexaoFireDAC.Destroy;
begin
  FreeAndNil(Conexao);
  FreeAndNil(qry);
  FreeAndNil(Link);
  inherited;
end;

procedure TConexaoFireDAC.Insert;
begin
  try
    try

      ConectaBase;
      qry.SQL.Text := FSQL;
      qry.execSQL;

    except
      on e: exception do
        raise;
    end;
  finally
    FormatSettings.DecimalSeparator := ',';
    LimparDados;
  end;
end;

procedure TConexaoFireDAC.LimparDados;
begin
  qry.Close;
  qry.SQL.Clear;
  qry.Params.Clear;
end;

procedure TConexaoFireDAC.Select;
begin
  try
    ConectaBase;
    qry.SQL.Text := FSQL;
    qry.Open();

    if qry.isEmpty then
      raise Exception.Create('Nenhum registro encontrado.');

  except
    on e: exception do
      raise;
  end;
end;

procedure TConexaoFireDAC.Update;
begin
  try
    try
      ConectaBase;
    except
      on e: exception do
        raise;
    end;
  finally
    LimparDados;
  end;
end;

end.
