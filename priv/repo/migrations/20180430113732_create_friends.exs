defmodule Gateway.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do

      timestamps()
    end

  end
end
