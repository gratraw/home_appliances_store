defmodule HomeAppliancesStoreWeb.ProductsControllerTest do
  use HomeAppliancesStoreWeb.ConnCase

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Products

  @create_attrs %{
    brand: "some brand",
    category: "some category",
    description: "some description",
    name: "some name",
    price: "120.5",
    product_id: 42
  }
  @update_attrs %{
    brand: "some updated brand",
    category: "some updated category",
    description: "some updated description",
    name: "some updated name",
    price: "456.7",
    product_id: 43
  }
  @invalid_attrs %{brand: nil, category: nil, description: nil, name: nil, price: nil, product_id: nil}

  def fixture(:products) do
    {:ok, products} = Schema.create_products(@create_attrs)
    products
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all product", %{conn: conn} do
      conn = get(conn, Routes.products_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create products" do
    test "renders products when data is valid", %{conn: conn} do
      conn = post(conn, Routes.products_path(conn, :create), products: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.products_path(conn, :show, id))

      assert %{
               "id" => id,
               "brand" => "some brand",
               "category" => "some category",
               "description" => "some description",
               "name" => "some name",
               "price" => "120.5",
               "product_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.products_path(conn, :create), products: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update products" do
    setup [:create_products]

    test "renders products when data is valid", %{conn: conn, products: %Products{id: id} = products} do
      conn = put(conn, Routes.products_path(conn, :update, products), products: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.products_path(conn, :show, id))

      assert %{
               "id" => id,
               "brand" => "some updated brand",
               "category" => "some updated category",
               "description" => "some updated description",
               "name" => "some updated name",
               "price" => "456.7",
               "product_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, products: products} do
      conn = put(conn, Routes.products_path(conn, :update, products), products: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete products" do
    setup [:create_products]

    test "deletes chosen products", %{conn: conn, products: products} do
      conn = delete(conn, Routes.products_path(conn, :delete, products))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.products_path(conn, :show, products))
      end
    end
  end

  defp create_products(_) do
    products = fixture(:products)
    %{products: products}
  end
end
