defmodule ChatterWeb.ChatLive do
  use Phoenix.LiveView

  @moduledoc false
  def topic(chat_id), do: "chat:#{chat_id}"

  def render(assigns), do: ChatterWeb.ChatView.render("chat.html", assigns)

  def mount(%{path_params: %{"chat" => chat_id}}, socket) do
    ChatterWeb.Endpoint.subscribe(topic(chat_id))

    {:ok,
     assign(
       socket,
       chat: chat_id,
       username: "",
       messages: [],
       content: ""
     )}
  end

  def handle_event("change_username", %{"username" => username}, socket) do
    send(self(), {:update_username, username})
    {:noreply, assign(socket, username: username)}
  end

  def handle_event("new_message", %{"message" => content}, socket) do
    message = %{author: socket.assigns.username, content: content}
    ChatterWeb.Endpoint.broadcast!(topic(socket.assigns.chat), "message", %{message: message})
    {:noreply, assign(socket, content: content)}
  end

  def handle_info({:update_username, username}, socket) do
    {:noreply, assign(socket, username: username)}
  end

  def handle_info(%{event: "message", payload: %{message: message}}, socket) do
    messages = socket.assigns.messages ++ [message]

    {:noreply,
     assign(socket,
       messages: messages,
       content: ""
     )}
  end
end
