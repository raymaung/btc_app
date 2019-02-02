defmodule DataWarehouse.Repo.Migrations.AddDeribitNotificationsTable do
  use Ecto.Migration

  def change do
    create table(:deribit_notifications) do
      add :message, :string, null: false
      add :notification, :jsonb, null: false
      timestamps()
    end

    create index(:deribit_notifications, :message);
  end
end
