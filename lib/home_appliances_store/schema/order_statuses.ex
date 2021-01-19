defmodule HomeAppliancesStore.Schema.Order_statuses do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_status" do
    field :status_id, :integer
    field :status_name, :string

    timestamps()
  end

  @doc false
  def changeset(order_statuses, attrs) do
    order_statuses
    |> cast(attrs, [:status_id, :status_name])
    |> validate_required([:status_id, :status_name])
  end
end
