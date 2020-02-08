defmodule MutantChroniclesWeb.LoginController do
  use MutantChroniclesWeb, :controller
  alias MutantChronicles.User

  def create(conn, params) do
    case User.new_user(params) do
      {:ok, %User{user_id: user_id}} ->
        conn
        |> put_status(200)
        |> json(%{"user_id" => user_id})

      {:error, _reason} ->
        conn
        |> put_status(400)
        |> json(%{"error" => "username already taken"})
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    credentials = %{
      username: username,
      password:
        :crypto.hash(:sha256, password)
        |> Base.encode16()
    }

    case User.read(credentials) do
      %User{} -> conn |> put_status(200) |> json(%{})
      nil -> conn |> put_status(400) |> json(%{"error" => "wrong credentials"})
    end
  end

  def login(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{"error" => "missing username or password"})
  end
end
