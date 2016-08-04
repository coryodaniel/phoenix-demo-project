defmodule Toy.UserController do
  use Toy.Web, :controller

  alias Toy.User
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, params) do
    page =
      User
      |> Repo.paginate(params)

    render(conn, "index.json-api", data: page, opts: )
  end


  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json-api", data: user)
  end

end
