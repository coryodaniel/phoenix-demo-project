defmodule Toy.TeamController do
  use Toy.Web, :controller

  alias Toy.Team
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    teams = Repo.all(Team)
    render(conn, "index.json-api", data: teams)
  end

  def create(conn, %{"data" => data = %{"type" => "team", "attributes" => _team_params}}) do
    changeset = Team.changeset(%Team{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, team} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", team_path(conn, :show, team))
        |> render("show.json-api", data: team)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Toy.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)
    render(conn, "show.json-api", data: team)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "team", "attributes" => _team_params}}) do
    team = Repo.get!(Team, id)
    changeset = Team.changeset(team, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, team} ->
        render(conn, "show.json-api", data: team)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Toy.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(team)

    send_resp(conn, :no_content, "")
  end

end
