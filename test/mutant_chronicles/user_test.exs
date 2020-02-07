defmodule MutantChronicles.UsersTest do
  use ExUnit.Case
  alias MutantChronicles.User

   setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MutantChronicles.Repo)
  end

  describe "basic usage" do
    test "insert and retreive a user" do
      assert :ok == User.new_user(%{"username" => "emil", "password" => "hello"})
    end
  end
end
