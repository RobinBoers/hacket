defmodule HacketWeb.PageControllerTest do
  use HacketWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to hacket!"
  end
end
