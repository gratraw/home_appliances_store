defmodule HomeAppliancesStoreWeb.ProductsView do
  use HomeAppliancesStoreWeb, :view
  alias HomeAppliancesStoreWeb.ProductsView

  def render("index.json", %{product: product}) do
    %{data: render_many(product, ProductsView, "products.json")}
  end

  def render("show.json", %{products: products}) do
    %{data: render_one(products, ProductsView, "products.json")}
  end

  def render("products.json", %{products: products}) do
    %{id: products.id,
      product_id: products.product_id,
      name: products.name,
      description: products.description,
      brand: products.brand,
      category: products.category,
      price: products.price}
  end
end
