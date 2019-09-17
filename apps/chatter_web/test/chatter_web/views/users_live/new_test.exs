defmodule ChatterWeb.UserLive.NewTest do
  use ChatterWeb.ConnCase
  import Phoenix.LiveViewTest
  alias ChatterWeb.Router.Helpers, as: Routes
  @endpoint ChatterWeb.Endpoint

  test "renders new user page", %{conn: conn} do
    {:ok, _view, html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.New))

    assert html =~ "New User"
  end

  test "validates invalid data when form changes", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.New))

    assert render_change(view, :validate, %{"user" => %{"name" => "some name"}}) =~ "errors below"
  end

  test "validates when creating invalid user", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.New))

    assert render_submit(view, :save, %{"user" => %{"name" => "some name"}}) =~ "errors below"
  end

  test "redirects to user page after creating user", %{conn: conn} do
    user_params = %{
      "name" => "Some user",
      "username" => "someuser"
    }

    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.New))

    assert_redirect(view, path, fn ->
      assert render_submit(view, :save, %{"user" => user_params})
    end)

    assert String.match?(path, ~r/\/users\/\d+/)
  end
end
