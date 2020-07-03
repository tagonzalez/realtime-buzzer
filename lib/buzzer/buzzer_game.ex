defmodule Buzzer.BuzzerGame do
  import Ecto.Query, warn: false
  alias Buzzer.Repo

  alias Buzzer.BuzzerGame.Room

  def list_rooms do
    Repo.all(Room)
  end

  def get_room!(id), do: Repo.get!(Room, id)

  def get_room_by_nanoid!(nanoid), do: Repo.get_by!(Room, nanoid: nanoid)

  def create_room(attrs \\ %{}) do
    %Room{nanoid: Nanoid.generate()}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  def delete_room_by(query), do: Repo.delete(Repo.get_by!(Room, query))

  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
