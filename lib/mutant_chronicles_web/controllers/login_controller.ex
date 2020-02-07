defmodule MutantChronicles.LoginController do
  def login(conn, params) do
    IO.inspect(conn)
    IO.inspect(params)
    json(conn, %{})
  end
end