defmodule HomeAppliancesStoreWeb.EmployeesControllerTest do
  use HomeAppliancesStoreWeb.ConnCase

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Employees

  @create_attrs %{
    contract_until: ~D[2010-04-17],
    employee_id: 42,
    name: "some name",
    position: "some position",
    salary: "120.5"
  }
  @update_attrs %{
    contract_until: ~D[2011-05-18],
    employee_id: 43,
    name: "some updated name",
    position: "some updated position",
    salary: "456.7"
  }
  @invalid_attrs %{contract_until: nil, employee_id: nil, name: nil, position: nil, salary: nil}

  def fixture(:employees) do
    {:ok, employees} = Schema.create_employees(@create_attrs)
    employees
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all employee", %{conn: conn} do
      conn = get(conn, Routes.employees_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employees" do
    test "renders employees when data is valid", %{conn: conn} do
      conn = post(conn, Routes.employees_path(conn, :create), employees: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.employees_path(conn, :show, id))

      assert %{
               "id" => id,
               "contract_until" => "2010-04-17",
               "employee_id" => 42,
               "name" => "some name",
               "position" => "some position",
               "salary" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.employees_path(conn, :create), employees: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employees" do
    setup [:create_employees]

    test "renders employees when data is valid", %{conn: conn, employees: %Employees{id: id} = employees} do
      conn = put(conn, Routes.employees_path(conn, :update, employees), employees: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.employees_path(conn, :show, id))

      assert %{
               "id" => id,
               "contract_until" => "2011-05-18",
               "employee_id" => 43,
               "name" => "some updated name",
               "position" => "some updated position",
               "salary" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employees: employees} do
      conn = put(conn, Routes.employees_path(conn, :update, employees), employees: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employees" do
    setup [:create_employees]

    test "deletes chosen employees", %{conn: conn, employees: employees} do
      conn = delete(conn, Routes.employees_path(conn, :delete, employees))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.employees_path(conn, :show, employees))
      end
    end
  end

  defp create_employees(_) do
    employees = fixture(:employees)
    %{employees: employees}
  end
end
