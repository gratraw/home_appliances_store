defmodule HomeAppliancesStoreWeb.ProductsController do
  use HomeAppliancesStoreWeb, :controller

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Products

  action_fallback HomeAppliancesStoreWeb.FallbackController

  def index(conn, _params) do
    product = Schema.list_product()
    render(conn, "index.json", product: product)
  end

  def create(conn, %{"products" => products_params}) do
    with {:ok, %Products{} = products} <- Schema.create_products(products_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.products_path(conn, :show, products))
      |> render("show.json", products: products)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect("Get products for id: #{id}")
    case Schema.get_products(id) do
      nil -> {:error, :not_found}
      products -> render(conn, "show.json", products: products)
    end
  end

  def update(conn, %{"id" => id, "products" => products_params}) do
    products = Schema.get_products(id)

    with {:ok, %Products{} = products} <- Schema.update_products(products, products_params) do
      render(conn, "show.json", products: products)
    end
  end

  def delete(conn, %{"id" => id}) do
    products = Schema.get_products(id)

    with {:ok, %Products{}} <- Schema.delete_products(products) do
      send_resp(conn, :no_content, "")
    end
  end
end
