defmodule HomeAppliancesStore.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table(:customer) do
      add :customer_id, :integer
      add :name, :text
      add :email, :text
      add :created_on, :date
      add :notes, :text

      timestamps()
    end

  end
end
