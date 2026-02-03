defmodule WebmaniaNfe.Invoice.Create.Request.Customer do
  @moduledoc """
  Representa o cliente (destinatário) usado na requisição de emissão de NF-e.

  Suporta Pessoa Física (CPF) e Pessoa Jurídica (CNPJ), além de clientes estrangeiros.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct [
    :cpf,
    :cnpj,
    :nome_completo,
    :razao_social,
    :endereco,
    :complemento,
    :numero,
    :bairro,
    :cidade,
    :uf,
    :cep,
    :telefone,
    :email,
    :ie,
    :suframa,
    :substituto_tributario,
    :consumidor_final,
    :contribuinte,
    :microcervejaria,
    :id_estrangeiro,
    :nome_estrangeiro,
    :cod_pais,
    :nome_pais
  ]
end
