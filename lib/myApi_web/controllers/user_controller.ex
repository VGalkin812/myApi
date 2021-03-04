defmodule MyApiWeb.UserController do
  use MyApiWeb, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias MyApi.Accounts
  alias MyApi.Accounts.User

  alias MyApi.Guardian

  action_fallback MyApiWeb.FallbackController

  def sign_up(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {1, :minute}) do
      conn |> render("jwt.json", %{user: user, jwt: token})
    end
  end

  def sign_in(conn, %{"user" => %{"login" => login, "password" => password}}) do
    user = Accounts.get_user(login)

    case Accounts.token_sign_in(login, password) do
      {:ok, token, _claims} ->
        conn
        |> render("jwt.json", %{jwt: token, user: user})

      _ ->
        {:error, :unauthorized}
    end
  end

  def sign_in_jwt(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: {1, :minute})
    conn |> render("jwt.json", %{user: user, jwt: token})
  end

  def update(conn, %{"login" => login, "password" => password, "user" => user_params}) do
    user = Accounts.get_user(login)

    if checkpw(password, user.password_hash) do
      with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
        render(conn, "show.json", %{user: user})
      end
    else
      render(conn, "error.json", reason: :wrong_password)
    end
  end

  def delete(conn, %{"login" => login, "password" => password}) do
    user = Accounts.get_user(login)

    if checkpw(password, user.password_hash) do
      with {:ok, %User{}} <- Accounts.delete_user(user) do
        render(conn, "show.json", %{user: user})
      end
    else
      render(conn, "error.json", reason: :wrong_password)
    end
  end

  def list_users(conn, _params) do
    users = Accounts.list_users()
    render(conn, "list_users.json", %{users: users})
  end

  def by_id(conn, %{"id" => id}) do
    user = Accounts.get_by_id(id)
    render(conn, "by_id.json", %{user: user})
  end
end
