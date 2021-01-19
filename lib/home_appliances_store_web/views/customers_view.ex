defmodule HomeAppliancesStoreWeb.CustomersView do
  use HomeAppliancesStoreWeb, :view
  alias HomeAppliancesStoreWeb.CustomersView

  def render("index.json", %{customer: customer}) do
    %{data: render_many(customer, CustomersView, "customers.json")}
  end

  def render("show.json", %{customers: customers}) do
    %{data: render_one(customers, CustomersView, "customers.json")}
  end

  def render("customers.json", %{customers: customers}) do
    %{id: customers.id,
      customer_id: customers.customer_id,
      name: customers.name,
      email: customers.email,
      created_on: customers.created_on,
      notes: customers.notes}
  end
end
