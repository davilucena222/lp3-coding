defmodule Aula1 do
  @doc "Retorna o número passado como parâmetro, somando a 5."
  @doc "Forma padrão de definir função"
  def soma5(x) do
    x + 5
  end

  @doc "Outra forma de definir função (modelo para recursões)"
  def soma10(x), do: x + 10

  @doc "Testa se o número é par"
  def numero_par(n) do
    if n == 0 do
      true
    else
      not numero_par(n - 1)
    end
  end

  @doc "obtém o sucessor do número n"
  def sucessor(n) do
    n + 1
  end

  @doc "antecessor do número n"
  def sucessor(n) do
    n - 1
  end

  @doc "Soma os números n e m, usando sucessor/antecessor"
  def soma(n, m) do
    if m == 0 do
      n
    else
      1 + soma(n, m - 1)
    end
  end
end
