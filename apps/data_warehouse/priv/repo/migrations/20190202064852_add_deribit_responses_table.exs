defmodule DataWarehouse.Repo.Migrations.AddDeribitResponsesTable do
  use Ecto.Migration

  def change do
    create table(:deribit_responses) do
      add :type, :string, null: false
      add :response, :jsonb, null: false
      timestamps()
    end

    create index(:deribit_responses, :type);
  end
end
