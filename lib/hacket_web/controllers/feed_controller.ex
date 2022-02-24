defmodule HacketWeb.FeedController do
  use HacketWeb, :controller

  alias Hacket.{Repo, Accounts}
  import Ecto.Query

  def rss(conn, %{"username" => username}) do
    user = Accounts.get_user_by_username(username)
    posts = get_posts(user)

    conn
    |> assign(:user, user)
    |> assign(:posts, posts)
    |> put_req_header("accept", "application/xml")
    |> render("feed.xml")
  end

  defp get_posts(user) do
    user
    |> Ecto.assoc(:posts)
    |> limit(40)
    |> Repo.all()
  end
end
