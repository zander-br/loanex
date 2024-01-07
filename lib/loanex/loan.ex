defmodule Loanex.Loan do
  def get_allowed_loans(available_loans, customer) do
    available_loans
    |> Enum.filter(&loan_allowed?(&1, customer))
    |> Enum.map(&parse_loans/1)
  end

  defp loan_allowed?(%{type: :personal}, _customer), do: true

  defp loan_allowed?(%{type: :collateralized}, %{income: income} = customer)
       when income <= 3000,
       do: young_customer?(customer) && lives_in_sao_paulo?(customer)

  defp loan_allowed?(%{type: :collateralized}, %{income: income} = customer)
       when income > 3000 and income < 5000,
       do: lives_in_sao_paulo?(customer)

  defp loan_allowed?(%{type: :collateralized}, %{income: income} = customer)
       when income >= 5000,
       do: young_customer?(customer)

  defp loan_allowed?(%{type: :collateralized}, _customer), do: false

  defp loan_allowed?(%{type: :payroll}, %{income: income}) when income >= 5000, do: true
  defp loan_allowed?(%{type: :payroll}, _customer), do: false

  defp lives_in_sao_paulo?(%{location: location}), do: location == "SP"

  defp young_customer?(%{age: age}), do: age < 30

  defp parse_loans(%{type: type, interest_rate: taxes}), do: %{taxes: taxes, type: type}
end
