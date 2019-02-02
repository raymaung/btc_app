use Mix.Config

config :data_warehouse, DataWarehouse.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "data_warehouse_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
