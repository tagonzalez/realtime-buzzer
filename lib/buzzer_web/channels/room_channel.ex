defmodule BuzzerWeb.RoomChannel do
  use BuzzerWeb, :channel
  alias Buzzer.BuzzerGame

  def join("rooms:" <> room_id, _payload, socket) do
    {:ok, assign(socket, :room_id, room_id)}
  end

  def handle_in("buzzer_press", payload, socket) do
    broadcast!(socket, "buzzer_press", %{
      body: payload["body"]
    })

    {:reply, :ok, socket}
  end

  def handle_in("buzzer_reset", _payload, socket) do
    broadcast!(socket, "buzzer_reset", %{})

    {:reply, :ok, socket}
  end

  def handle_in("room_close", payload, socket) do
    require IEx; IEx.pry
    broadcast!(socket, "room_close", %{
      body: payload["body"]
    })

    BuzzerGame.delete_room_by(nanoid: payload["body"]["roomId"])

    {:reply, :ok, socket}
  end
end
