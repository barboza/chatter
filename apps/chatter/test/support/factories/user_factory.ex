defmodule Chatter.UserFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Chatter.Repo

  def user_factory do
    %Chatter.Accounts.User{
      name: "Some User",
      username: sequence(:username, &"someuser#{&1}")
    }
  end
end
