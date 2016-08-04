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

user_generator = fn(_) ->
  changeset = Toy.User.registration_changeset(%Toy.User{}, %{
    first_name: Faker.Name.first_name,
    last_name: Faker.Name.last_name,
    email: Faker.Internet.email
  })

  if changeset.valid? do
    Toy.Repo.insert!(changeset)
    IO.puts "Created: #{changeset.changes.email}"
  end
end

Enum.each 1..100_000, user_generator
