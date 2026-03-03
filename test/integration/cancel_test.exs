defmodule Integration.CancelTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open()
    %{bypass: bypass}
  end

  test "cancel invoice with chave and motivo", %{bypass: bypass} do
    Bypass.expect_once(bypass, "PUT", "/1/nfe/cancelamento/", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn)
      decoded = Poison.decode!(body)

      assert decoded["chave"] == "00000000000000000000000000000000000000000000"
      assert decoded["motivo"] == "Cancelamento por erro de digitação"

      Plug.Conn.resp(conn, 200, Poison.encode!(%{
        "uuid" => "uuid-cancel-789",
        "status" => "cancelado",
        "motivo" => "Cancelamento por erro de digitação",
        "chave" => "00000000000000000000000000000000000000000000"
      }))
    end)

    client = WebmaniaNfe.Client.new("http://localhost:#{bypass.port}/", "ck", "cs", "at", "ats")

    request = WebmaniaNfe.Invoice.Cancel.Request.new(
      "00000000000000000000000000000000000000000000",
      "Cancelamento por erro de digitação"
    )

    cancel = WebmaniaNfe.Invoice.Cancel.new()
    cancel = WebmaniaNfe.Invoice.Cancel.add(cancel, request)
    cancel = WebmaniaNfe.Invoice.Cancel.add(cancel, client)
    cancel = WebmaniaNfe.Invoice.Cancel.request(cancel)

    assert %WebmaniaNfe.Invoice.Cancel.Response{} = cancel.response
    assert cancel.response.uuid == "uuid-cancel-789"
    assert cancel.response.status == "cancelado"
    assert cancel.response.motivo == "Cancelamento por erro de digitação"
  end

  test "cancel invoice via WebmaniaNfe facade", %{bypass: bypass} do
    Bypass.expect_once(bypass, "PUT", "/1/nfe/cancelar/", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn)
      decoded = Poison.decode!(body)

      assert decoded["chave"] == "11111111111111111111111111111111111111111111"
      assert decoded["motivo"] == "Cancelamento por erro de digitação"

      Plug.Conn.resp(conn, 200, Poison.encode!(%{
        "uuid" => "uuid-cancel-facade",
        "status" => "cancelado",
        "motivo" => "Cancelamento por erro de digitação"
      }))
    end)

    webmania = WebmaniaNfe.new("http://localhost:#{bypass.port}/", "ck", "cs", "at", "ats")

    request = WebmaniaNfe.Invoice.Cancel.Request.new(
      "11111111111111111111111111111111111111111111",
      "Cancelamento por erro de digitação"
    )

    webmania = WebmaniaNfe.cancel_invoice(webmania, request)

    assert webmania.invoice.cancel.response.uuid == "uuid-cancel-facade"
    assert webmania.invoice.cancel.response.status == "cancelado"
  end
end
