defmodule DataWarehouse.DeribitNotification do
  use Ecto.Schema

  schema "deribit_notifications" do
    field :message, :string
    field :notification, :map
    timestamps()
  end
end
