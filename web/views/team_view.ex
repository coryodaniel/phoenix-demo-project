defmodule Toy.TeamView do
  use Toy.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :color, :inserted_at, :updated_at]

  def type, do: "teams"

  location "/api/teams/:id"

  has_many :users,
    serializer: Toy.UserView,
    links: [
      related: "/api/teams/:id/users",
      self: "/api/teams/:id/relationships/users"
    ]
end
