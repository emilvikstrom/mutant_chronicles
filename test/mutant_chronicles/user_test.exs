defmodule MutantChronicles.UsersTest do
  use ExUnit.Case
  alias MutantChronicles.User

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MutantChronicles.Repo)
  end

  describe "basic usage" do
    test "insert and retreive a user" do
      assert {:ok, %{user_id: id}} =
        User.new_user(%{"username" => "emil", "password" => "hello"})
      User.read(id)
      assert %User{user_id: id, username: "emil", characters: []} =
        User.read(id)
    end

    test "verify hashed password" do
      {:ok, %{user_id: id}} = User.new_user(%{"username" => "emil", "password" => "hello"})
      %User{password: password} = User.read(id)
      assert password == :crypto.hash(:sha256, "hello") |> Base.encode16()
    end
  end
end
