defmodule Buzzer.BuzzerGame.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :nanoid, :string
    field :host, :string
    timestamps()
  end

  def changeset(room, attrs) do
    room
    |> cast(attrs, [:nanoid, :host])
    |> validate_required([:nanoid, :host])
    |> unique_constraint(:nanoid)
  end
end
