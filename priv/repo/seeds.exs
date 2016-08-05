# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Toy.Repo.insert!(%Toy.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Faker.start

# iex -S mix phoenix.server
# import Ecto.Query
alias Toy.User
alias Toy.Team
alias Toy.Repo
import Ecto.Query

team_generator = fn(_) ->
  changeset = Toy.Team.changeset(%Toy.Team{}, %{
    name: Faker.Team.name,
    color: Faker.Commerce.color
  })

  if changeset.valid? do
    Toy.Repo.insert!(changeset)
    IO.puts "Created: #{changeset.changes.name}"
  end
end

Enum.each 1..5_000, team_generator

user_generator = fn(_) ->
  changeset = Toy.User.registration_changeset(%Toy.User{}, %{
    first_name: Faker.Name.first_name,
    last_name: Faker.Name.last_name,
    email: Faker.Internet.email
  })

  if changeset.valid? do
    teams = Repo.all(from t in Team, order_by: fragment("RANDOM()"), limit: 2)
    changeset
      |> Ecto.Changeset.put_assoc(:teams, teams)
      |> Toy.Repo.insert!

    IO.puts "Created: #{changeset.changes.email}"
  end
end

Enum.each 1..50_000, user_generator
