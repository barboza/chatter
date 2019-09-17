defmodule ChatterWeb.UserLive.EditTest do
  use ChatterWeb.ConnCase
  import Phoenix.LiveViewTest
  import Chatter.UserFactory
  alias Chatter.Accounts
  @endpoint ChatterWeb.Endpoint

  @invalid_params %{"user" => %{"name" => ""}}

  setup do
    {:ok, %{user: insert(:user)}}
  end

  test "renders edit form with correct user info", %{conn: conn, user: user} do
    {:ok, _view, html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Edit, user))

    assert html =~ "Edit User"
    assert html =~ user.name
    assert html =~ user.username
  end

  test "Validates invalid data when form changes", %{conn: conn, user: user} do
    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Edit, user))

    assert render_change(view, :validate, @invalid_params) =~ "errors below"
  end

  test "validates when editing an invalid user", %{conn: conn, user: user} do
    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Edit, user))

    assert render_submit(view, :save, @invalid_params) =~ "errors below"
  end

  test "redirects to user page after editing user", %{conn: conn, user: user} do
    user_params = %{
      "name" => "Some Edited user",
      "username" => "someuser"
    }

    {:ok, view, _html} = live(conn, Routes.live_path(conn, ChatterWeb.UserLive.Edit, user))

    assert_redirect(view, path, fn ->
      assert render_submit(view, :save, %{"user" => user_params})
    end)

    assert String.match?(path, ~r/\/users\/\d+/)
    assert Accounts.get_user!(user.id).name == "Some Edited user"
  end
end
