defmodule HacketWeb.Pagination do
  @moduledoc """
  Module for handeling pagination in Ecto queries.
  """

  alias Hacket.Repo
  import Ecto.Query

  def total(schema, key) do
    schema
    |> Ecto.assoc(key)
    |> Repo.aggregate(:count, :id)
  end

  def paginate(query, page, per_page) do
    offset_by = per_page * page - per_page

    query
    |> limit(^per_page)
    |> offset(^offset_by)
  end

  def total_pages(total_items, per_page) do
    case rem(total_items, per_page) do
      0 -> div(total_items, per_page)
      _ -> div(total_items, per_page) + 1
    end
  end
end
