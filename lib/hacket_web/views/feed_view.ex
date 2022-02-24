defmodule HacketWeb.FeedView do
  use HacketWeb, :view

  import Hacket
  import Phoenix.Controller, only: [current_url: 1]
end
