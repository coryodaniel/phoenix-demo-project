defmodule Toy.UserView do
  use Toy.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email, :first_name, :last_name, :inserted_at, :updated_at]

  def type(_user,_conn), do: "users"
  location "/api/users/:id"

  # has_one :author,
  #   serializer: PersonSerializer,
  #   include: true,
  #   field: :authored_by
  #
  # has_many :comments,
  #   links: [
  #     related: "/articles/:id/comments",
  #     self: "/articles/:id/relationships/comments"
  #   ]
  #
  # def comments(article, _conn) do
  #   Comment.for_article(article)
  # end
end
