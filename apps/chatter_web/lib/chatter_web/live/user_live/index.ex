defmodule ChatterWeb.UserLive.Index do
  @moduledoc """
  Renders list of all users persisted in the database
  """

  use Phoenix.LiveView

  alias Chatter.Accounts

  def mount(_session, socket) do
    users = Accounts.list_users()
    {:ok, assign(socket, :users, users)}
  end

  def render(assigns), do: Phoenix.View.render(ChatterWeb.UserView, "index.html", assigns)

  def handle_event("delete_user", id, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    {:noreply, assign(socket, :users, Accounts.list_users())}
  end
end
