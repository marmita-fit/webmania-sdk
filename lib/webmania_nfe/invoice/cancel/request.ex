defmodule WebmaniaNfe.Invoice.Cancel.Request do
  @moduledoc """
  Request payload para cancelamento de NF-e.

  Campos obrigatórios:
  - `chave`: Chave de acesso da NF-e a ser cancelada.
  - `motivo`: Motivo do cancelamento (mínimo 15 caracteres).
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct chave: nil,
            motivo: nil

  def new(chave, motivo) when is_binary(chave) and is_binary(motivo) do
    %__MODULE__{
      chave: chave,
      motivo: motivo
    }
  end

  def new(params) when is_map(params) do
    Nestru.decode(params, __MODULE__)
  end

  def new!(params) when is_map(params) do
    Nestru.decode!(params, __MODULE__)
  end
end
