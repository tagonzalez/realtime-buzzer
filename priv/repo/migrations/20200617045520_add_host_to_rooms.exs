defmodule Buzzer.Repo.Migrations.AddHostToRooms do
  use Ecto.Migration

  def change do
    alter table("rooms") do
      add :host, :text
    end
  end
end
