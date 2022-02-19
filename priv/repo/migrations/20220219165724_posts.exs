defmodule Hacket.Repo.Migrations.Posts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :user_id, references(:users)
      timestamps()
    end
  end
end
