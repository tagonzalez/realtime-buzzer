defmodule BuzzerWeb.Router do
  use BuzzerWeb, :router

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

  scope "/", BuzzerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/join", PageController, :join

    resources "/rooms", RoomController, only: [:create, :show, :new]
    post "/rooms/join", RoomController, :join
  end

  # Other scopes may use custom stacks.
  # scope "/api", BuzzerWeb do
  #   pipe_through :api
  # end
end
