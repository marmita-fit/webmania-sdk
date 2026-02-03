defmodule WebmaniaNfe.Config do
  @moduledoc """
  Backwards-compatible configuration module.

  Accepts a map with keys in camelCase or snake_case (string or atom) and
  returns {:ok, %WebmaniaNfe.Config{}} when required credentials are present.
  """

  @derive Nestru.Decoder
  defstruct base_url: "https://webmaniabr.com/api/",
            consumer_key: nil,
            consumer_secret: nil,
            access_token: nil,
            access_token_secret: nil

  @doc """
  Build a new config from a map. Accepts keys in snake_case or camelCase,
  as atoms or strings. Example:

      iex> {:ok, %WebmaniaNfe.Config{} = cfg} = WebmaniaNfe.Config.new(%{consumerKey: "k", consumerSecret: "s", accessToken: "t", accessTokenSecret: "u"})
      {:ok, cfg}
  """
  def new(map) when is_map(map) do
    consumer_key = fetch(map, [:consumer_key, :consumerKey, "consumerKey", "consumer_key"])
    consumer_secret = fetch(map, [:consumer_secret, :consumerSecret, "consumerSecret", "consumer_secret"])
    access_token = fetch(map, [:access_token, :accessToken, "accessToken", "access_token"])
    access_token_secret = fetch(map, [:access_token_secret, :accessTokenSecret, "accessTokenSecret", "access_token_secret"])
    base_url = fetch(map, [:base_url, :baseUrl, "baseUrl", "base_url"]) || "https://webmaniabr.com/api/"

    case {consumer_key, consumer_secret, access_token, access_token_secret} do
      {nil, _, _, _} -> {:error, :invalid_config}
      {_, nil, _, _} -> {:error, :invalid_config}
      {_, _, nil, _} -> {:error, :invalid_config}
      {_, _, _, nil} -> {:error, :invalid_config}
      {ck, cs, at, ats} ->
        {:ok,
         %__MODULE__{
           base_url: base_url,
           consumer_key: ck,
           consumer_secret: cs,
           access_token: at,
           access_token_secret: ats
         }}
    end
  end

  defp fetch(map, candidates) do
    Enum.find_value(candidates, fn key -> Map.get(map, key) end)
  end
end
