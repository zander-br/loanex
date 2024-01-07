defmodule Loanex.Loans.Services.Loans do
  alias Loanex.{Loan, Loans}

  def get_allowed_loans(customer) do
    with {:ok, available_loans} <- Loans.get_available_loans(),
         allowed_loans <- Loan.get_allowed_loans(available_loans, customer) do
      {:ok, allowed_loans}
    end
  end
end
