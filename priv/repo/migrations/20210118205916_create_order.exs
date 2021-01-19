defmodule HomeAppliancesStore.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:order) do
      add :order_id, :integer
      add :customer_id, :integer
      add :product_ids, {:array, :integer}
      add :seller_id, :integer
      add :ordered, :date
      add :status_id, :integer
      add :notes, :text

      timestamps()
    end

  end
end
