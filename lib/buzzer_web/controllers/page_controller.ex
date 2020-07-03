defmodule BuzzerWeb.PageController do
  use BuzzerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def join(conn, _params) do
    render(conn, "join.html")
  end
end
