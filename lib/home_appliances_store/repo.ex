defmodule HomeAppliancesStore.Repo do
  use Ecto.Repo,
    otp_app: :home_appliances_store,
    adapter: Ecto.Adapters.Postgres
end
