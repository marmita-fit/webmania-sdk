defmodule WebmaniaNfe.Invoice.Create.Request do
  @moduledoc """
  `WebmaniaNfe.Invoice.Create.Request` handles initialization for the invoice request payload.

  ## Examples

  Exemplo Pessoa Física:

      iex> WebmaniaNfe.Invoice.Create.Request.new!(%{ ID: "123", url_notificacao: "https://webmaniabr.com", operacao: "1", natureza_operacao: "Venda de produção do estabelecimento", modelo: "1", finalidade: "1", ambiente: "1", cliente: %{ cpf: "000.000.000-00", nome_completo: "Nome do Cliente", endereco: "Av. Brg. Faria Lima", complemento: "Escritório", numero: 1000, bairro: "Itaim Bibi", cidade: "São Paulo", uf: "SP", cep: "00000-000", telefone: "(00) 0000-0000", email: "nome@email.com" }, produtos: [%{ nome: "Nome do produto", codigo: "nome-do-produto", ncm: "6109.10.00", cest: "28.038.00", quantidade: 1, unidade: "UN", peso: "0.800", origem: 0, subtotal: "29.90", total: "29.90", classe_imposto: "REF1000" }], pedido: %{ pagamento: 0, presenca: 2, modalidade_frete: 0, frete: "12.56", desconto: "10.00", total: "174.60" }})
      %WebmaniaNfe.Invoice.Create.Request{
        ID: "123",
        url_notificacao: "https://webmaniabr.com",
        operacao: "1",
        natureza_operacao: "Venda de produção do estabelecimento",
        modelo: "1",
        finalidade: "1",
        ambiente: "1",
        cliente: %WebmaniaNfe.Invoice.Create.Request.Customer{
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
        produtos: [%WebmaniaNfe.Invoice.Create.Request.Product{ nome: "Nome do produto", codigo: "nome-do-produto", ncm: "6109.10.00", cest: "28.038.00", quantidade: 1, unidade: "UN", peso: "0.800", origem: 0, subtotal: "29.90", total: "29.90", classe_imposto: "REF1000" }],
        pedido: %WebmaniaNfe.Invoice.Create.Request.Order{ pagamento: 0, presenca: 2, modalidade_frete: 0, frete: "12.56", desconto: "10.00", total: "174.60" }
      }

  Exemplo Pessoa Jurídica (PJ):

      iex> WebmaniaNfe.Invoice.Create.Request.new!(%{ ID: "124", url_notificacao: "https://webmaniabr.com", operacao: "1", natureza_operacao: "Venda para empresa", modelo: "1", finalidade: "1", ambiente: "1", cliente: %{ cnpj: "00.000.000/0000-00", razao_social: "Empresa Exemplo LTDA", ie: "123456789", endereco: "Av. Paulista", numero: 100, bairro: "Bela Vista", cidade: "São Paulo", uf: "SP", cep: "01310-100", telefone: "(11) 0000-0000", email: "contato@empresa.com" }, produtos: [%{ nome: "Produto PJ", codigo: "produto-pj", ncm: "6109.10.00", quantidade: 2, unidade: "UN", subtotal: "59.80", total: "119.60", classe_imposto: "REF1000" }], pedido: %{ pagamento: 1, presenca: 0, modalidade_frete: 0, frete: "0.00", desconto: "0.00", total: "119.60" }})
      %WebmaniaNfe.Invoice.Create.Request{
        ID: "124",
        url_notificacao: "https://webmaniabr.com",
        operacao: "1",
        natureza_operacao: "Venda para empresa",
        modelo: "1",
        finalidade: "1",
        ambiente: "1",
        cliente: %WebmaniaNfe.Invoice.Create.Request.Customer{
          cnpj: "00.000.000/0000-00",
          razao_social: "Empresa Exemplo LTDA",
          ie: "123456789",
          endereco: "Av. Paulista",
          numero: 100,
          bairro: "Bela Vista",
          cidade: "São Paulo",
          uf: "SP",
          cep: "01310-100",
          telefone: "(11) 0000-0000",
          email: "contato@empresa.com"
        },
        produtos: [%WebmaniaNfe.Invoice.Create.Request.Product{ nome: "Produto PJ", codigo: "produto-pj", ncm: "6109.10.00", quantidade: 2, unidade: "UN", subtotal: "59.80", total: "119.60", classe_imposto: "REF1000" }],
        pedido: %WebmaniaNfe.Invoice.Create.Request.Order{ pagamento: 1, presenca: 0, modalidade_frete: 0, frete: "0.00", desconto: "0.00", total: "119.60" }
      }
  """
  alias WebmaniaNfe.Invoice.Create.Request.{Customer, Product, Order}

  @derive [
    {
      Nestru.Encoder,
      hint: %{cliente: Customer, produtos: [Product], pedido: Order}
    },
    {
      Nestru.Decoder,
      hint: %{cliente: Customer, produtos: [Product], pedido: Order}
    }
  ]
  defstruct [
    :ID,
    :url_notificacao,
    :operacao,
    :natureza_operacao,
    :modelo,
    :finalidade,
    :ambiente,
    :cliente,
    :produtos,
    :pedido
  ]

  def new(request) when is_map(request), do: Nestru.decode(request, __MODULE__)

  def new({:ok, %WebmaniaNfe.Invoice.Create.Request{}} = request), do: request

  def new!(request) when is_map(request), do: Nestru.decode!(request, __MODULE__)

  def new!(%WebmaniaNfe.Invoice.Create.Request{} = request),
    do: Nestru.decode!(request, __MODULE__)
end
