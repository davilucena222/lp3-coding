defmodule Aula2 do
  @moduledoc """
  Código aula 2
  """

  @doc "Obtém o tamanho da lista l"
  # Testa cada cláusula por vez até bater (como se fosse um if)
  # def tamanho([]) do # cláusula 1 (se a lista for vazia retorna 0)
  #   0
  # end

  # def tamanho([h | t]) do # Mesma função: cláusula 2 (lista não vazia)
  #   tamanho(t) + 1
  # end

  @doc "Escrita compacta de funções"
  def tamanho([]), do: 0
  def tamanho([_ | t]), do: tamanho(t) + 1

  # def tamanho(l) do # [1,2,3]
  #   if l == [] do
  #     0
  #   else
  #     tamanho(tl(l)) + 1
  #   end
  # end

  @doc "obtém a soma dos números da lista l"
  def soma_lista([]), do: 0
  # def soma_lista(separa o head do tail)
  def soma_lista([h | t]), do: h + soma_lista(t)

  @doc "Obtém o segundo elemento da lista l"
  def segundo_elemento([]), do: nil
  def segundo_elemento([_]), do: nil
  def segundo_elemento([_ | [h2 | _]]), do: h2

  # def segundo_elemento(l) do
  #   hd(tl(l))
  # end

  # Pattern matching
  def replica(_, 0), do: 0
  def replica(s, n), do: s <> replica(s, n - 1)

  def mult(_, 0), do: 0
  def mult(a, n), do: a + mult(a, n - 1)

  # def soma_lista(l) do
  #   if l == [] do
  #     0
  #   else
  #     soma_lista(tl(l)) + hd(l)
  #   end
  # end
end
