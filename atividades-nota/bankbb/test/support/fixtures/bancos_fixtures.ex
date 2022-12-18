defmodule Bankbb.BancosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bankbb.Bancos` context.
  """

  @doc """
  Generate a contas.
  """
  def contas_fixture(attrs \\ %{}) do
    {:ok, contas} =
      attrs
      |> Enum.into(%{
        numero: "some numero",
        saldo: 42,
        titular: "some titular"
      })
      |> Bankbb.Bancos.create_contas()

    contas
  end
end
