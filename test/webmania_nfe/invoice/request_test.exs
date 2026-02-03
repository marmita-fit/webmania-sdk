defmodule WebmaniaNfe.Invoice.RequestTest do
  use ExUnit.Case
  doctest WebmaniaNfe.Invoice.Create.Request

  alias WebmaniaNfe.Invoice.Create.Request, as: Request

  describe "invoice" do
    @valid_invoice %{
      ID: 1137,
      url_notificacao: "http://meudominio.com/retorno.php",
      operacao: 1,
      natureza_operacao: "Venda de produção do estabelecimento",
      modelo: 1,
      finalidade: 1,
      ambiente: 2,
      cliente: %{
        cpf: "000.000.000-00",
        nome_completo: "Nome do Cliente",
        endereco: "Av. Brg. Faria Lima",
        complemento: "Escritório",
        numero: 1000,
        bairro: "Itaim Bibi",
        cidade: "São Paulo",
        uf: "SP",
        cep: "00000-000",
        telefone: "(00) 0000-0000",
        email: "nome@email.com"
      },
      produtos: [
        %{
          nome: "Nome do produto",
          codigo: "nome-do-produto",
          ncm: "6109.10.00",
          cest: "28.038.00",
          quantidade: 3,
          unidade: "UN",
          peso: "0.800",
          origem: 0,
          subtotal: "44.90",
          total: "134.70",
          classe_imposto: "REF1000"
        },
        %{
          nome: "Nome do produto",
          codigo: "nome-do-produto",
          ncm: "6109.10.00",
          cest: "28.038.00",
          quantidade: 1,
          unidade: "UN",
          peso: "0.800",
          origem: 0,
          subtotal: "29.90",
          total: "29.90",
          classe_imposto: "REF1000"
        }
      ],
      pedido: %{
        pagamento: 0,
        presenca: 2,
        modalidade_frete: 0,
        frete: "12.56",
        desconto: "10.00",
        total: "174.60"
      }
    }

    test "new/1 with valid data return a invoice" do
      assert {:ok, %Request{} = invoice } = Request.new(@valid_invoice)

      assert invoice."ID" == 1137
      assert invoice.url_notificacao == "http://meudominio.com/retorno.php"
      assert invoice.operacao == 1
      assert invoice.natureza_operacao == "Venda de produção do estabelecimento"
      assert invoice.modelo == 1
      assert invoice.finalidade == 1
      assert invoice.ambiente == 2
      assert invoice.cliente.cpf == "000.000.000-00"
      assert invoice.cliente.nome_completo == "Nome do Cliente"
      assert invoice.cliente.endereco == "Av. Brg. Faria Lima"
      assert invoice.cliente.complemento == "Escritório"
      assert invoice.cliente.numero == 1000
      assert invoice.cliente.bairro == "Itaim Bibi"
      assert invoice.cliente.cidade == "São Paulo"
      assert invoice.cliente.uf == "SP"
      assert invoice.cliente.cep == "00000-000"
      assert invoice.cliente.telefone == "(00) 0000-0000"
      assert invoice.cliente.email == "nome@email.com"

      Enum.with_index(invoice.produtos, fn product, index ->
        assert product.nome == "Nome do produto"
        assert product.codigo == "nome-do-produto"
        assert product.ncm == "6109.10.00"
        assert product.cest == "28.038.00"
        assert product.unidade == "UN"
        assert product.peso == "0.800"
        assert product.origem == 0
        assert product.classe_imposto == "REF1000"
        case index do
          0 ->
            assert product.quantidade == 3
            assert product.subtotal == "44.90"
            assert product.total == "134.70"
          1 ->
            assert product.quantidade == 1
            assert product.subtotal == "29.90"
            assert product.total == "29.90"
        end
      end)

      assert invoice.pedido.pagamento == 0
      assert invoice.pedido.presenca == 2
      assert invoice.pedido.modalidade_frete == 0
      assert invoice.pedido.frete == "12.56"
      assert invoice.pedido.desconto == "10.00"
      assert invoice.pedido.total == "174.60"

      assert {:ok, ^invoice} = Request.new(invoice)
    end

    test "new!/1 with valid data return a invoice" do
      invoice  = Request.new!(@valid_invoice)
      assert %Request{} = invoice

      assert invoice."ID" == 1137
      assert invoice.url_notificacao == "http://meudominio.com/retorno.php"
      assert invoice.operacao == 1
      assert invoice.natureza_operacao == "Venda de produção do estabelecimento"
      assert invoice.modelo == 1
      assert invoice.finalidade == 1
      assert invoice.ambiente == 2
      assert invoice.cliente.cpf == "000.000.000-00"
      assert invoice.cliente.nome_completo == "Nome do Cliente"
      assert invoice.cliente.endereco == "Av. Brg. Faria Lima"
      assert invoice.cliente.complemento == "Escritório"
      assert invoice.cliente.numero == 1000
      assert invoice.cliente.bairro == "Itaim Bibi"
      assert invoice.cliente.cidade == "São Paulo"
      assert invoice.cliente.uf == "SP"
      assert invoice.cliente.cep == "00000-000"
      assert invoice.cliente.telefone == "(00) 0000-0000"
      assert invoice.cliente.email == "nome@email.com"

      Enum.with_index(invoice.produtos, fn product, index ->
        assert product.nome == "Nome do produto"
        assert product.codigo == "nome-do-produto"
        assert product.ncm == "6109.10.00"
        assert product.cest == "28.038.00"
        assert product.unidade == "UN"
        assert product.peso == "0.800"
        assert product.origem == 0
        assert product.classe_imposto == "REF1000"
        case index do
          0 ->
            assert product.quantidade == 3
            assert product.subtotal == "44.90"
            assert product.total == "134.70"
          1 ->
            assert product.quantidade == 1
            assert product.subtotal == "29.90"
            assert product.total == "29.90"
        end
      end)

      assert invoice.pedido.pagamento == 0
      assert invoice.pedido.presenca == 2
      assert invoice.pedido.modalidade_frete == 0
      assert invoice.pedido.frete == "12.56"
      assert invoice.pedido.desconto == "10.00"
      assert invoice.pedido.total == "174.60"

      assert ^invoice = Request.new!(invoice)
    end
  end

end
