defmodule ChatterWeb.UserLive.Edit do
  @moduledoc """
  Renders edit user form, calls Accounts module to validate user data whenever
  the form changes, sends user params to be persisted and redirects to profile
  """

  use Phoenix.LiveView

  alias ChatterWeb.Router.Helpers, as: Routes
  alias Chatter.Accounts
  alias Chatter.Accounts.User

  def mount(%{path_params: %{"id" => id}}, socket) do
    user = Accounts.get_user!(id)
    {:ok, assign(socket, %{user: user, changeset: Accounts.change_user(user)})}
  end

  def render(assigns), do: Phoenix.View.render(ChatterWeb.UserView, "edit.html", assigns)

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> User.changeset(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.update_user(socket.assigns.user, params) do
      {:ok, user} ->
        socket = put_flash(socket, :info, "User updated")

        {:noreply,
         live_redirect(socket, to: Routes.live_path(socket, ChatterWeb.UserLive.Show, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
