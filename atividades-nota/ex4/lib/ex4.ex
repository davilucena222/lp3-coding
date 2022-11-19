defmodule Ex4 do

  # Recursao de cauda e acumuladores

  # Aqui esta a versao recursiva normal que vimos para a funcao soma

  @doc "Soma os numeros a e b."
  def soma_rec(a, 0), do: a
  def soma_rec(a, b), do: 1 + soma_rec(a, b - 1)

  # Esta funcao nao apresenta recursividade de cauda, pois precisa somar
  # 1 ao resultado da chamada recursiva.

  # Escreva uma funcao similar de soma que tenha recursividade de cauda.
  # Use um parametro acumulador para evitar a soma apos a chamada recursiva.

  # Voce pode criar uma funcao auxiliar privada com o parametro acumulador,
  # ou fazer de outra forma.

  def soma(a, 0), do: a
  def soma(0, b), do: b
  def soma(a, b), do: soma(a - a, a + b)


  # Escreva as funcoes a seguir usando recursividade de cauda. Se precisar,
  # crie funcoes auxiliares que usam um parametro acumulador.

  # Obs: os testes nao vao testar se as funcoes apresentam recursividade
  # de cauda ou nao, apenas se o objetivo da funcao e' cumprido.


  @doc "Multiplica os numeros a e b (b >= 0), usando apenas somas."
  def mult_auxiliar(a, b, acc) do
    if b == 0 do
      acc
    else
      mult_auxiliar(a, b - 1, acc + a)
    end
  end
  def mult(a, b), do: mult_auxiliar(a, b, 0)

  @doc "Obtem o tamanho da lista l."
  def tamanho_acumulador([], a), do: a
  def tamanho_acumulador([_ | t], a), do: tamanho_acumulador(t, a + 1)
  def tamanho(l), do: tamanho_acumulador(l, 0)

  @doc """
  Replica a string s, n vezes.

  Exemplo:
  iex> Ex4.replica("ruby", 4)
  "rubyrubyrubyruby"
  """
  def replica_auxiliar(str, x, acc) do
    if x < 1 do
      acc
    else 
      replica_auxiliar(str, x - 1, acc <> str)
    end
  end

  def replica(str, x) do
    if x == 0 do
      ""
    else 
      replica_auxiliar(str, x, "")
    end
  end

  def replica(str, x) do
    if x == 1 do
      str
    else 
      replica_auxiliar(str, x, "")
    end
  end

  @doc """
  Aplica a funcao f em cada elemento da lista l, retornando uma nova lista
  com os elementos transformados.

  Exemplo:
  iex> Ex4.map([1, 2, 3], fn x -> x * 2 end)
  [2, 4, 6]
  """
  def map_auxiliar([], _, a), do: a
  def map_auxiliar([s | r], pred, a), do: map_auxiliar(r, pred, a ++ [pred.(s)])
  def map(l, pred), do: map_auxiliar(l, pred, [])

  @doc "Calcula a soma dos numeros da lista l."
  def soma_lista_auxiliar([], acc), do: acc
  def soma_lista_auxiliar([s | r], acc), do: soma_lista_auxiliar(r, acc + s)
  def soma_lista(l), do: soma_lista_auxiliar(l, 0) 

  @doc "Calcula o produto dos numeros da lista l."
  def mult_lista_auxiliar([], x), do: x
  def mult_lista_auxiliar([s | r], x), do: mult_lista_auxiliar(r, s * x)
  def mult_lista(l), do: mult_lista_auxiliar(l, 1)

  @doc "Retorna uma string que e' a concatenacao de todas as strings na lista ls."
  def concat_lista_auxiliar([], acc), do: acc
  def concat_lista_auxiliar([s | r], acc), do: concat_lista_auxiliar(r, acc <> s)
  def concat_lista(ls), do: concat_lista_auxiliar(ls, "")

  @doc """
  Retorna uma lista com os elementos da lista l para os quais o predicado p
  returna true.

  Exemplo:
  iex> Ex4.filter([10, 2, 15, 9, 42, 27], fn x -> x > 10 end)
  [15, 42, 27]
  """
  def filter_auxiliar([], _, acc), do: acc
  def filter_auxiliar([s | t], f, acc) do
    if f.(s) do
      filter_auxiliar(t, f, acc ++ [s])
    else 
      filter_auxiliar(t, f, acc)
    end
  end

  def filter([], _), do: []
  def filter(l, f), do: filter_auxiliar(l, f, [])
end
