defmodule Toy.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :color, :string

      timestamps()
    end

    create table(:teams_users, primary_key: false) do
      add :team_id, references(:teams, type: :uuid)
      add :user_id, references(:users, type: :uuid)
    end
  end
end
