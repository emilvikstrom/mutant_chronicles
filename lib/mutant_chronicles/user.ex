defmodule MutantChronicles.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MutantChronicles.Repo

  # @primary_key {:user_id, :binary_id, autogenerate: true}
  # @primary_key {:username, :string, ${}}
  schema "users" do
    field(:username, :string, null: false)
    field(:user_id, :binary_id, null: false)
    field(:password, :string, null: false)
    field(:characters, {:array, :string}, default: [])

    timestamps()
  end

  def new_user(%{"username" => username, "password" => password} = data) do
    data = %{
      user_id: Ecto.UUID.generate(),
      username: username,
      password: :crypto.hash(:sha256, password) |> Base.encode16()}
    cast(%__MODULE__{},data, [:user_id, :username, :password])
    |> unique_constraint(:username, name: "users_username_index")
    |> Repo.insert()
  end

  def read(credentials) when is_map(credentials) do
    # credentials = %{username: username, password: password}
    Repo.get_by(__MODULE__, credentials)
  end

  def read(uuid) do
    Repo.get_by(__MODULE__, %{user_id: uuid})
  end
end
