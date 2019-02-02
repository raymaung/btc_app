defmodule Deribit.DeribitApi do
  alias __MODULE__

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

  def subscribe_callback({:notifications, response}) do
    IO.puts "notifications received"
  end

  def subscribe_callback({response_type, response}) do
    IO.puts "Unknown response_type: #{response_type}"
  end
end
