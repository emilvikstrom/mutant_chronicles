defmodule MutantChroniclesWeb.LoginController do
  use MutantChroniclesWeb, :controller
  alias MutantChronicles.{User, Token}

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
      nil ->
        conn |> put_status(400) |> json(%{"error" => "wrong credentials"})

      user ->
        {:ok, token, _} = Token.create_token(%{user_id: user.user_id})
        conn |> put_status(200) |> json(%{"token" => token})
    end
  end

  def login(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{"error" => "missing username or password"})
  end
end
