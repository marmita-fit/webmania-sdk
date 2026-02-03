defmodule WebmaniaNfe.Invoice.Create.Request.Order do
  @moduledoc """
  Representa informações do pedido vinculadas à NF-e (pagamento, frete e complementos).

  Inclui campos como `pagamento`, `modalidade_frete`, `frete`, `desconto` e `total`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct [
    :informacoes_complementares,
    :pagamento,
    :presenca,
    :modalidade_frete,
    :frete,
    :desconto,
    :total
  ]
end
