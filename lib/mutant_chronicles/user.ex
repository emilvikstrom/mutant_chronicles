defmodule MutantChronicles.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MutantChronicles.Repo

  @primary_key {:user_id, :binary_id, autgenerate: true}
  schema "users" do
    # field(:user_id, :id, primary_key: :autogenerate)
    field(:username, :string)
    field(:password, :string)
    field(:characters, {:array, :string}, default: [])

    timestamps()
  end

  def new_user(%{"username" => username, "password" => password}) do
    # username
    # |> cast(%{password:  password, characters: []}, [:password, :characters])
    # |> unique_constraint(:username, name: "users_username_index")
    # |> Repo.insert_or_update()

      %__MODULE__{user_id: Ecto.UUID.generate(),
                  username: username,
                  password: :crypto.hash(:sha256, password) |> Base.encode16}
      |> IO.inspect()
      |> Repo.insert()
  end

  def read(uuid) do
    Repo.get(__MODULE__, uuid)
  end
end
