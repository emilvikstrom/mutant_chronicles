defmodule MutantChroniclesWeb.UserController do
  use MutantChroniclesWeb, :controller
  alias MutantChronicles.{User, Token}

  def get(conn, params) do
    token = extract_bearer(conn)

    case authenticate(token) do
      {:ok, user_id} ->
        %MutantChronicles.User{
          username: username,
          characters: characters
        } = User.read(user_id)

        conn
        |> put_status(200)
        |> json(%{username: username, characters: characters})

      {:error, :no_token} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{"error" => "no bearer"})

      {:error, :invalid_token} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{"error" => "invalid token"})
    end
  end

  def new_character(conn, %{"character" => character}) do
    token = extract_bearer(conn)

    case authenticate(token) do
      {:ok, user_id} ->
        case User.insert_character(user_id, character) do
          :ok ->
            conn
            |> put_status(200)
            |> json(%{"nyi" => "nyi"})

          {:error, reason} ->
            conn
            |> put_status(400)
            |> json(%{"error" => reason})
        end

      {:error, :no_token} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{"error" => "no bearer"})

      {:error, :invalid_token} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{"error" => "invalid token"})
    end
  end

  defp extract_bearer(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> token
      [] -> []
    end
  end

  defp authenticate([]) do
    {:error, :no_token}
  end

  defp authenticate(token) do
    case Token.verify_and_validate(token) do
      {:ok, %{"user_id" => user_id}} ->
        {:ok, user_id}

      _ ->
        {:error, :invalid_token}
    end
  end
end
