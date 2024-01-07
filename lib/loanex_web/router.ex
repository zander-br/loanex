defmodule LoanexWeb.Router do
  use LoanexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LoanexWeb do
    pipe_through :api
  end
end
