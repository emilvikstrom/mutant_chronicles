defmodule MutantChronicles.Repo.Migrations.Repo do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string, null: false)
      add(:password, :string, null: false)
      add(:characters, {:array,:string}, null: true)

      timestamps()
    end
  end

    schema "users" do
    #field(:user_id, :string)
    field(:username, :string)
    field(:password, :string)
    field(:characters, {:array, :string})

    timestamps()
  end
end
