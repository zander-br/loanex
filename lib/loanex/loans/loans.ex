defmodule Loanex.Loans do
  alias Loanex.Loans.Loan
  alias Loanex.Repo

  def get_available_loans(), do: Repo.all(Loan)
end
