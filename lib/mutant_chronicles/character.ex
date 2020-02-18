defmodule MutantChronicles.Character do
  use Ecto.Schema
  import Ecto.Changeset
  alias MutantChronicles.Repo

  @primary_key {:character_id, :binary_id, autogenerate: true}
  schema "character" do
    field(:name, :string, null: false)
    field(:experience, :integer, default: 0)

    timestamps()
  end
end
