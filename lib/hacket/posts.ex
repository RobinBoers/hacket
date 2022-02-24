defmodule Hacket.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Hacket.Repo

  alias Hacket.Posts.Post

  ## Database getters

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %User{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Repo.get!(Post, id)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single post.

  Raises nil if the Post does not exist.

  ## Examples

      iex> get_post(123)
      %User{}

      iex> get_post(456)
      nil

  """
  def get_post(id) do
    Repo.get(Post, id)
    |> Repo.preload(:user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for changing a post.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(post, params \\ %{}) do
    Post.changeset(post, params)
  end

  @doc """
  Create new post.
  """
  def create_post(user, post_params) do
    Ecto.build_assoc(user, :posts, post_params)
    |> Repo.insert()
  end
end
