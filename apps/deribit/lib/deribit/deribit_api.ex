defmodule DeribitApi do

  alias __MODULE__
  alias Deribit.WebSocket

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
end
