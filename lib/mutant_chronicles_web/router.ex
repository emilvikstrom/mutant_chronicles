defmodule MutantChroniclesWeb.Router do
  use MutantChroniclesWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :browser_live do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MutantChroniclesWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/create", LoginController, :create
    post "/login", LoginController, :login
    get "/user", UserController, :get
    post "/user/character", UserController, :new_character
end

  # Other scopes may use custom stacks.
  # scope "/api", MutantChroniclesWeb do
  #   pipe_through :api
  # end
end
