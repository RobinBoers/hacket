defmodule HacketWeb.Hooks.FetchUser do
  @moduledoc """
  LiveView hook to fetch session token from session and set `current_user` assign on socket.
  """
  import Phoenix.LiveView
  alias Hacket.Accounts

  def on_mount(:default, _params, %{"user_token" => token}, socket) do
    user = Accounts.get_user_by_session_token(token)
    {:cont, assign(socket, current_user: user)}
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, current_user: nil)}
  end
end
