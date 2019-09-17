defmodule ChatterWeb.UserLive.New do
  @moduledoc """
  Renders new user page, calls Accounts module to validate user data whenever
  the form changes, sends user params to be persisted and redirects to profile.
  """
  use Phoenix.LiveView

  alias ChatterWeb.Router.Helpers, as: Routes
  alias Chatter.Accounts
  alias Chatter.Accounts.User

  def mount(_session, socket) do
    {:ok, assign(socket, %{changeset: Accounts.change_user(%User{})})}
  end

  def render(assigns), do: Phoenix.View.render(ChatterWeb.UserView, "new.html", assigns)

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> User.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        socket = put_flash(socket, :info, "User created")

        {:noreply,
         live_redirect(socket, to: Routes.live_path(socket, ChatterWeb.UserLive.Show, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
