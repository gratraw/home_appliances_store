defmodule HomeAppliancesStore.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_status) do
      add :status_id, :integer
      add :status_name, :text

      timestamps()
    end

  end
end
