defmodule MutantChronicles.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MutantChronicles.Repo

  schema "users" do
    #field(:user_id, :string)
    field(:username, :string)
    field(:password, :string)
    field(:characters, {:array, :string})

    timestamps()
  end

  def new_user(%{"username" => username, "password" => password}) do
    #username
    #|> cast(%{password:  password, characters: []}, [:password, :characters])
    #|> unique_constraint(:username, name: "users_username_index")
    #|> Repo.insert_or_update()
    Repo.insert(%__MODULE__{username: username, password: password, characters: []})
    |> case do
      {:ok, _user} -> :ok
      {error, reason} -> {error, reason}
    end
  end

end
