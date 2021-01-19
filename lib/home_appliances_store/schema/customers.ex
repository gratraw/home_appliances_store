defmodule HomeAppliancesStore.Schema.Customers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer" do
    field :created_on, :date
    field :customer_id, :integer
    field :email, :string
    field :name, :string
    field :notes, :string

    timestamps()
  end

  @doc false
  def changeset(customers, attrs) do
    customers
    |> cast(attrs, [:customer_id, :name, :email, :created_on, :notes])
    |> validate_required([:customer_id, :name, :email, :created_on, :notes])
  end
end
