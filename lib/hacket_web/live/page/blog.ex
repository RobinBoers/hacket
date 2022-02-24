defmodule HacketWeb.Page.Blog do
  @moduledoc """
  The hacket blog. Redirects `/user/hacket`.
  """
  use HacketWeb, :live_view

  alias HacketWeb.{Endpoint, Profile}
  import Routes

  def mount(_params, _session, socket) do
    {:ok, push_redirect(socket, to: live_path(Endpoint, Profile, "hacket"))}
  end

  def render(assigns) do
    ~H"""
    You shouldn't see this. Please report this accident to the hacket developers.
    """
  end
end
