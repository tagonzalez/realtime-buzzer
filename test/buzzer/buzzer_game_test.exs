defmodule Buzzer.BuzzerGameTest do
  use Buzzer.DataCase

  alias Buzzer.BuzzerGame

  describe "rooms" do
    alias Buzzer.BuzzerGame.Room

    @valid_attrs %{nanoid: "some nanoid"}
    @update_attrs %{nanoid: "some updated nanoid"}
    @invalid_attrs %{nanoid: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BuzzerGame.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert BuzzerGame.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert BuzzerGame.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = BuzzerGame.create_room(@valid_attrs)
      assert room.nanoid == "some nanoid"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BuzzerGame.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = BuzzerGame.update_room(room, @update_attrs)
      assert room.nanoid == "some updated nanoid"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = BuzzerGame.update_room(room, @invalid_attrs)
      assert room == BuzzerGame.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = BuzzerGame.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> BuzzerGame.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = BuzzerGame.change_room(room)
    end
  end
end
