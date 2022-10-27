defmodule Aula5 do
@doc """
  APLICANDO RECURSÃO EM CAUDA, SUBSTITUIÇÃO DE PILHA PELO ACUMULADOR E CONVERTENDO FUNÇÕES RECURSIVAS EM ITERADORES (while, do-while, for...)
"""

  @doc "Soma de uma lista de números"
  @doc "função programa que é estática, precisa guardar o estado do programa na pilha para continuar a sua execução e a pilha pode estourar"
  @doc "aumenta o contexto para fazer o cálculo"
  def soma_lista([]), do: 0
  def soma_lista([x | t]), do: x + soma_lista(t)

  # soma_lista([1, 2, 3, 4])
  # = 1 + soma_lista([2, 3, 4])
  # = 1 + (2 + soma_lista([3, 4]))
  # = 1 + (2 + (3 + soma_lista([4])))
  # = 1 + (2 + (3 + (4 + soma_lista([]))))
  # = 1 + (2 + (3 + (4 + 0)))
  # = 1 + (2 + (3 + 4))
  # = 1 + (2 + 7)
  # = 1 + 9
  # = 10

  @doc "Verifica se o número n ocorre na lista"
  @doc "função processo que fica dinâmica ao longo da execução, não precisa guardar estado atual do programa, possui um looping, função recursiva em cauda ou tail recursion"
  @doc "processo iterativo que não altera o contexto"
  @doc "equivalente a um for iterador"
  @doc "apenas uma chamada na pilha"
  @doc "não é necessário armazenar contexto"
  @doc "não importa o tamanho da lista"
  @doc "é tão eficiente quanto um looping"
  def lista_contem([], n), do: false
  def lista_contem([x | t], n) when x == n, do: true
  def lista_contem([x | t], n), do: lista_contem(t, n)

  # = lista_contem([1, 2, 3, 4], 4)
  # = lista_contem([2, 3, 4], 4)
  # = lista_contem([3, 4], 4)
  # = lista_contem([4], 4)
  # = true

  @doc "segue o mesmo padrão de lista_contem"
  @doc "Soma uma lista de números"
  @doc "Não aumenta o contexto para fazer o cálculo"
  @doc "guarda o contexto no acumulador"
  @doc "o acumulador substitui a pilha, pois armazena o estado atual da função (programa) no próprio acumulador da função"
  @doc "equivalente a um for iterador"
  defp soma_lista_acc([], a), do: a
  defp soma_lista_acc([x | t], a): soma_lista_acc(t, a + x)

  def soma_lista_2(l), do: soma_lista_acc(l, 0)

  # soma_lista_acc([1, 2, 3, 4], 0)
  # = soma_lista_acc([2, 3, 4], 1)
  # = soma_lista_acc([3, 4], 3)
  # = soma_lista_acc([4], 6)
  # = soma_lista_acc([], 10)
  # = 10 

  def tamanho_1([]), do: 0
  def tamanho_1([_ | t]), do: 1 + tamanho_1(t)

  defp tamanho_acc([], a), do: a
  defp tamanho_acc([_ | t], a), do: tamanho_acc(t, a + 1)
  def tamanho(l), do: tamanho_acc(l, 0)
end
