defmodule HomeAppliancesStoreWeb.OrdersControllerTest do
  use HomeAppliancesStoreWeb.ConnCase

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Orders

  @create_attrs %{
    customer_id: 42,
    notes: "some notes",
    order_id: 42,
    ordered: ~D[2010-04-17],
    product_ids: [],
    seller_id: 42,
    status_id: 42
  }
  @update_attrs %{
    customer_id: 43,
    notes: "some updated notes",
    order_id: 43,
    ordered: ~D[2011-05-18],
    product_ids: [],
    seller_id: 43,
    status_id: 43
  }
  @invalid_attrs %{customer_id: nil, notes: nil, order_id: nil, ordered: nil, product_ids: nil, seller_id: nil, status_id: nil}

  def fixture(:orders) do
    {:ok, orders} = Schema.create_orders(@create_attrs)
    orders
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order", %{conn: conn} do
      conn = get(conn, Routes.orders_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create orders" do
    test "renders orders when data is valid", %{conn: conn} do
      conn = post(conn, Routes.orders_path(conn, :create), orders: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.orders_path(conn, :show, id))

      assert %{
               "id" => id,
               "customer_id" => 42,
               "notes" => "some notes",
               "order_id" => 42,
               "ordered" => "2010-04-17",
               "product_ids" => [],
               "seller_id" => 42,
               "status_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.orders_path(conn, :create), orders: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update orders" do
    setup [:create_orders]

    test "renders orders when data is valid", %{conn: conn, orders: %Orders{id: id} = orders} do
      conn = put(conn, Routes.orders_path(conn, :update, orders), orders: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.orders_path(conn, :show, id))

      assert %{
               "id" => id,
               "customer_id" => 43,
               "notes" => "some updated notes",
               "order_id" => 43,
               "ordered" => "2011-05-18",
               "product_ids" => [],
               "seller_id" => 43,
               "status_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, orders: orders} do
      conn = put(conn, Routes.orders_path(conn, :update, orders), orders: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete orders" do
    setup [:create_orders]

    test "deletes chosen orders", %{conn: conn, orders: orders} do
      conn = delete(conn, Routes.orders_path(conn, :delete, orders))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.orders_path(conn, :show, orders))
      end
    end
  end

  defp create_orders(_) do
    orders = fixture(:orders)
    %{orders: orders}
  end
end
