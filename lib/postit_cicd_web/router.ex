defmodule PostitCicdWeb.Router do
  use PostitCicdWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PostitCicdWeb do
    pipe_through :api

    get "/build", BuildController, :index
    post "/build", BuildController, :create
  end
end
