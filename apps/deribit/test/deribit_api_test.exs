defmodule DeribitApiTest do
  use ExUnit.Case

  alias Deribit.DeribitApi

  @tag :deribit_api
  test "connects to the deribit exchange" do
    api = DeribitApi.open()
    {:ok, index} = DeribitApi.index(api)
    IO.inspect index
  end
end
