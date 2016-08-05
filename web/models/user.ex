defmodule Toy.User do
  use Toy.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:email, :first_name, :last_name]
  @optional_fields ~w()

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    timestamps()

    many_to_many :teams, Toy.Team, join_through: "teams_users"
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params, @optional_fields)
    |> validate_required(@required_params)
    |> unique_constraint(:email)
  end
end
