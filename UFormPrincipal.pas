unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, untVendas;

type
  TForm1 = class(TForm)
    sgProdutos: TStringGrid;
    Panel1: TPanel;
    edtCodigo: TEdit;
    edtQuantidade: TEdit;
    edtValorUnitario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblProduto: TLabel;
    lblErro: TLabel;
    Button1: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInserirClick(Sender: TObject);
    procedure sgProdutosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Venda   : TVendas;
    Produto : TProdutoVenda;
    procedure LimparEdits;
    function ConsultarProduto : boolean;
    procedure ShowErro(erro : String);
  public
    { Public declarations }
  end;
const
  C_CODIGO         = 0;
  C_DESCRICAO      = 1;
  C_QUANTIDADE     = 2;
  C_VALOR_UNITARIO = 3;
  C_VALOR_TOTAL    = 4;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnInserirClick(Sender: TObject);
var
  ARow : Integer;
begin
  try
//    Produto.codigo      := StrToIntDef(edtCodigo.Text,0);
//    Produto.Preco_Venda := StrToFloatDef(edtValorUnitario.Text,0);
//    Produto.Quantidade  := StrToFloatDef(edtQuantidade.Text,0);
//
//    case Produto.Acao of
//      TInserindo : Produto.Insert;
//      TAlterando : Produto.Update;
//    end;

    if Produto.Acao <> TAlterando then
    begin
      sgProdutos.RowCount := sgProdutos.RowCount + 1;
      ARow := sgProdutos.RowCount - 1;
    end else
    ARow := sgProdutos.Row;

    lblErro.Caption := '...';
    sgProdutos.FixedRows := 1;

    sgProdutos.Cells[C_CODIGO, ARow]         := edtCodigo.Text;
    sgProdutos.Cells[C_DESCRICAO, ARow]      := lblProduto.Caption;
    sgProdutos.Cells[C_QUANTIDADE, ARow]     := FormatFloat('0.00',  StrToFloatDef(edtValorUnitario.Text,1));
    sgProdutos.Cells[C_VALOR_UNITARIO, ARow] := FormatFloat(',0.00', StrToFloatDef(edtValorUnitario.Text,0));
    sgProdutos.Cells[C_VALOR_TOTAL, ARow]    := FormatFloat(',0.00', StrToFloatDef(edtQuantidade.Text,0));
    LimparEdits;

  except
    on e: exception do
      ShowErro(e.message);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Venda :=
end;

function TForm1.ConsultarProduto : boolean;
begin
  try
    result := False;
    Produto.Codigo := StrToIntDef(edtCodigo.Text,0);
    Produto.Select;
    lblProduto.Caption := produto.Descricao;
    edtValorUnitario.Text := FormatFloat(',0.00', produto.Preco_Venda);
    edtQuantidade.Text    := '1';
    result := True;
  except
    on e: exception do
      ShowErro(e.Message);
  end;
end;

procedure TForm1.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(key, ['0'..'9', ',', '.'])) then
    key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  inherited;
  Venda   := TVendas.Create;
  Produto := TProdutoVenda.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Venda);
  FreeAndNil(Produto);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  I: Integer;
begin

  if key = VK_ESCAPE then Close;
  if (key = VK_RETURN) then
  begin
    if (ActiveControl = edtValorUnitario) then
      btnInserirClick(Sender)
    else if (ActiveControl = edtCodigo) then
    begin
     if not ConsultarProduto then Exit;
    end
    else if (ActiveControl = sgProdutos) then
    begin
      Produto.Acao          := TAlterando;
      edtCodigo.Enabled     := False;
      edtCodigo.Text        := sgProdutos.Cells[C_CODIGO, sgProdutos.row];
      edtQuantidade.Text    := sgProdutos.Cells[C_DESCRICAO, sgProdutos.row];
      edtValorUnitario.Text := sgProdutos.Cells[C_VALOR_UNITARIO, sgProdutos.row];
      lblProduto.Caption    := sgProdutos.Cells[C_DESCRICAO, sgProdutos.row];
    end;
    SelectNext(ActiveControl,True,true);
  end else
  if (key = VK_DELETE)
  and (ActiveControl = sgProdutos) then
  begin
    produto.Codigo := sgProdutos.Cells[C_CODIGO, sgProdutos.row].ToInteger;
    Produto.Delete;

    for I := sgProdutos.row to sgProdutos.RowCount - 1 do
    begin
      sgProdutos.Cells[C_CODIGO, i]         := sgProdutos.Cells[C_CODIGO, i+1];
      sgProdutos.Cells[C_DESCRICAO, i]      := sgProdutos.Cells[C_DESCRICAO, i+1];
      sgProdutos.Cells[C_QUANTIDADE, i]     := sgProdutos.Cells[C_QUANTIDADE, i+1];
      sgProdutos.Cells[C_VALOR_UNITARIO, i] := sgProdutos.Cells[C_VALOR_UNITARIO, i+1];
      sgProdutos.Cells[C_VALOR_TOTAL, i]    := sgProdutos.Cells[C_VALOR_TOTAL, i+1];
    end;

    sgProdutos.RowCount := sgProdutos.RowCount - 1;
  end else
  if (KEY = VK_UP) OR (KEY = VK_DOWN) then
    sgProdutos.SetFocus;

end;

procedure TForm1.LimparEdits;
begin
  Produto.Acao   := TInserindo;
  edtValorUnitario.Clear;
  edtQuantidade.Text := '1';
  edtCodigo.Clear;
  lblProduto.Caption := '...';
  Produto.LimparEstutura;
  edtCodigo.Enabled := True;
  edtCodigo.SetFocus;
end;

procedure TForm1.sgProdutosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with sgProdutos do
  begin
    if ARow = 0 then
    begin
      Cells[C_CODIGO, ARow] := 'Código';
      Cells[C_DESCRICAO,  ARow]        := 'Descrição';
      Cells[C_QUANTIDADE, ARow]        := 'Quant.';
      Cells[C_VALOR_UNITARIO, ARow]    := 'Val. Unit.';
      Cells[C_VALOR_TOTAL, ARow]       := 'Val. Total';
    end else
    case ACol of
      C_DESCRICAO  : ColWidths[ACol] := 200;
      C_QUANTIDADE : ColWidths[ACol] := 100;
    else ColWidths[ACol] := 64;
    end;
  end;
end;

procedure TForm1.ShowErro(erro : String);
begin
  lblErro.Caption := Erro;
  LimparEdits;
//  sleep(3000);
//  lblErro.Caption := '...';
end;

end.

