defmodule MutantChroniclesWeb.LoginControllerTest do
  use MutantChroniclesWeb.ConnCase
  alias MutantChronicles.User

  test "create user", %{conn: conn} do
    conn = post(conn, "/create", %{"username" => "emil", "password" => "password"})

    assert %{"user_id" => _} = json_response(conn, 200)
  end

  test "create same user twice", %{conn: conn} do
    post(conn, "/create", %{"username" => "emil", "password" => "password"})
    response = post(build_conn(), "/create", %{"username" => "emil", "password" => "password"})
    assert json_response(response, 400) == %{"error" => "username already taken"}
  end

  test "login user", %{conn: conn} do
    {:ok, %User{user_id: userId}} =
      User.new_user(%{"username" => "emil", "password" => "password"})

    conn = post(conn, "/login", %{"username" => "emil", "password" => "password"})
    assert %{"token" => token} = json_response(conn, 200)
    assert {:ok, %{"user_id" => ^userId}} = MutantChronicles.Token.verify_and_validate(token)
  end

  test "get user data", %{conn: conn} do
    User.new_user(%{"username" => "emil", "password" => "password"})
    conn = post(conn, "/login", %{"username" => "emil", "password" => "password"})
    %{"token" => token} = json_response(conn, 200)
    conn = build_conn()

    conn =
      conn
      |> put_req_header("authorization", "Bearer " <> token)
      |> get("/user")

    assert json_response(conn, 200)
  end

  test "get user data with no header", %{conn: conn} do
    User.new_user(%{"username" => "emil", "password" => "password"})
    conn = post(conn, "/login", %{"username" => "emil", "password" => "password"})
    %{"token" => token} = json_response(conn, 200)
    conn = build_conn()

    conn =
      conn
      |> get("/user")

    assert json_response(conn, 401)
  end

  test "get user data with invalid token", %{conn: conn} do
    User.new_user(%{"username" => "emil", "password" => "password"})
    conn = post(conn, "/login", %{"username" => "emil", "password" => "password"})
    %{"token" => token} = json_response(conn, 200)
    conn = build_conn()

    conn =
      conn
      |> put_req_header("authorization", "Bearer " <> "blalala")
      |> get("/user")

    assert json_response(conn, 401)
  end
end
