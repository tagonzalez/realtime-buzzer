defmodule BuzzerWeb.RoomController do
  use BuzzerWeb, :controller

  alias Buzzer.BuzzerGame
  alias Buzzer.BuzzerGame.Room

  def index(conn, _params) do
    rooms = BuzzerGame.list_rooms()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = BuzzerGame.change_room(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    case BuzzerGame.create_room(room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: Routes.room_path(conn, :show, room, name: room.host, is_host: true))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "name" => name, "is_host" => is_host}) do
    room = BuzzerGame.get_room!(id)
    render(conn, "show.html", room: room, name: name, is_host: is_host)
  end

  def join_by_nanoid(conn, %{"nanoid" => nanoid, "name" => name}) do
    room = BuzzerGame.get_room_by_nanoid!(nanoid)
    conn
    |> put_flash(:info, "Joined room succesfully")
    |> redirect(to: Routes.room_path(conn, :show, room, name: name, is_host: false))
  end

  def edit(conn, %{"id" => id}) do
    room = BuzzerGame.get_room!(id)
    changeset = BuzzerGame.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = BuzzerGame.get_room!(id)

    case BuzzerGame.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: Routes.room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = BuzzerGame.get_room!(id)
    {:ok, _room} = BuzzerGame.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: Routes.room_path(conn, :index))
  end
end
