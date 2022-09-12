defmodule Aula1Test do
  use ExUnit.Case
  doctest Aula1

  test "numero_par retorna true para um número par" do
    assert Aula1.numero_par(6) == true
  end

  test "numero_par retorna false para um número ímpar" do
    assert Aula1.numero_par(9) == false
  end

  test "retorna a soma de dois números de forma recursiva" do
    assert Aula1.soma(10, 10) == 20
  end
end
