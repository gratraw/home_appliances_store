defmodule HomeAppliancesStore.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :product_id, :integer
      add :name, :text
      add :description, :text
      add :brand, :text
      add :category, :text
      add :price, :decimal

      timestamps()
    end

  end
end
