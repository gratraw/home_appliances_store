defmodule HomeAppliancesStoreWeb.CustomersController do
  use HomeAppliancesStoreWeb, :controller

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Customers

  action_fallback HomeAppliancesStoreWeb.FallbackController

  def index(conn, _params) do
    customer = Schema.list_customer()
    render(conn, "index.json", customer: customer)
  end

  def create(conn, %{"customers" => customers_params}) do
    with {:ok, %Customers{} = customers} <- Schema.create_customers(customers_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.customers_path(conn, :show, customers))
      |> render("show.json", customers: customers)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect("Get customer for id: #{id}")
    case Schema.get_customers(id) do
      nil -> {:error, :not_found}
      customers -> render(conn, "show.json", customers: customers)
    end
  end

  def update(conn, %{"id" => id, "customers" => customers_params}) do
    customers = Schema.get_customers(id)

    with {:ok, %Customers{} = customers} <- Schema.update_customers(customers, customers_params) do
      render(conn, "show.json", customers: customers)
    end
  end

  def delete(conn, %{"id" => id}) do
    customers = Schema.get_customers(id)

    with {:ok, %Customers{}} <- Schema.delete_customers(customers) do
      send_resp(conn, :no_content, "")
    end
  end
end
