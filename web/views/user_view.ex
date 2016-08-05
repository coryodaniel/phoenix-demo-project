require IEx
defmodule Toy.UserView do
  use Toy.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email, :first_name, :last_name, :inserted_at, :updated_at]

  def type(_user,_conn), do: "users"
  location "/api/users/:id"

  has_many :teams,
    serializer: Toy.TeamView,
    links: [
      related: "/api/users/:id/teams",
      self: "/api/users/:id/relationships/teams"
    ]
end
