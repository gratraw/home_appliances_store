defmodule HomeAppliancesStore.Schema.Orders do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order" do
    field :customer_id, :integer
    field :notes, :string
    field :order_id, :integer
    field :ordered, :date
    field :product_ids, {:array, :integer}
    field :seller_id, :integer
    field :status_id, :integer

    timestamps()
  end

  @doc false
  def changeset(orders, attrs) do
    orders
    |> cast(attrs, [:order_id, :customer_id, :product_ids, :seller_id, :ordered, :status_id, :notes])
    |> validate_required([:order_id, :customer_id, :product_ids, :seller_id, :ordered, :status_id, :notes])
  end
end
