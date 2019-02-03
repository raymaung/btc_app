defmodule DataWarehouse.DeribitNotification do
  use Ecto.Schema

  alias __MODULE__

  schema "deribit_notifications" do
    field :message, :string
    field :notification, :map
    timestamps()
  end

  def new(message, notification) do
    %DeribitNotification{message: message, notification: notification}
  end
end
