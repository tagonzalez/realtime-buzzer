defmodule Buzzer.BuzzerGame.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :nanoid, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:nanoid])
    |> validate_required([:nanoid])
    |> unique_constraint(:nanoid)
  end
end
