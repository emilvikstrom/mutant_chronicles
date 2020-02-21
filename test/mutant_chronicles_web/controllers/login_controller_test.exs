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

    User.new_user(%{"username" => "emil", "password" => "password"})

    conn = post(conn, "/login", %{"username" => "emil", "password" => "password"})
    assert json_response(conn, 200)

  end
end
