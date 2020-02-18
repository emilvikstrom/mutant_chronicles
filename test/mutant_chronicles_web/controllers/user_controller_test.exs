defmodule MutantChroniclesWeb.UserControllerTest do
  use MutantChroniclesWeb.ConnCase
  alias MutantChronicles.User

  test "get user data", %{conn: conn} do
    create_test_user()
    token = get_test_token(conn)

    response =
      build_conn()
      |> put_req_header("authorization", "Bearer " <> token)
      |> get("/user")

    assert json_response(response, 200) == %{"username" => "emil", "characters" => []}
  end

  test "get user data with no header", %{conn: _conn} do
    create_test_user()

    response =
      build_conn()
      |> get("/user")

    assert json_response(response, 401)
  end

  test "get user data with invalid token", %{conn: _conn} do
    create_test_user()

    response =
      build_conn()
      |> put_req_header("authorization", "Bearer " <> "blalala")
      |> get("/user")

    assert json_response(response, 401)
  end

  test "post and retrieve a character", %{conn: conn} do
    create_test_user()
    token = get_test_token(conn)

    character = build_test_character()

    response =
      build_conn()
      |> put_req_header("authorization", "Bearer " <> token)
      |> post("/user/character", %{character: character})

    assert json_response(response, 200) == %{"message" => "character inserted"}

    response =
      build_conn()
      |> put_req_header("authorization", "Bearer " <> token)
      |> get("/user")

    assert json_response(response, 200) == %{"username" => "emil", "characters" => [character]}
  end

  defp create_test_user() do
    User.new_user(%{"username" => "emil", "password" => "password"})
  end

  defp get_test_token(conn) do
    conn = post(conn, "/login", %{"username" => "emil", "password" => "password"})
    %{"token" => token} = json_response(conn, 200)
    token
  end

  defp build_test_character do
    %{
      name: "Steve Faust Killah",
      attributes: %{str: 7, agi: 5, int: 8, per: 9},
      skills: [%{skill_name: "ranged_combat", expertise: 3, focus: 1, base: "agi"}],
      talents: ["rad dude"],
      experience: 0
    }
  end
end
