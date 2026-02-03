# Webmania NF-e

This is an unofficial wrapper to Webmania's server which can be used to generate brazilian invoices.

## Installation

This package is [available in Hex](https://hex.pm/packages/webmania_nfe), and package can be installed
by adding `webmania_nfe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:webmania_nfe, "~> 0.1.0"}
  ]
end
```

## usage
```elixir
config = %WebmaniaNfe.Client.Config{
  base_url: "https://webmaniabr.com/api/",
  consumer_key: "CONSUMER_KEY",
  consumer_secret: "CONSUMER_SECRET",
  access_token: "ACCESS_TOKEN",
  access_token_secret: "ACCESS_TOKEN_SECRET"
}

webmania_nfe = config |> WebmaniaNfe.Client.new()
webmania_request = %WebmaniaNfe.Invoice.Create.Request{
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
  produtos: [
    %WebmaniaNfe.Invoice.Create.Request.Product{
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
  pedido: %WebmaniaNfe.Invoice.Create.Request.Order{
    pagamento: 0,
    presenca: 2,
    modalidade_frete: 0,
    frete: "12.56",
    desconto: "10.00",
    total: "174.60"
  }
}

WebmaniaNfe.Nfe.invoice(webmania_config, webmania_request)
```

**How to run locally?**

- `docker compose run --rm app bash`
  - `mix deps.get` to install the dependencies
  - `iex -S mix` to open the elixir REPL

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/webmania_nfe>.
