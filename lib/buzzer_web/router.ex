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
    # TODO: limit this to show and create
    resources "/rooms", RoomController
    post "/rooms/join_by_id", RoomController, :join_by_nanoid
  end

  # Other scopes may use custom stacks.
  # scope "/api", BuzzerWeb do
  #   pipe_through :api
  # end
end
