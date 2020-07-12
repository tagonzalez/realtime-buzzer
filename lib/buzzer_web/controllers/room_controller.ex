defmodule BuzzerWeb.RoomController do
  use BuzzerWeb, :controller

  alias Buzzer.BuzzerGame
  alias Buzzer.BuzzerGame.Room

  def new(conn, _params) do
    changeset = BuzzerGame.change_room(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    case BuzzerGame.create_room(room_params) do
      {:ok, room} ->
        render(conn, "show.html", room: room, name: room.host, is_host: true)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def join(conn, %{"nanoid" => nanoid, "name" => name}) do
    room = BuzzerGame.get_room_by_nanoid!(nanoid)
    render(conn, "show.html", room: room, name: name, is_host: false)
  end

  def delete(conn, %{"id" => id}) do
    room = BuzzerGame.get_room!(id)
    {:ok, _room} = BuzzerGame.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
