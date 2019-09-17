defmodule ChatterWeb.UserLive.Show do
  @moduledoc """
  Renders user profile
  """
  use Phoenix.LiveView

  alias Chatter.Accounts

  def mount(%{path_params: %{"id" => id}}, socket) do
    user = Accounts.get_user!(id)
    {:ok, assign(socket, :user, user)}
  end

  def render(assigns), do: Phoenix.View.render(ChatterWeb.UserView, "show.html", assigns)
end
