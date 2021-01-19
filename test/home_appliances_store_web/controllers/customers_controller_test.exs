defmodule HomeAppliancesStoreWeb.CustomersControllerTest do
  use HomeAppliancesStoreWeb.ConnCase

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Customers

  @create_attrs %{
    created_on: ~D[2010-04-17],
    customer_id: 42,
    email: "some email",
    name: "some name",
    notes: "some notes"
  }
  @update_attrs %{
    created_on: ~D[2011-05-18],
    customer_id: 43,
    email: "some updated email",
    name: "some updated name",
    notes: "some updated notes"
  }
  @invalid_attrs %{created_on: nil, customer_id: nil, email: nil, name: nil, notes: nil}

  def fixture(:customers) do
    {:ok, customers} = Schema.create_customers(@create_attrs)
    customers
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customer", %{conn: conn} do
      conn = get(conn, Routes.customers_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create customers" do
    test "renders customers when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customers_path(conn, :create), customers: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.customers_path(conn, :show, id))

      assert %{
               "id" => id,
               "created_on" => "2010-04-17",
               "customer_id" => 42,
               "email" => "some email",
               "name" => "some name",
               "notes" => "some notes"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customers_path(conn, :create), customers: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update customers" do
    setup [:create_customers]

    test "renders customers when data is valid", %{conn: conn, customers: %Customers{id: id} = customers} do
      conn = put(conn, Routes.customers_path(conn, :update, customers), customers: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.customers_path(conn, :show, id))

      assert %{
               "id" => id,
               "created_on" => "2011-05-18",
               "customer_id" => 43,
               "email" => "some updated email",
               "name" => "some updated name",
               "notes" => "some updated notes"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, customers: customers} do
      conn = put(conn, Routes.customers_path(conn, :update, customers), customers: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete customers" do
    setup [:create_customers]

    test "deletes chosen customers", %{conn: conn, customers: customers} do
      conn = delete(conn, Routes.customers_path(conn, :delete, customers))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.customers_path(conn, :show, customers))
      end
    end
  end

  defp create_customers(_) do
    customers = fixture(:customers)
    %{customers: customers}
  end
end
