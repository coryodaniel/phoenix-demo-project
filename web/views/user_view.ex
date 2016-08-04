defmodule Toy.UserView do
  use Toy.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email, :first_name, :last_name, :inserted_at, :updated_at]

  location "/users/:id"
end
