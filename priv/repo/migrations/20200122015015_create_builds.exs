defmodule PostitCicd.Repo.Migrations.CreateBuilds do
  use Ecto.Migration

  def change do
    create table(:builds) do
      add :id, :integer
      add :username, :string

      timestamps()
    end

  end
end
