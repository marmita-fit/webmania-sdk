defmodule WebmaniaNfe.Invoice.Create do
  @moduledoc """
  `WebmaniaNfe.Invoice.Create` handles initialization for the invoice request payload.

  ## Examples
      iex> WebmaniaNfe.Invoice.Create.new!(%{ ID: "123", url_notificacao: "https://webmaniabr.com",  operacao: "1", natureza_operacao: "Venda de produção do estabelecimento",  modelo: "1", finalidade: "1",  ambiente: "1", cliente: %{    cpf: "000.000.000-00", nome_completo: "Nome do Cliente",    endereco: "Av. Brg. Faria Lima", complemento: "Escritório",    numero: 1000, bairro: "Itaim Bibi",    cidade: "São Paulo", uf: "SP",    cep: "00000-000", telefone: "(00) 0000-0000",    email: "nome@email.com" }, produtos: [%{    nome: "Nome do produto", codigo: "nome-do-produto",    ncm: "6109.10.00", cest: "28.038.00",    quantidade: 1, unidade: "UN",    peso: "0.800", origem: 0,    subtotal: "29.90", total: "29.90",    classe_imposto: "REF1000" }],  pedido: %{ pagamento: 0,    presenca: 2, modalidade_frete: 0,    frete: "12.56", desconto: "10.00",    total: "174.60" }})
  """

  alias WebmaniaNfe.Invoice.Create.{Request, Response}

  @derive [
    {Nestru.Encoder, hint: %{request: Request, response: Response}},
    {Nestru.Decoder, hint: %{request: Request, response: Response}}
  ]
  @path "/1/nfe/emissao/"
  @method "POST"

  defstruct url: @path,
            method: @method,
            client: %WebmaniaNfe.Client{},
            request: %WebmaniaNfe.Invoice.Create.Request{},
            response: %WebmaniaNfe.Invoice.Create.Response{}

  def new() do
    %__MODULE__{
      url: @path,
      method: @method,
      client: %WebmaniaNfe.Client{},
      request: %WebmaniaNfe.Invoice.Create.Request{},
      response: %WebmaniaNfe.Invoice.Create.Response{}
    }
  end

  def new(
        %__MODULE__{} = create,
        %WebmaniaNfe.Invoice.Create.Request{} = request,
        %WebmaniaNfe.Invoice.Create.Response{} = response
      ) do
    %__MODULE__{
      create
      | request: request,
        response: response
    }
  end

  def new(%__MODULE__{} = create) do
    %__MODULE__{
      create
      | url: @path,
        method: "POST",
        request: %WebmaniaNfe.Invoice.Create.Request{},
        response: %WebmaniaNfe.Invoice.Create.Response{}
    }
  end

  def new(request) when is_map(request) do
    new() |> add(Nestru.decode!(request, WebmaniaNfe.Invoice.Create.Request))
  end

  def add(%__MODULE__{} = create, %WebmaniaNfe.Invoice.Create.Request{} = request) do
    %__MODULE__{
      create
      | request: request
    }
  end

  def add(%__MODULE__{} = create, %WebmaniaNfe.Invoice.Create.Response{} = response) do
    %__MODULE__{
      create
      | response: response
    }
  end

  def add(%__MODULE__{} = create, %WebmaniaNfe.Client{} = client) do
    %__MODULE__{
      create
      | client: client
    }
  end

  def request(%__MODULE__{} = create) do
    client = create.client |> WebmaniaNfe.Client.request(create)

    %__MODULE__{
      create
      | client: client,
        response: process_response(client)
    }
  end

  def response(%__MODULE__{} = create, response) do
    %__MODULE__{
      create
      | response: response
    }
  end

  defp process_response(%WebmaniaNfe.Client{response: {:ok, %HTTPoison.Response{status_code: 200, body: body}}} = _client) do
    body |> Poison.decode!(%{as: %WebmaniaNfe.Invoice.Create.Response{}})
  end

  defp process_response(%WebmaniaNfe.Client{response: {:error, response}} = _client),
    do: process_response(response)

  defp process_response(response) do
    response
  end
end
