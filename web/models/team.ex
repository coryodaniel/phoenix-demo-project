defmodule Toy.Team do
  use Toy.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "teams" do
    field :name, :string
    field :color, :string
    timestamps()
    many_to_many :user, Toy.User, join_through: "teams_users"
  end


  @required_params [:name, :color]
  @optional_params []
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params, @optional_params)
    |> validate_required(@required_params)
  end
end
