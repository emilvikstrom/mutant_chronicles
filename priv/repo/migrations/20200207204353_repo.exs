defmodule MutantChronicles.Repo.Migrations.Repo do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:user_id, :binary_id, null: false)
      add(:username, :string, null: false)
      add(:password, :string, null: false)
      add(:characters, {:array, :string}, null: true)

      timestamps()
    end

    create(unique_index(:users, [:username]))
  end
end
