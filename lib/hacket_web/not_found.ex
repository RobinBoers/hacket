defmodule HacketWeb.NotFoundError do
  @moduledoc """
  Error that renders 404 page if raised.
  """
  defexception message: "not found", plug_status: 404
end
