defmodule HomeAppliancesStoreWeb.OrdersController do
  use HomeAppliancesStoreWeb, :controller

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Orders

  action_fallback HomeAppliancesStoreWeb.FallbackController

  def index(conn, _params) do
    order = Schema.list_order()
    render(conn, "index.json", order: order)
  end

  def create(conn, %{"orders" => orders_params}) do
    with {:ok, %Orders{} = orders} <- Schema.create_orders(orders_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.orders_path(conn, :show, orders))
      |> render("show.json", orders: orders)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect("Get orders for id: #{id}")
    case Schema.get_orders(id) do
      nil -> {:error, :not_found}
      orders -> render(conn, "show.json", orders: orders)
    end
  end

  def update(conn, %{"id" => id, "orders" => orders_params}) do
    orders = Schema.get_orders(id)

    with {:ok, %Orders{} = orders} <- Schema.update_orders(orders, orders_params) do
      render(conn, "show.json", orders: orders)
    end
  end

  def delete(conn, %{"id" => id}) do
    orders = Schema.get_orders(id)

    with {:ok, %Orders{}} <- Schema.delete_orders(orders) do
      send_resp(conn, :no_content, "")
    end
  end
end
