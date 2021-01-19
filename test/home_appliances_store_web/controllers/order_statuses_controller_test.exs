defmodule HomeAppliancesStoreWeb.Order_statusesControllerTest do
  use HomeAppliancesStoreWeb.ConnCase

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Order_statuses

  @create_attrs %{
    status_id: 42,
    status_name: "some status_name"
  }
  @update_attrs %{
    status_id: 43,
    status_name: "some updated status_name"
  }
  @invalid_attrs %{status_id: nil, status_name: nil}

  def fixture(:order_statuses) do
    {:ok, order_statuses} = Schema.create_order_statuses(@create_attrs)
    order_statuses
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_status", %{conn: conn} do
      conn = get(conn, Routes.order_statuses_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_statuses" do
    test "renders order_statuses when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_statuses_path(conn, :create), order_statuses: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_statuses_path(conn, :show, id))

      assert %{
               "id" => id,
               "status_id" => 42,
               "status_name" => "some status_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_statuses_path(conn, :create), order_statuses: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_statuses" do
    setup [:create_order_statuses]

    test "renders order_statuses when data is valid", %{conn: conn, order_statuses: %Order_statuses{id: id} = order_statuses} do
      conn = put(conn, Routes.order_statuses_path(conn, :update, order_statuses), order_statuses: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_statuses_path(conn, :show, id))

      assert %{
               "id" => id,
               "status_id" => 43,
               "status_name" => "some updated status_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order_statuses: order_statuses} do
      conn = put(conn, Routes.order_statuses_path(conn, :update, order_statuses), order_statuses: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_statuses" do
    setup [:create_order_statuses]

    test "deletes chosen order_statuses", %{conn: conn, order_statuses: order_statuses} do
      conn = delete(conn, Routes.order_statuses_path(conn, :delete, order_statuses))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_statuses_path(conn, :show, order_statuses))
      end
    end
  end

  defp create_order_statuses(_) do
    order_statuses = fixture(:order_statuses)
    %{order_statuses: order_statuses}
  end
end
