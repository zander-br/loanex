defmodule Loanex.LoanTest do
  use ExUnit.Case

  alias Loanex.Loan

  describe "get_allowed_loans/2" do
    setup do
      available_loans = [
        %{name: "Personal Loan", type: :personal, interest_rate: 4},
        %{name: "Collateralized Loan", type: :collateralized, interest_rate: 3},
        %{name: "Payroll Loan", type: :payroll, interest_rate: 2}
      ]

      customer = %{name: "Erikaya", cpf: "123.456.789-10", age: 29, location: "SP", income: 3000}

      %{available_loans: available_loans, customer: customer}
    end

    test "should return [:personal, :collateralized] loans when customer lives in SP is young and has a basic income",
         %{available_loans: available_loans, customer: customer} do
      customer = %{customer | age: 29, location: "SP", income: 3000}
      permitted_loans = Loan.get_allowed_loans(available_loans, customer)
      assert [%{taxes: 4, type: :personal}, %{taxes: 3, type: :collateralized}] == permitted_loans
    end

    test "should return [:personal] loans when customer does not live in SP is young and has a basic income",
         %{available_loans: available_loans, customer: customer} do
      customer = %{customer | age: 29, location: "MG", income: 3000}
      permitted_loans = Loan.get_allowed_loans(available_loans, customer)
      assert [%{taxes: 4, type: :personal}] == permitted_loans
    end

    test "should return [:personal, :collateralized] loans when customer lives in SP is old and has a basic income",
         %{available_loans: available_loans, customer: customer} do
      customer = %{customer | age: 31, location: "SP", income: 3000}
      permitted_loans = Loan.get_allowed_loans(available_loans, customer)
      assert [%{taxes: 4, type: :personal}] == permitted_loans
    end
  end
end
