defmodule HacketWeb.Page.About do
  @moduledoc """
  About page for hacket.
  """
  use HacketWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "About hacket")}
  end
end
