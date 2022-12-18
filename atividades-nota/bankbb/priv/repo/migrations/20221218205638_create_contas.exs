defmodule Bankbb.Repo.Migrations.CreateContas do
  use Ecto.Migration

  def change do
    create table(:contas) do
      add :numero, :string
      add :titular, :string
      add :saldo, :integer

      timestamps()
    end
  end
end
