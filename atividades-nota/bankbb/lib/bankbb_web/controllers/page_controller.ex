defmodule BankbbWeb.PageController do
  use BankbbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
