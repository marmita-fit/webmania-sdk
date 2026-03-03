defmodule WebmaniaNfe.Invoice.Cancel do
  @moduledoc """
  `WebmaniaNfe.Invoice.Cancel` handles cancellation of NF-e invoices.

  ## Examples
  ```elixir
      iex> client = WebmaniaNfe.Client.new("https://webmaniabr.com/api/", "CONSUMER_KEY", "CONSUMER_SECRET", "ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")
      iex> cancel = %WebmaniaNfe.Invoice.Cancel{}
      ...>   |> WebmaniaNfe.Invoice.Cancel.add(%WebmaniaNfe.Invoice.Cancel.Request{chave: "00000000000000000000000000000000000000000000", motivo: "Cancelamento por erro de digitação"})
      ...>   |> WebmaniaNfe.Invoice.Cancel.add(client)
      ...>   |> WebmaniaNfe.Invoice.Cancel.request()
  ```
  """

  alias WebmaniaNfe.Invoice.Cancel.{Request, Response}

  @derive [
    {Nestru.Encoder, hint: %{request: Request, response: Response}},
    {Nestru.Decoder, hint: %{request: Request, response: Response}}
  ]
  @path "/1/nfe/cancelar/"
  @method "PUT"

  defstruct url: @path,
            method: @method,
            client: %WebmaniaNfe.Client{},
            request: %WebmaniaNfe.Invoice.Cancel.Request{},
            response: %WebmaniaNfe.Invoice.Cancel.Response{}

  def new() do
    %__MODULE__{
      url: @path,
      method: @method,
      client: %WebmaniaNfe.Client{},
      request: %WebmaniaNfe.Invoice.Cancel.Request{},
      response: %WebmaniaNfe.Invoice.Cancel.Response{}
    }
  end

  def new(%__MODULE__{} = cancel) do
    %__MODULE__{
      cancel
      | url: @path,
        method: @method,
        request: %WebmaniaNfe.Invoice.Cancel.Request{},
        response: %WebmaniaNfe.Invoice.Cancel.Response{}
    }
  end

  def new(request) when is_map(request) do
    new() |> add(Nestru.decode!(request, WebmaniaNfe.Invoice.Cancel.Request))
  end

  def add(%__MODULE__{} = cancel, %WebmaniaNfe.Invoice.Cancel.Request{} = request) do
    %__MODULE__{
      cancel
      | request: request
    }
  end

  def add(%__MODULE__{} = cancel, %WebmaniaNfe.Invoice.Cancel.Response{} = response) do
    %__MODULE__{
      cancel
      | response: response
    }
  end

  def add(%__MODULE__{} = cancel, %WebmaniaNfe.Client{} = client) do
    %__MODULE__{
      cancel
      | client: client
    }
  end

  def request(%__MODULE__{} = cancel) do
    client = cancel.client |> WebmaniaNfe.Client.request(cancel)

    %__MODULE__{
      cancel
      | client: client,
        response: process_response(client)
    }
  end

  defp process_response(%WebmaniaNfe.Client{response: {:ok, %HTTPoison.Response{status_code: 200, body: body}}} = _client) do
    body |> Poison.decode!(%{as: %WebmaniaNfe.Invoice.Cancel.Response{}})
  end

  defp process_response(%WebmaniaNfe.Client{response: {:error, response}} = _client),
    do: process_response(response)

  defp process_response(response) do
    response
  end
end
