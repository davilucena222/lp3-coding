defmodule Bankbb.Bancos.Contas do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contas" do
    field :numero, :string
    field :saldo, :integer
    field :titular, :string

    timestamps()
  end

  @doc false
  def changeset(contas, attrs) do
    contas
    |> cast(attrs, [:numero, :titular, :saldo])
    |> validate_required([:numero, :titular, :saldo])
  end
end
