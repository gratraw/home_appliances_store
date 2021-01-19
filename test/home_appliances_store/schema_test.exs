defmodule HomeAppliancesStore.SchemaTest do
  use HomeAppliancesStore.DataCase

  alias HomeAppliancesStore.Schema

  describe "order" do
    alias HomeAppliancesStore.Schema.Orders

    @valid_attrs %{customer_id: 42, notes: "some notes", order_id: 42, ordered: ~D[2010-04-17], product_ids: [], seller_id: 42, status_id: 42}
    @update_attrs %{customer_id: 43, notes: "some updated notes", order_id: 43, ordered: ~D[2011-05-18], product_ids: [], seller_id: 43, status_id: 43}
    @invalid_attrs %{customer_id: nil, notes: nil, order_id: nil, ordered: nil, product_ids: nil, seller_id: nil, status_id: nil}

    def orders_fixture(attrs \\ %{}) do
      {:ok, orders} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_orders()

      orders
    end

    test "list_order/0 returns all order" do
      orders = orders_fixture()
      assert Schema.list_order() == [orders]
    end

    test "get_orders!/1 returns the orders with given id" do
      orders = orders_fixture()
      assert Schema.get_orders!(orders.id) == orders
    end

    test "create_orders/1 with valid data creates a orders" do
      assert {:ok, %Orders{} = orders} = Schema.create_orders(@valid_attrs)
      assert orders.customer_id == 42
      assert orders.notes == "some notes"
      assert orders.order_id == 42
      assert orders.ordered == ~D[2010-04-17]
      assert orders.product_ids == []
      assert orders.seller_id == 42
      assert orders.status_id == 42
    end

    test "create_orders/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_orders(@invalid_attrs)
    end

    test "update_orders/2 with valid data updates the orders" do
      orders = orders_fixture()
      assert {:ok, %Orders{} = orders} = Schema.update_orders(orders, @update_attrs)
      assert orders.customer_id == 43
      assert orders.notes == "some updated notes"
      assert orders.order_id == 43
      assert orders.ordered == ~D[2011-05-18]
      assert orders.product_ids == []
      assert orders.seller_id == 43
      assert orders.status_id == 43
    end

    test "update_orders/2 with invalid data returns error changeset" do
      orders = orders_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_orders(orders, @invalid_attrs)
      assert orders == Schema.get_orders!(orders.id)
    end

    test "delete_orders/1 deletes the orders" do
      orders = orders_fixture()
      assert {:ok, %Orders{}} = Schema.delete_orders(orders)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_orders!(orders.id) end
    end

    test "change_orders/1 returns a orders changeset" do
      orders = orders_fixture()
      assert %Ecto.Changeset{} = Schema.change_orders(orders)
    end
  end

  describe "customer" do
    alias HomeAppliancesStore.Schema.Customers

    @valid_attrs %{created_on: ~D[2010-04-17], customer_id: 42, email: "some email", name: "some name", notes: "some notes"}
    @update_attrs %{created_on: ~D[2011-05-18], customer_id: 43, email: "some updated email", name: "some updated name", notes: "some updated notes"}
    @invalid_attrs %{created_on: nil, customer_id: nil, email: nil, name: nil, notes: nil}

    def customers_fixture(attrs \\ %{}) do
      {:ok, customers} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_customers()

      customers
    end

    test "list_customer/0 returns all customer" do
      customers = customers_fixture()
      assert Schema.list_customer() == [customers]
    end

    test "get_customers!/1 returns the customers with given id" do
      customers = customers_fixture()
      assert Schema.get_customers!(customers.id) == customers
    end

    test "create_customers/1 with valid data creates a customers" do
      assert {:ok, %Customers{} = customers} = Schema.create_customers(@valid_attrs)
      assert customers.created_on == ~D[2010-04-17]
      assert customers.customer_id == 42
      assert customers.email == "some email"
      assert customers.name == "some name"
      assert customers.notes == "some notes"
    end

    test "create_customers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_customers(@invalid_attrs)
    end

    test "update_customers/2 with valid data updates the customers" do
      customers = customers_fixture()
      assert {:ok, %Customers{} = customers} = Schema.update_customers(customers, @update_attrs)
      assert customers.created_on == ~D[2011-05-18]
      assert customers.customer_id == 43
      assert customers.email == "some updated email"
      assert customers.name == "some updated name"
      assert customers.notes == "some updated notes"
    end

    test "update_customers/2 with invalid data returns error changeset" do
      customers = customers_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_customers(customers, @invalid_attrs)
      assert customers == Schema.get_customers!(customers.id)
    end

    test "delete_customers/1 deletes the customers" do
      customers = customers_fixture()
      assert {:ok, %Customers{}} = Schema.delete_customers(customers)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_customers!(customers.id) end
    end

    test "change_customers/1 returns a customers changeset" do
      customers = customers_fixture()
      assert %Ecto.Changeset{} = Schema.change_customers(customers)
    end
  end

  describe "employee" do
    alias HomeAppliancesStore.Schema.Employees

    @valid_attrs %{contract_until: ~D[2010-04-17], employee_id: 42, name: "some name", position: "some position", salary: "120.5"}
    @update_attrs %{contract_until: ~D[2011-05-18], employee_id: 43, name: "some updated name", position: "some updated position", salary: "456.7"}
    @invalid_attrs %{contract_until: nil, employee_id: nil, name: nil, position: nil, salary: nil}

    def employees_fixture(attrs \\ %{}) do
      {:ok, employees} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_employees()

      employees
    end

    test "list_employee/0 returns all employee" do
      employees = employees_fixture()
      assert Schema.list_employee() == [employees]
    end

    test "get_employees!/1 returns the employees with given id" do
      employees = employees_fixture()
      assert Schema.get_employees!(employees.id) == employees
    end

    test "create_employees/1 with valid data creates a employees" do
      assert {:ok, %Employees{} = employees} = Schema.create_employees(@valid_attrs)
      assert employees.contract_until == ~D[2010-04-17]
      assert employees.employee_id == 42
      assert employees.name == "some name"
      assert employees.position == "some position"
      assert employees.salary == Decimal.new("120.5")
    end

    test "create_employees/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_employees(@invalid_attrs)
    end

    test "update_employees/2 with valid data updates the employees" do
      employees = employees_fixture()
      assert {:ok, %Employees{} = employees} = Schema.update_employees(employees, @update_attrs)
      assert employees.contract_until == ~D[2011-05-18]
      assert employees.employee_id == 43
      assert employees.name == "some updated name"
      assert employees.position == "some updated position"
      assert employees.salary == Decimal.new("456.7")
    end

    test "update_employees/2 with invalid data returns error changeset" do
      employees = employees_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_employees(employees, @invalid_attrs)
      assert employees == Schema.get_employees!(employees.id)
    end

    test "delete_employees/1 deletes the employees" do
      employees = employees_fixture()
      assert {:ok, %Employees{}} = Schema.delete_employees(employees)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_employees!(employees.id) end
    end

    test "change_employees/1 returns a employees changeset" do
      employees = employees_fixture()
      assert %Ecto.Changeset{} = Schema.change_employees(employees)
    end
  end

  describe "order_status" do
    alias HomeAppliancesStore.Schema.Order_statuses

    @valid_attrs %{status_id: 42, status_name: "some status_name"}
    @update_attrs %{status_id: 43, status_name: "some updated status_name"}
    @invalid_attrs %{status_id: nil, status_name: nil}

    def order_statuses_fixture(attrs \\ %{}) do
      {:ok, order_statuses} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_order_statuses()

      order_statuses
    end

    test "list_order_status/0 returns all order_status" do
      order_statuses = order_statuses_fixture()
      assert Schema.list_order_status() == [order_statuses]
    end

    test "get_order_statuses!/1 returns the order_statuses with given id" do
      order_statuses = order_statuses_fixture()
      assert Schema.get_order_statuses!(order_statuses.id) == order_statuses
    end

    test "create_order_statuses/1 with valid data creates a order_statuses" do
      assert {:ok, %Order_statuses{} = order_statuses} = Schema.create_order_statuses(@valid_attrs)
      assert order_statuses.status_id == 42
      assert order_statuses.status_name == "some status_name"
    end

    test "create_order_statuses/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_order_statuses(@invalid_attrs)
    end

    test "update_order_statuses/2 with valid data updates the order_statuses" do
      order_statuses = order_statuses_fixture()
      assert {:ok, %Order_statuses{} = order_statuses} = Schema.update_order_statuses(order_statuses, @update_attrs)
      assert order_statuses.status_id == 43
      assert order_statuses.status_name == "some updated status_name"
    end

    test "update_order_statuses/2 with invalid data returns error changeset" do
      order_statuses = order_statuses_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_order_statuses(order_statuses, @invalid_attrs)
      assert order_statuses == Schema.get_order_statuses!(order_statuses.id)
    end

    test "delete_order_statuses/1 deletes the order_statuses" do
      order_statuses = order_statuses_fixture()
      assert {:ok, %Order_statuses{}} = Schema.delete_order_statuses(order_statuses)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_order_statuses!(order_statuses.id) end
    end

    test "change_order_statuses/1 returns a order_statuses changeset" do
      order_statuses = order_statuses_fixture()
      assert %Ecto.Changeset{} = Schema.change_order_statuses(order_statuses)
    end
  end

  describe "product" do
    alias HomeAppliancesStore.Schema.Products

    @valid_attrs %{brand: "some brand", category: "some category", description: "some description", name: "some name", price: "120.5", product_id: 42}
    @update_attrs %{brand: "some updated brand", category: "some updated category", description: "some updated description", name: "some updated name", price: "456.7", product_id: 43}
    @invalid_attrs %{brand: nil, category: nil, description: nil, name: nil, price: nil, product_id: nil}

    def products_fixture(attrs \\ %{}) do
      {:ok, products} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_products()

      products
    end

    test "list_product/0 returns all product" do
      products = products_fixture()
      assert Schema.list_product() == [products]
    end

    test "get_products!/1 returns the products with given id" do
      products = products_fixture()
      assert Schema.get_products!(products.id) == products
    end

    test "create_products/1 with valid data creates a products" do
      assert {:ok, %Products{} = products} = Schema.create_products(@valid_attrs)
      assert products.brand == "some brand"
      assert products.category == "some category"
      assert products.description == "some description"
      assert products.name == "some name"
      assert products.price == Decimal.new("120.5")
      assert products.product_id == 42
    end

    test "create_products/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_products(@invalid_attrs)
    end

    test "update_products/2 with valid data updates the products" do
      products = products_fixture()
      assert {:ok, %Products{} = products} = Schema.update_products(products, @update_attrs)
      assert products.brand == "some updated brand"
      assert products.category == "some updated category"
      assert products.description == "some updated description"
      assert products.name == "some updated name"
      assert products.price == Decimal.new("456.7")
      assert products.product_id == 43
    end

    test "update_products/2 with invalid data returns error changeset" do
      products = products_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_products(products, @invalid_attrs)
      assert products == Schema.get_products!(products.id)
    end

    test "delete_products/1 deletes the products" do
      products = products_fixture()
      assert {:ok, %Products{}} = Schema.delete_products(products)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_products!(products.id) end
    end

    test "change_products/1 returns a products changeset" do
      products = products_fixture()
      assert %Ecto.Changeset{} = Schema.change_products(products)
    end
  end
end
