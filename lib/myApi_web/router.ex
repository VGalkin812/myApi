defmodule MyApiWeb.Router do
  use MyApiWeb, :router

  alias MyApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", MyApiWeb do
    pipe_through :api

    post "/sign_up", UserController, :sign_up
    post "/sign_in", UserController, :sign_in
    delete "/delete", UserController, :delete
    post "/update", UserController, :update
    get "/list_users", UserController, :list_users
    get "/by_id", UserController, :by_id
  end

  scope "/api/v1", MyApiWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/sign_in_jwt", UserController, :sign_in_jwt
  end
end
