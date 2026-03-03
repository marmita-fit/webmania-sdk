defmodule WebmaniaNfe.Client do
  @moduledoc """
  Cliente HTTP para acesso à API da Webmania, usado por `WebmaniaNfe`.

  ## Uso

  Antes de usar o SDK é necessário configurá-lo com suas credenciais.
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

  defstruct config: %WebmaniaNfe.Client.Config{},
            headers: [],
            request: nil,
            response: nil

  @doc """
    Build a new SDk client.

    - `base_url`: The base url of the API
    - `consumer_key`: Your consumer key from WebmaniaBR account
    - `consumer_secret`: Your consumer secret from WebmaniaBR account
    - `access_token`: Your access token from WebmaniaBR account
    - `access_token_secret`: Your access token secret from WebmaniaBR account

  Check `WebmaniaNfe.Client.Config`.

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
  def new(base_url, consumer_key, consumer_secret, access_token, access_token_secret) do
    new(%WebmaniaNfe.Client.Config{
      base_url: base_url,
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      access_token: access_token,
      access_token_secret: access_token_secret
    })
  end

  @doc """
    Build a new SDk client from `WebmaniaNfe.Client.Config`.

  Check `WebmaniaNfe.Client.Config`.

  ```
      iex> config = WebmaniaNfe.Client.Config.new("https://webmaniabr.com/api/", "CONSUMER_KEY", "CONSUMER_SECRET", "ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")
      %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      }
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
    Or:
  ```
      iex> %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      } |> WebmaniaNfe.Client.new()
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
  def new(%WebmaniaNfe.Client.Config{} = config) do
    %__MODULE__{
      config: config,
      headers: [
        {"Content-Type", "application/json"},
        {"X-Consumer-Key", config.consumer_key},
        {"X-Consumer-Secret", config.consumer_secret},
        {"X-Access-Token", config.access_token},
        {"X-Access-Token-Secret", config.access_token_secret}
      ]
    }
  end

  def request(%__MODULE__{} = client, %_{} = entity) do
    request = %HTTPoison.Request{
      method: entity.method,
      url: process_url(client, entity),
      headers: client.headers,
      body: process_body(entity)
    }

    %__MODULE__{
      client
      | request: request,
        response: HTTPoison.request(request)
    }
  end

  defp process_body(entity) do
    case {entity.method, entity.request} do
      {"POST", %_{}} -> entity.request |> Nestru.encode!() |> Poison.encode!()
      {"POST", nil} -> ""
      {"PUT", %_{}} -> entity.request |> Nestru.encode!() |> Poison.encode!()
      {"PUT", nil} -> ""
      _ -> ""
    end
  end

  defp process_url(client, entity) do
    case {entity.method, entity.request} do
      {"POST", %_{}} ->
        client.config.base_url <> entity.url

      {"POST", nil} ->
        ""

      {"PUT", %_{}} ->
        client.config.base_url <> entity.url

      {"PUT", nil} ->
        ""

      {"GET", %_{} = params} ->
        client.config.base_url <>
          entity.url <> "?" <> (Map.from_struct(params) |> URI.encode_query())

      {"GET", nil} ->
        ""

      _ ->
        ""
    end
  end
end
