defmodule Toy.Router do
  use Toy.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", Toy do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
  end
end
