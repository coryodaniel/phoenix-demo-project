defmodule Toy.UserController do
  use Toy.Web, :controller

  alias Toy.User
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do

    page =
      User
      #|> where([p], p.age > 30)
      #|> order_by(desc: :age)
      #|> preload(:friends)
      |> Repo.paginate(conn.query_params["page"] || %{})

    render(
      conn, "index.json-api",
      data: page,
      opts: [
        meta: %{total_count: page.total_entries},
        include: conn.query_params["include"],
        fields: conn.query_params["fields"]
      ]
    )
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json-api", data: user)
  end
end
