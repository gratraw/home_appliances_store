defmodule HomeAppliancesStoreWeb.EmployeesView do
  use HomeAppliancesStoreWeb, :view
  alias HomeAppliancesStoreWeb.EmployeesView

  def render("index.json", %{employee: employee}) do
    %{data: render_many(employee, EmployeesView, "employees.json")}
  end

  def render("show.json", %{employees: employees}) do
    %{data: render_one(employees, EmployeesView, "employees.json")}
  end

  def render("employees.json", %{employees: employees}) do
    %{id: employees.id,
      employee_id: employees.employee_id,
      name: employees.name,
      position: employees.position,
      salary: employees.salary,
      contract_until: employees.contract_until}
  end
end
