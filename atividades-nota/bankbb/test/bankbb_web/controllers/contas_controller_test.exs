defmodule BankbbWeb.ContasControllerTest do
  use BankbbWeb.ConnCase

  import Bankbb.BancosFixtures

  @create_attrs %{numero: "some numero", saldo: 42, titular: "some titular"}
  @update_attrs %{numero: "some updated numero", saldo: 43, titular: "some updated titular"}
  @invalid_attrs %{numero: nil, saldo: nil, titular: nil}

  describe "index" do
    test "lists all contas", %{conn: conn} do
      conn = get(conn, Routes.contas_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Contas"
    end
  end

  describe "new contas" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.contas_path(conn, :new))
      assert html_response(conn, 200) =~ "New Contas"
    end
  end

  describe "create contas" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contas_path(conn, :create), contas: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.contas_path(conn, :show, id)

      conn = get(conn, Routes.contas_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Informações da Conta"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.contas_path(conn, :create), contas: @invalid_attrs)
      assert html_response(conn, 200) =~ "Nova Conta"
    end
  end

  describe "edit contas" do
    setup [:create_contas]

    test "renders form for editing chosen contas", %{conn: conn, contas: contas} do
      conn = get(conn, Routes.contas_path(conn, :edit, contas))
      assert html_response(conn, 200) =~ "Editar Conta"
    end
  end

  describe "update contas" do
    setup [:create_contas]

    test "redirects when data is valid", %{conn: conn, contas: contas} do
      conn = put(conn, Routes.contas_path(conn, :update, contas), contas: @update_attrs)
      assert redirected_to(conn) == Routes.contas_path(conn, :show, contas)

      conn = get(conn, Routes.contas_path(conn, :show, contas))
      assert html_response(conn, 200) =~ "some updated numero"
    end

    test "renders errors when data is invalid", %{conn: conn, contas: contas} do
      conn = put(conn, Routes.contas_path(conn, :update, contas), contas: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Contas"
    end
  end

  describe "delete contas" do
    setup [:create_contas]

    test "deletes chosen contas", %{conn: conn, contas: contas} do
      conn = delete(conn, Routes.contas_path(conn, :delete, contas))
      assert redirected_to(conn) == Routes.contas_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.contas_path(conn, :show, contas))
      end
    end
  end

  defp create_contas(_) do
    contas = contas_fixture()
    %{contas: contas}
  end
end
