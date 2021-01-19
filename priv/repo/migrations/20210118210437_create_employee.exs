defmodule HomeAppliancesStore.Repo.Migrations.CreateEmployee do
  use Ecto.Migration

  def change do
    create table(:employee) do
      add :employee_id, :integer
      add :name, :text
      add :position, :text
      add :salary, :decimal
      add :contract_until, :date

      timestamps()
    end

  end
end
