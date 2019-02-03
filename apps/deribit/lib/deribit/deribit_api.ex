defmodule Deribit.DeribitApi do
  alias __MODULE__

  alias DataWarehouse.{Repo, DeribitNotification}

  defstruct [:connection]

  def open do
    [key: key, secret: secret] = Application.fetch_env!(:deribit, :deribit_api)
    open(key, secret)
  end

  def open(key, secret) do
    {:ok, connection} = :deribit_api.open(key, secret)
    %DeribitApi{connection: connection}
  end

  def index(%DeribitApi{connection: connection}) do
    :deribit_api.index(connection)
  end

  def subscribe(%DeribitApi{connection: connection}) do
    params = %{
      instrument: [:all],
      event: [
        :order_book,
        :trade,
        :my_trade,
        :user_order,
        :index,
        :portfolio,
        :announcement,
        :delivery
      ]
    }

    connection |> :deribit_api.subscribe(params, async: &subscribe_callback/1)
  end

  def subscribe_callback({:ok, "subscribed"}) do
    IO.puts "subscribed"
  end

  def subscribe_callback({:notifications, notifications}) do
    IO.write "."
    notifications |> Enum.each(&notification_response/1)
  end

  def subscribe_callback(unknown) do
    IO.puts "Unknown callback"
    IO.inspect unknown
    IO.puts "===================="
  end

  defp notification_response(%{"message" => message} = notification) do
    DeribitNotification.new(message, notification) |> Repo.insert
  end
end
