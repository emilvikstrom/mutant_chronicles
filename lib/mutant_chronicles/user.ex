defmodule MutantChronicles.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MutantChronicles.Repo

  #@primary_key {:user_id, :binary_id, autogenerate: true}
  #@primary_key {:username, :string, ${}}
  schema "users" do
    field(:username, :string, null: false)
    field(:user_id, :binary_id, null: false)
    field(:password, :string, null: false)
    field(:characters, {:array, :string}, default: [])

    timestamps()
  end

  def new_user(%{"username" => username, "password" => password}) do
    %__MODULE__{
      user_id: Ecto.UUID.generate(),
      username: username,
      password: :crypto.hash(:sha256, password) |> Base.encode16()
    }
    |> Repo.insert()
  end


  def read(credentials) when is_map(credentials) do
    #credentials = %{username: username, password: password}
    Repo.get_by(__MODULE__, credentials)
  end
  def read(uuid) do
    Repo.get_by(__MODULE__, %{user_id: uuid})
  end
end
