defmodule BankbbWeb.ContasController do
  use BankbbWeb, :controller

  alias Bankbb.Bancos
  alias Bankbb.Bancos.Contas

  def index(conn, _params) do
    contas = Bancos.list_contas()
    render(conn, "index.html", contas: contas)
  end

  def new(conn, _params) do
    changeset = Bancos.change_contas(%Contas{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"contas" => contas_params}) do
    case Bancos.create_contas(contas_params) do
      {:ok, contas} ->
        conn
        |> put_flash(:info, "Conta criada com sucesso!")
        |> redirect(to: Routes.contas_path(conn, :show, contas))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contas = Bancos.get_contas!(id)
    render(conn, "show.html", contas: contas)
  end

  def edit(conn, %{"id" => id}) do
    contas = Bancos.get_contas!(id)
    changeset = Bancos.change_contas(contas)
    render(conn, "edit.html", contas: contas, changeset: changeset)
  end

  def update(conn, %{"id" => id, "contas" => contas_params}) do
    contas = Bancos.get_contas!(id)

    case Bancos.update_contas(contas, contas_params) do
      {:ok, contas} ->
        conn
        |> put_flash(:info, "Conta atualizada com sucesso!")
        |> redirect(to: Routes.contas_path(conn, :show, contas))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", contas: contas, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contas = Bancos.get_contas!(id)
    {:ok, _contas} = Bancos.delete_contas(contas)

    conn
    |> put_flash(:info, "Conta deletada com sucesso!")
    |> redirect(to: Routes.contas_path(conn, :index))
  end
end
