defmodule Integration.EmissionTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    %{bypass: bypass}
  end

  test "emit invoice for pessoa física (CPF)", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/1/nfe/emissao/", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn)
      # ensure cpf exists in JSON payload
      assert body =~ "cpf"

      Plug.Conn.resp(conn, 200, Poison.encode!(%{"uuid" => "uuid-cpf-123", "status" => "aprovado"}))
    end)

    client = WebmaniaNfe.Client.new("http://localhost:#{bypass.port}/", "ck", "cs", "at", "ats")

    payload = %{
      "ID" => 123,
      "operacao" => 1,
      "natureza_operacao" => "Venda",
      "modelo" => 1,
      "finalidade" => 1,
      "ambiente" => 1,
      "cliente" => %{
        "cpf" => "000.000.000-00",
        "nome_completo" => "Fulano"
      },
      "produtos" => [
        %{"nome" => "Produto", "codigo" => "p1", "quantidade" => 1, "unidade" => "UN", "subtotal" => "10.00", "total" => "10.00", "classe_imposto" => "REF1000"}
      ],
      "pedido" => %{"pagamento" => 0, "presenca" => 2, "modalidade_frete" => 0, "frete" => "0.00", "desconto" => "0.00", "total" => "10.00"}
    }

    create = WebmaniaNfe.Invoice.Create.new(payload)
    create = WebmaniaNfe.Invoice.Create.add(create, client)
    create = WebmaniaNfe.Invoice.Create.request(create)

    assert %WebmaniaNfe.Invoice.Create.Response{} = create.response
    assert create.response.uuid == "uuid-cpf-123"
    assert create.response.status == "aprovado"
  end

  test "emit invoice for pessoa jurídica (CNPJ)", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/1/nfe/emissao/", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn)
      # ensure cnpj exists in JSON payload
      assert body =~ "cnpj"

      Plug.Conn.resp(conn, 200, Poison.encode!(%{"uuid" => "uuid-cnpj-456", "status" => "aprovado"}))
    end)

    client = WebmaniaNfe.Client.new("http://localhost:#{bypass.port}/", "ck", "cs", "at", "ats")

    payload = %{
      "ID" => 124,
      "operacao" => 1,
      "natureza_operacao" => "Venda para empresa",
      "modelo" => 1,
      "finalidade" => 1,
      "ambiente" => 1,
      "cliente" => %{
        "cnpj" => "00.000.000/0000-00",
        "razao_social" => "Empresa Teste LTDA"
      },
      "produtos" => [
        %{"nome" => "Produto PJ", "codigo" => "p1", "quantidade" => 2, "unidade" => "UN", "subtotal" => "20.00", "total" => "40.00", "classe_imposto" => "REF1000"}
      ],
      "pedido" => %{"pagamento" => 1, "presenca" => 0, "modalidade_frete" => 0, "frete" => "0.00", "desconto" => "0.00", "total" => "40.00"}
    }

    create = WebmaniaNfe.Invoice.Create.new(payload)
    create = WebmaniaNfe.Invoice.Create.add(create, client)
    create = WebmaniaNfe.Invoice.Create.request(create)

    assert %WebmaniaNfe.Invoice.Create.Response{} = create.response
    assert create.response.uuid == "uuid-cnpj-456"
    assert create.response.status == "aprovado"
  end
end
