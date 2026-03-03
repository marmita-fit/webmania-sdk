defmodule WebmaniaNfe.Invoice.Cancel.Response do
  @moduledoc """
  Response payload do cancelamento de NF-e.

  Campos retornados pela API:
  - `uuid`: Identificador único da NF-e.
  - `status`: Status da NF-e após o cancelamento.
  - `motivo`: Motivo do cancelamento.
  - `nfe`: Número da NF-e.
  - `serie`: Série da NF-e.
  - `chave`: Chave de acesso da NF-e.
  - `xml`: URL do XML do cancelamento.
  - `log`: Log de processamento.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct [
    :uuid,
    :status,
    :motivo,
    :nfe,
    :serie,
    :chave,
    :xml,
    :log
  ]

  def new(response) when is_map(response), do: Nestru.decode(response, __MODULE__)

  def new({:ok, %__MODULE__{}} = response), do: response

  def new!(response) when is_map(response), do: Nestru.decode!(response, __MODULE__)

  def new!(%__MODULE__{} = response), do: Nestru.decode!(response, __MODULE__)
end
