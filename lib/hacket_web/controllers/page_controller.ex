defmodule HacketWeb.PageController do
  use HacketWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
