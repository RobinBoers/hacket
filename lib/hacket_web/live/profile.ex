defmodule HacketWeb.Profile do
  @moduledoc """
  LiveView for user profiles.
  """
  use HacketWeb, :live_view

  alias Hacket.Repo

  alias Hacket.{Accounts, Posts}
  alias HacketWeb.Pagination

  import Ecto.Query

  @per_page 15

  @impl true
  def mount(%{"username" => username}, _session, socket) do
    user = Accounts.get_user_by_username(username)

    case user do
      nil ->
        raise HacketWeb.NotFoundError

      user ->
        {:ok,
         socket
         |> assign(page_title: "#{String.capitalize(user.username)} (@#{user.username})")
         |> assign(user: user)
         |> assign(page: 1)
         |> assign(per_page: @per_page)
         |> assign(total: Pagination.total(user, :posts))
         |> assign(posts: get_posts(user, 1))}
    end
  end

  def get_posts(user, page) do
    user
    |> Ecto.assoc(:posts)
    |> order_by({:desc, :inserted_at})
    |> Pagination.paginate(page, @per_page)
    |> Repo.all()
  end

  @impl true
  def handle_event("change-page", %{"page" => page}, socket) do
    user = socket.assigns.current_user
    page = String.to_integer(page)

    socket =
      socket
      |> assign(page: page)
      |> assign(secrets: get_posts(user, page))

    {:noreply, socket}
  end
end
