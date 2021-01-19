defmodule HomeAppliancesStore.Schema do
  @moduledoc """
  The Schema context.
  """

  import Ecto.Query, warn: false
  alias HomeAppliancesStore.Repo

  alias HomeAppliancesStore.Schema.Orders


  def list_order do
    Repo.all(Orders)
  end

  def get_orders(id), do: Repo.get(Orders, id)


  def create_orders(attrs \\ %{}) do
    %Orders{}
    |> Orders.changeset(attrs)
    |> Repo.insert()
  end


  def update_orders(%Orders{} = orders, attrs) do
    orders
    |> Orders.changeset(attrs)
    |> Repo.update()
  end


  def delete_orders(%Orders{} = orders) do
    Repo.delete(orders)
  end

  def change_orders(%Orders{} = orders, attrs \\ %{}) do
    Orders.changeset(orders, attrs)
  end

  alias HomeAppliancesStore.Schema.Customers

  def list_customer do
    Repo.all(Customers)
  end


  def get_customers(id), do: Repo.get(Customers, id)

  def create_customers(attrs \\ %{}) do
    %Customers{}
    |> Customers.changeset(attrs)
    |> Repo.insert()
  end

  def update_customers(%Customers{} = customers, attrs) do
    customers
    |> Customers.changeset(attrs)
    |> Repo.update()
  end

  def delete_customers(%Customers{} = customers) do
    Repo.delete(customers)
  end

  def change_customers(%Customers{} = customers, attrs \\ %{}) do
    Customers.changeset(customers, attrs)
  end

  alias HomeAppliancesStore.Schema.Employees

  def list_employee do
    Repo.all(Employees)
  end

  def get_employees(id), do: Repo.get(Employees, id)

  def create_employees(attrs \\ %{}) do
    %Employees{}
    |> Employees.changeset(attrs)
    |> Repo.insert()
  end

  def update_employees(%Employees{} = employees, attrs) do
    employees
    |> Employees.changeset(attrs)
    |> Repo.update()
  end

  def delete_employees(%Employees{} = employees) do
    Repo.delete(employees)
  end

  def change_employees(%Employees{} = employees, attrs \\ %{}) do
    Employees.changeset(employees, attrs)
  end

  alias HomeAppliancesStore.Schema.Order_statuses

  def list_order_status do
    Repo.all(Order_statuses)
  end

  def get_order_statuses(id), do: Repo.get(Order_statuses, id)


  def create_order_statuses(attrs \\ %{}) do
    %Order_statuses{}
    |> Order_statuses.changeset(attrs)
    |> Repo.insert()
  end

  def update_order_statuses(%Order_statuses{} = order_statuses, attrs) do
    order_statuses
    |> Order_statuses.changeset(attrs)
    |> Repo.update()
  end


  def delete_order_statuses(%Order_statuses{} = order_statuses) do
    Repo.delete(order_statuses)
  end

  def change_order_statuses(%Order_statuses{} = order_statuses, attrs \\ %{}) do
    Order_statuses.changeset(order_statuses, attrs)
  end

  alias HomeAppliancesStore.Schema.Products

  def list_product do
    Repo.all(Products)
  end

  def get_products(id), do: Repo.get(Products, id)

  def create_products(attrs \\ %{}) do
    %Products{}
    |> Products.changeset(attrs)
    |> Repo.insert()
  end

  def update_products(%Products{} = products, attrs) do
    products
    |> Products.changeset(attrs)
    |> Repo.update()
  end


  def delete_products(%Products{} = products) do
    Repo.delete(products)
  end

  def change_products(%Products{} = products, attrs \\ %{}) do
    Products.changeset(products, attrs)
  end
end
