defmodule HacketWeb.Page.Index do
  @moduledoc """
  Homepage for hacket.
  """
  use HacketWeb, :live_view

  alias HacketWeb.{Endpoint, NewPost, Profile}
  import Routes

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Home")}
  end
end
