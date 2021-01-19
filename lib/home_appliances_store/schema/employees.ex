defmodule HomeAppliancesStore.Schema.Employees do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employee" do
    field :contract_until, :date
    field :employee_id, :integer
    field :name, :string
    field :position, :string
    field :salary, :decimal

    timestamps()
  end

  @doc false
  def changeset(employees, attrs) do
    employees
    |> cast(attrs, [:employee_id, :name, :position, :salary, :contract_until])
    |> validate_required([:employee_id, :name, :position, :salary, :contract_until])
  end
end
