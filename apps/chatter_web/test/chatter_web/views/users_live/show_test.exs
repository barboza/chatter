defmodule ChatterWeb.UserLive.ShowTest do
  use ChatterWeb.ConnCase
  import Phoenix.LiveViewTest
  import Chatter.UserFactory
  @endpoint ChatterWeb.Endpoint

  setup do
    {:ok, user: insert(:user)}
  end

  test "renders user profile", %{conn: conn, user: user} do
    {:ok, _view, html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Show, user))

    assert html =~ "Profile: Some User"
  end
end
