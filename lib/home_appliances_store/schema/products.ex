defmodule HomeAppliancesStore.Schema.Products do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product" do
    field :brand, :string
    field :category, :string
    field :description, :string
    field :name, :string
    field :price, :decimal
    field :product_id, :integer

    timestamps()
  end

  @doc false
  def changeset(products, attrs) do
    products
    |> cast(attrs, [:product_id, :name, :description, :brand, :category, :price])
    |> validate_required([:product_id, :name, :description, :brand, :category, :price])
  end
end
