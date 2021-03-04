defmodule MyApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApi.Accounts.User

  @moduledoc """
  user schema, password hash
  """

  @required_fields ~w(login name password)a
  @optional_fields ~w()a

  schema "users" do
    field :login, :string
    field :name, :string
    field :password_hash, :string

    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:login)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
