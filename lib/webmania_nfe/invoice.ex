defmodule WebmaniaNfe.Invoice do
  @moduledoc """
  API para operações de NF-e (criação e consulta), usada por `WebmaniaNfe`.

  ## Uso

  Before using the WebmaniaNfe SDk, you need to configure it with your credentials.
  The simplest way to do this is via `WebmaniaNfe.Client.Config.new/5`:
  ```
      iex> config = WebmaniaNfe.Client.Config.new("https://webmaniabr.com/api/", "CONSUMER_KEY", "CONSUMER_SECRET", "ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")
      %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      }
  ```
  Config is used to create the client:
  ```
      iex> config |> WebmaniaNfe.Client.new()
      %WebmaniaNfe.Client{
        config: %WebmaniaNfe.Client.Config{
          base_url: "https://webmaniabr.com/api/",
          consumer_key: "CONSUMER_KEY",
          consumer_secret: "CONSUMER_SECRET",
          access_token: "ACCESS_TOKEN",
          access_token_secret: "ACCESS_TOKEN_SECRET"
        },
        headers: [
          {"Content-Type", "application/json"},
          {"X-Consumer-Key", "CONSUMER_KEY"},
          {"X-Consumer-Secret", "CONSUMER_SECRET"},
          {"X-Access-Token", "ACCESS_TOKEN"},
          {"X-Access-Token-Secret", "ACCESS_TOKEN_SECRET"}
        ],
        request: nil,
        response: nil
      }
  ```
  You can create the client directly also:
  ```
      iex> WebmaniaNfe.Client.new("https://webmaniabr.com/api/", "CONSUMER_KEY", "CONSUMER_SECRET", "ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")
      %WebmaniaNfe.Client{
        config: %WebmaniaNfe.Client.Config{
          base_url: "https://webmaniabr.com/api/",
          consumer_key: "CONSUMER_KEY",
          consumer_secret: "CONSUMER_SECRET",
          access_token: "ACCESS_TOKEN",
          access_token_secret: "ACCESS_TOKEN_SECRET"
        },
        headers: [
          {"Content-Type", "application/json"},
          {"X-Consumer-Key", "CONSUMER_KEY"},
          {"X-Consumer-Secret", "CONSUMER_SECRET"},
          {"X-Access-Token", "ACCESS_TOKEN"},
          {"X-Access-Token-Secret", "ACCESS_TOKEN_SECRET"}
        ],
        request: nil,
        response: nil
      }

  ```
  """

  alias WebmaniaNfe.Invoice.{Create, Get}
  alias WebmaniaNfe.Client

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct client: %Client{},
            create: %Create{},
            get: %Get{}

  def new() do
    new(%Create{}, %Get{}, %Client{})
  end

  def new(%Create{} = create) do
    new(create, %Get{}, %Client{})
  end

  def new(%Get{} = get) do
    new(%Create{}, get, %Client{})
  end

  def new(%Client{} = client) do
    new(%Create{}, %Get{}, client)
  end

  def new(%Create{} = create, %Get{} = get, %Client{} = client) do
    %__MODULE__{
      create: create,
      get: get,
      client: client
    }
  end

  def add(%__MODULE__{} = invoice, %Create{} = create) do
    %__MODULE__{
      invoice |
      create: create,
    }
  end

  def add(%__MODULE__{} = invoice, %Get{} = get) do
    %__MODULE__{
      invoice |
      get: get
    }
  end

  def add(%__MODULE__{} = invoice, %Create{} = create, %Get{} = get, %Client{} = client) do
    %__MODULE__{
      invoice |
      create: create,
      get: get,
      client: client,
    }
  end

  def create(%__MODULE__{} = invoice, %Create.Request{} = request) do
    create = invoice.create
    |> Create.add(request)
    |> Create.add(invoice.client)
    |> Create.request()

    %__MODULE__{
      invoice |
      client: invoice.client,
      create: create
    }
  end

  def get(%__MODULE__{} = invoice, %Get.Request{} = request) do
    get = invoice.get
    |> Get.add(request)
    |> Get.add(invoice.client)
    |> Get.request()

    %__MODULE__{
      invoice |
      client: invoice.client,
      get: get
    }
  end
end
