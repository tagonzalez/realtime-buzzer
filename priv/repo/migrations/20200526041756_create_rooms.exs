defmodule Buzzer.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :nanoid, :string

      timestamps()
    end

    create unique_index(:rooms, [:nanoid])
  end
end
