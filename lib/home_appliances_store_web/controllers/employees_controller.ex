defmodule HomeAppliancesStoreWeb.EmployeesController do
  use HomeAppliancesStoreWeb, :controller

  alias HomeAppliancesStore.Schema
  alias HomeAppliancesStore.Schema.Employees

  action_fallback HomeAppliancesStoreWeb.FallbackController

  def index(conn, _params) do
    employee = Schema.list_employee()
    render(conn, "index.json", employee: employee)
  end

  def create(conn, %{"employees" => employees_params}) do
    with {:ok, %Employees{} = employees} <- Schema.create_employees(employees_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.employees_path(conn, :show, employees))
      |> render("show.json", employees: employees)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect("Get employee for id: #{id}")
    case Schema.get_employees(id) do
      nil -> {:error, :not_found}
      employees -> render(conn, "show.json", employees: employees)
    end
  end

  def update(conn, %{"id" => id, "employees" => employees_params}) do
    employees = Schema.get_employees(id)

    with {:ok, %Employees{} = employees} <- Schema.update_employees(employees, employees_params) do
      render(conn, "show.json", employees: employees)
    end
  end

  def delete(conn, %{"id" => id}) do
    employees = Schema.get_employees(id)

    with {:ok, %Employees{}} <- Schema.delete_employees(employees) do
      send_resp(conn, :no_content, "")
    end
  end
end
