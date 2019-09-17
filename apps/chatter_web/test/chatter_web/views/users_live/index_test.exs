defmodule ChatterWeb.UserLive.IndexTest do
  use ChatterWeb.ConnCase
  import Phoenix.LiveViewTest
  import Chatter.UserFactory
  @endpoint ChatterWeb.Endpoint

  test "list all users", %{conn: conn} do
    for n <- 1..5 do
      insert(:user, name: "User #{n}")
    end

    {:ok, _view, html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Index))

    for n <- 1..5 do
      assert html =~ "User #{n}"
    end
  end

  test "deletes user", %{conn: conn} do
    user = insert(:user)

    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Index))

    result = render_click(view, "delete_user", user.id)

    assert result =~ "Users"
    refute result =~ user.name
  end
end
