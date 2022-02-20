defmodule HacketWeb.NewPost do
  @moduledoc """
  LiveView for writing new posts.
  """
  use HacketWeb, :live_view

  alias Hacket.Posts
  alias Hacket.Posts.Post

  alias HacketWeb.{Endpoint, Profile}

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "New post")
      |> assign(changeset: get_post_changeset())

    {:ok, socket}
  end

  defp get_post_changeset() do
    Posts.change_post(%Post{})
  end

  @impl true
  def handle_event("validate", %{"post" => params}, socket) do
    changeset =
      %Post{}
      |> Posts.change_post(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"post" => %{"body" => body, "title" => title}}, socket) do
    user = socket.assigns.current_user

    case Posts.create_post(user, %{body: body, title: title}) do
      {:ok, _post} ->
        {:noreply, redirect(socket, to: Routes.live_path(Endpoint, Profile, user.username))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
