defmodule HacketWeb.Post do
  @moduledoc """
  LiveView for displaying standalone post
  """
  use HacketWeb, :live_view

  alias Hacket.Posts
  alias HacketWeb.{Endpoint, Profile}

  import Routes

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    case Posts.get_post(id) do
      nil ->
        raise HacketWeb.NotFoundError

      post ->
        socket =
          socket
          |> assign(
            page_title:
              "#{post.title} · #{String.capitalize(post.user.username)} (#{post.user.username})"
          )
          |> assign(post: post)
          |> assign(user: post.user)

        {:ok, socket}
    end
  end
end
