defmodule InvoiceCreateRequestTest do
  use ExUnit.Case

  test "decodes cliente pessoa juridica (CNPJ) into struct" do
    payload = %{
      "ID" => "124",
      "operacao" => "1",
      "natureza_operacao" => "Venda para empresa",
      "modelo" => "1",
      "finalidade" => "1",
      "ambiente" => "1",
      "cliente" => %{
        "cnpj" => "00.000.000/0000-00",
        "razao_social" => "Empresa Exemplo LTDA",
        "ie" => "123456789",
        "endereco" => "Av. Paulista",
        "numero" => 100,
        "bairro" => "Bela Vista",
        "cidade" => "São Paulo",
        "uf" => "SP",
        "cep" => "01310-100",
        "telefone" => "(11) 0000-0000",
        "email" => "contato@empresa.com"
      },
      "produtos" => [
        %{"nome" => "Produto PJ", "codigo" => "produto-pj", "ncm" => "6109.10.00", "quantidade" => 2, "unidade" => "UN", "subtotal" => "59.80", "total" => "119.60", "classe_imposto" => "REF1000"}
      ],
      "pedido" => %{"pagamento" => 1, "presenca" => 0, "modalidade_frete" => 0, "frete" => "0.00", "desconto" => "0.00", "total" => "119.60"}
    }

    request = WebmaniaNfe.Invoice.Create.Request.new!(payload)

    assert %WebmaniaNfe.Invoice.Create.Request{} = request
    assert %WebmaniaNfe.Invoice.Create.Request.Customer{} = request.cliente
    assert request.cliente.cnpj == "00.000.000/0000-00"
    assert request.cliente.razao_social == "Empresa Exemplo LTDA"
    assert request.cliente.ie == "123456789"
    assert request.produtos |> length() == 1
    assert request.pedido.total == "119.60"
  end
end
