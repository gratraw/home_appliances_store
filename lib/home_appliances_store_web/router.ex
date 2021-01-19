defmodule HomeAppliancesStoreWeb.Router do
  use HomeAppliancesStoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HomeAppliancesStoreWeb do
    pipe_through :api
    get "/customers", CustomersController, :index
    get "/customers/:id", CustomersController, :show
    post "/customers", CustomersController, :create
    delete "/customers/:id", CustomersController, :delete
    put "/customers/:id", CustomersController, :update
    
    get "/orders", OrdersController, :index
    get "/orders/:id", OrdersController, :show
    post "/orders", OrdersController, :create
    delete "/orders/:id", OrdersController, :delete
    put "/orders/:id", OrdersController, :update

    get "/employees", EmployeesController, :index
    get "/employees/:id", EmployeesController, :show
    post "/employees", EmployeesController, :create
    delete "/employees/:id", EmployeesController, :delete
    put "/employees/:id", EmployeesController, :update

    get "/products", ProductsController, :index
    get "/products/:id", ProductsController, :show
    post "/products", ProductsController, :create
    delete "/products/:id", ProductsController, :delete
    put "/products/:id", ProductsController, :update

    get "/order_statuses", Order_statusesController, :index
    get "/order_statuses/:id", Order_statusesController, :show
    post "/order_statuses", Order_statusesController, :create
    delete "/order_statuses/:id", Order_statusesController, :delete
    put "/order_statuses/:id", Order_statusesController, :update
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: HomeAppliancesStoreWeb.Telemetry
    end
  end
end
