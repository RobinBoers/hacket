defmodule Hacket.Repo.Migrations.Profile do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :display_name, :string
      add :description, :string
      add :profile_picture, :string
    end

    create unique_index(:users, [:username])
  end
end
