defmodule MyApiWeb.UserView do
  use MyApiWeb, :view
  alias MyApiWeb.UserView

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      login: user.login,
      name: user.name,
      password_hash: user.password_hash,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def render("jwt.json", %{jwt: jwt, user: user}) do
    %{
      status: :ok,
      user: render_one(user, UserView, "user.json"),
      jwt: jwt
    }
  end

  def render("list_users.json", %{users: users}) do
    %{List_Users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{
      status: :ok,
      user: render_one(user, UserView, "user.json")
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      status: :error,
      reason: reason
    }
  end

  def render("by_id.json", %{user: user}) do
    %{
      user: render_one(user, UserView, "user.json")
    }
  end
end
