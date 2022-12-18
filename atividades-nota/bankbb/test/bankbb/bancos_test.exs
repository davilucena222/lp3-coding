defmodule Bankbb.BancosTest do
  use Bankbb.DataCase

  alias Bankbb.Bancos

  describe "contas" do
    alias Bankbb.Bancos.Contas

    import Bankbb.BancosFixtures

    @invalid_attrs %{numero: nil, saldo: nil, titular: nil}

    test "list_contas/0 returns all contas" do
      contas = contas_fixture()
      assert Bancos.list_contas() == [contas]
    end

    test "get_contas!/1 returns the contas with given id" do
      contas = contas_fixture()
      assert Bancos.get_contas!(contas.id) == contas
    end

    test "create_contas/1 with valid data creates a contas" do
      valid_attrs = %{numero: "some numero", saldo: 42, titular: "some titular"}

      assert {:ok, %Contas{} = contas} = Bancos.create_contas(valid_attrs)
      assert contas.numero == "some numero"
      assert contas.saldo == 42
      assert contas.titular == "some titular"
    end

    test "create_contas/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bancos.create_contas(@invalid_attrs)
    end

    test "update_contas/2 with valid data updates the contas" do
      contas = contas_fixture()
      update_attrs = %{numero: "some updated numero", saldo: 43, titular: "some updated titular"}

      assert {:ok, %Contas{} = contas} = Bancos.update_contas(contas, update_attrs)
      assert contas.numero == "some updated numero"
      assert contas.saldo == 43
      assert contas.titular == "some updated titular"
    end

    test "update_contas/2 with invalid data returns error changeset" do
      contas = contas_fixture()
      assert {:error, %Ecto.Changeset{}} = Bancos.update_contas(contas, @invalid_attrs)
      assert contas == Bancos.get_contas!(contas.id)
    end

    test "delete_contas/1 deletes the contas" do
      contas = contas_fixture()
      assert {:ok, %Contas{}} = Bancos.delete_contas(contas)
      assert_raise Ecto.NoResultsError, fn -> Bancos.get_contas!(contas.id) end
    end

    test "change_contas/1 returns a contas changeset" do
      contas = contas_fixture()
      assert %Ecto.Changeset{} = Bancos.change_contas(contas)
    end
  end
end
