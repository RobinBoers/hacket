defmodule Hacket.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hacket.Accounts.User

  schema "posts" do
    field :title, :string
    field :body, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, max: 70)
  end
end
