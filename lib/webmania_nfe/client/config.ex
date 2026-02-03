defmodule WebmaniaNfe.Client.Config do
  @moduledoc """
  Configuração do cliente para autenticação na API da Webmania.

  Contém `base_url`, `consumer_key`, `consumer_secret`, `access_token` e `access_token_secret`.

  ## Usage
  Authentication is performed using the HTTP header so it is necessary to send your application's `X-Consumer-Key`
  and `X-Consumer-Secret`, along with your user's `X-Access-Token` and `X-Access-Token-Secret`.

  You can find this information in your WebmaniaBR account.

  Do this to create a client config with your credentials via `WebmaniaNfe.Client.Config.new/5`:
  ```
      iex> config = WebmaniaNfe.Client.Config.new("https://webmaniabr.com/api/", "CONSUMER_KEY", "CONSUMER_SECRET", "ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")
      %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      }

      iex> config = %WebmaniaNfe.Client.Config{
          base_url: "https://webmaniabr.com/api/",
          consumer_key: "CONSUMER_KEY",
          consumer_secret: "CONSUMER_SECRET",
          access_token: "ACCESS_TOKEN",
          access_token_secret: "ACCESS_TOKEN_SECRET"
        }
      %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      }
  ```
  """

  @derive Nestru.Decoder
  defstruct base_url: nil,
            consumer_key: nil,
            consumer_secret: nil,
            access_token: nil,
            access_token_secret: nil

  @doc """
    Build a new SDk config.

    - base_url: The base url of the API
    - consumer_key: Your consumer key from WebmaniaBR account
    - consumer_secret: Your consumer secret from WebmaniaBR account
    - access_token: Your access token from WebmaniaBR account
    - access_token_secret: Your access token secret from WebmaniaBR account
  ```
      iex> config = WebmaniaNfe.Client.Config.new("https://webmaniabr.com/api/", "CONSUMER_KEY", "CONSUMER_SECRET", "ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")
      %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      }

      iex> config = %WebmaniaNfe.Client.Config{
          base_url: "https://webmaniabr.com/api/",
          consumer_key: "CONSUMER_KEY",
          consumer_secret: "CONSUMER_SECRET",
          access_token: "ACCESS_TOKEN",
          access_token_secret: "ACCESS_TOKEN_SECRET"
        }
      %WebmaniaNfe.Client.Config{
        base_url: "https://webmaniabr.com/api/",
        consumer_key: "CONSUMER_KEY",
        consumer_secret: "CONSUMER_SECRET",
        access_token: "ACCESS_TOKEN",
        access_token_secret: "ACCESS_TOKEN_SECRET"
      }
  ```
  """
  def new(base_url, consumer_key, consumer_secret, access_token, access_token_secret) do
    %__MODULE__{
      base_url: base_url,
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      access_token: access_token,
      access_token_secret: access_token_secret
    }
  end
end