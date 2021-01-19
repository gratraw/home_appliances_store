defmodule HomeAppliancesStoreWeb.Order_statusesView do
  use HomeAppliancesStoreWeb, :view
  alias HomeAppliancesStoreWeb.Order_statusesView

  def render("index.json", %{order_status: order_status}) do
    %{data: render_many(order_status, Order_statusesView, "order_statuses.json")}
  end

  def render("show.json", %{order_statuses: order_statuses}) do
    %{data: render_one(order_statuses, Order_statusesView, "order_statuses.json")}
  end

  def render("order_statuses.json", %{order_statuses: order_statuses}) do
    %{id: order_statuses.id,
      status_id: order_statuses.status_id,
      status_name: order_statuses.status_name}
  end
end
