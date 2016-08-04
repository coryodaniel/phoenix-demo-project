defmodule Toy.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS citext"
    execute ~s(CREATE EXTENSION IF NOT EXISTS "uuid-ossp")

    create table(:users, primary_key: false) do
      # Here we explicitly set the type of id column as uuid and assign it as primary key
      add :id, :uuid, primary_key: true
      add :email, :citext
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end

  def down do
    drop table(:users)
  end
end
