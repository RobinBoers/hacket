defmodule HacketWeb.Search do
  @moduledoc """
  LiveView for searching user profiles.
  """
  use HacketWeb, :live_view

  alias Hacket.Repo
  alias Hacket.Accounts.User
  import Ecto.Query

  alias HacketWeb.{Endpoint, Profile}
  import Routes

  @impl true
  def mount(_params, _session, socket) do
      {:ok, socket}
  end

  @impl true
  def handle_params(%{"query" => query}, _url, socket) when query != "" do
    socket =
      socket
      |> assign(page_title: "Search results for \"#{query}\"")
      |> assign(searching: true)
      |> assign(results: get_results(query))
      |> assign(query: query)

    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    socket =
      socket
      |> assign(page_title: "Discover")
      |> assign(searching: false)
      |> assign(results: get_results(nil))

    {:noreply, socket}
  end

  @impl true
  def handle_event("search", %{"search" => %{"query" => ""}}, socket) do
    {:noreply, push_patch(socket, to: live_path(Endpoint, __MODULE__))}
  end
  def handle_event("search", %{"search" => %{"query" => query}}, socket) do
    {:noreply, push_patch(socket, to: live_path(Endpoint, __MODULE__, query))}
  end

  defp get_results(nil) do
    User
    |> limit(10)
    |> Repo.all()
  end

  defp get_results(query) do
    User
    |> where([p], like(p.username, ^"%#{String.replace(query, "%", "\\%")}%"))
    |> limit(10)
    |> Repo.all()
  end
end
