defmodule MutantChroniclesWeb.LoginController do
  use MutantChroniclesWeb, :controller

  def login(conn, params) do
    IO.inspect(conn)
    IO.inspect(params)
    json(conn, %{})
  end
end
