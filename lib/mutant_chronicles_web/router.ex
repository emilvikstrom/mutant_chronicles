defmodule MutantChroniclesWeb.Router do
  use MutantChroniclesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MutantChroniclesWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/login", LoginController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", MutantChroniclesWeb do
  #   pipe_through :api
  # end
end
