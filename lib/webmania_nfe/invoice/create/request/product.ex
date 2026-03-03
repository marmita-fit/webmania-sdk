defmodule WebmaniaNfe.Invoice.Create.Request.Product do
  @moduledoc """
  Representa um item (produto) no payload da NF-e.

  Contém informações do produto como `nome`, `codigo`, `ncm`, `cest`, `quantidade`, `unidade` e valores.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct [
    :nome,
    :codigo,
    :cod_barras,
    :ncm,
    :cest,
    :quantidade,
    :unidade,
    :peso,
    :origem,
    :subtotal,
    :total,
    :classe_imposto
  ]
end
