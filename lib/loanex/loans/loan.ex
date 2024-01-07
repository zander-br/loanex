defmodule Loanex.Loans.Loan do
  use Ecto.Schema

  import Ecto.Changeset

  alias Loanex.Loans.Enums.LoanType
  alias __MODULE__

  @fields ~w(name type interest_rate)a

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "loans" do
    field :name, :string
    field :type, LoanType
    field :interest_rate, :integer

    timestamps()
  end

  def changeset(attrs) do
    %Loan{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:name)
  end
end
