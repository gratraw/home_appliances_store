defmodule HomeAppliancesStoreWeb.OrdersView do
  use HomeAppliancesStoreWeb, :view
  alias HomeAppliancesStoreWeb.OrdersView

  def render("index.json", %{order: order}) do
    %{data: render_many(order, OrdersView, "orders.json")}
  end

  def render("show.json", %{orders: orders}) do
    %{data: render_one(orders, OrdersView, "orders.json")}
  end

  def render("orders.json", %{orders: orders}) do
    %{id: orders.id,
      order_id: orders.order_id,
      customer_id: orders.customer_id,
      product_ids: orders.product_ids,
      seller_id: orders.seller_id,
      ordered: orders.ordered,
      status_id: orders.status_id,
      notes: orders.notes}
  end
end
