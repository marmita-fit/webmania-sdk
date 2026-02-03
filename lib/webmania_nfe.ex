defmodule WebmaniaNfe do
  @moduledoc """
  Entrada principal para o SDK da Webmania NFe.

  Fornece funções utilitárias para criação e consulta de NF-e.
  """

  alias WebmaniaNfe.Client
  alias WebmaniaNfe.Invoice

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct client: %Client{},
            invoice: %Invoice{}

  def new(base_url, consumer_key, consumer_secret, access_token, access_token_secret) do
    new(Client.new(
      base_url,
      consumer_key,
      consumer_secret,
      access_token,
      access_token_secret
    ))
  end

  def new(%Client.Config{} = client_config) do
    new(Client.new(client_config))
  end

  def new(%Client{} = client) do
    %__MODULE__{
      client: client,
      invoice: Invoice.new(client)
    }
  end

  def invoice(%__MODULE__{} = webmania_nfe, %Invoice.Create.Request{} = request) do
    invoice = webmania_nfe.invoice |> Invoice.create(request)
    %__MODULE__{
      webmania_nfe |
      client: invoice.client,
      invoice: invoice
    }
  end

  def get_invoice(%__MODULE__{} = webmania_nfe, %Invoice.Get.Request{} = request) do
    invoice = webmania_nfe.invoice
              |> Invoice.Get.add(request)
              |> Invoice.Get.add(webmania_nfe.client)
              |> Invoice.Get.request()
    %__MODULE__{
      webmania_nfe |
      client: invoice.client,
      invoice: invoice
    }
  end
end
