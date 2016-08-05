defmodule Toy.Repo do
  use Ecto.Repo, otp_app: :toy
  use Scrivener, page_size: 10, max_page_size: 100_000
end
