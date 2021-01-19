defmodule HomeAppliancesStoreWeb.Order_statusesController do
  use HomeAppliancesStoreWeb, :controller

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Order_statuses

  action_fallback HomeAppliancesStoreWeb.FallbackController

  def index(conn, _params) do
    order_status = Schema.list_order_status()
    render(conn, "index.json", order_status: order_status)
  end

  def create(conn, %{"order_statuses" => order_statuses_params}) do
    with {:ok, %Order_statuses{} = order_statuses} <- Schema.create_order_statuses(order_statuses_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_statuses_path(conn, :show, order_statuses))
      |> render("show.json", order_statuses: order_statuses)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect("Get order_statuses for id: #{id}")
    case Schema.get_order_statuses(id) do
      nil -> {:error, :not_found}
      order_statuses -> render(conn, "show.json", order_statuses: order_statuses)
    end
  end

  def update(conn, %{"id" => id, "order_statuses" => order_statuses_params}) do
    order_statuses = Schema.get_order_statuses(id)

    with {:ok, %Order_statuses{} = order_statuses} <- Schema.update_order_statuses(order_statuses, order_statuses_params) do
      render(conn, "show.json", order_statuses: order_statuses)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_statuses = Schema.get_order_statuses(id)

    with {:ok, %Order_statuses{}} <- Schema.delete_order_statuses(order_statuses) do
      send_resp(conn, :no_content, "")
    end
  end
end
