defmodule Ex3 do
  @moduledoc """
  Exercício 3 da disciplina LPIII - Programação Funcional
  """

  # --- Parte 1: map e seus usos -------------------------------------

  @doc """
  A função map(l, f) aplica a função f a todos os elementos da lista l,
  retornando uma lista com os elementos transformados.

  Exemplo:
  iex> Ex3.map([1, 2, 3, 4, 5], fn x -> x * 2 end)
  [2, 4, 6, 8, 10]
  """
  def map([], _), do: []
  def map([x | r], f), do: [f.(x) | map(r, f)]

  # def dobro_lista(l), do: map(l, fn x -> 2 * x end)

  @doc """
  Dada uma lista de strings, retorna uma lista com o tamanho de cada string.

  Exemplo:
  iex> Ex3.tamanho_strings(["foo", "barbaz", "tapioca"])
  [3, 6, 7]
  """
  # Dica: use a funcao String.length para obter o tamanho de uma string
  def tamanho_strings([]), do: []
  def tamanho_strings([x | r]), do: [String.length(x) | tamanho_strings(r)]

  @doc """
  Dada uma lista de strings contendo apenas dígitos numéricos, retorna uma
  lista com os inteiros correspondentes a cada string.

  Exemplo:
  iex> Ex3.converte_para_inteiros(["42", "54", "999"])
  [42, 54, 999]
  """
  # Dica: use a função String.to_integer para converter cada string
  def converte_para_inteiros([]), do: []
  def converte_para_inteiros([x | r]), do: [String.to_integer(x) | converte_para_inteiros(r)]


  @doc """
  Dada uma lista de números, retorna uma lista com cada número da lista
  original, somado a 100.

  Exemplo:
  iex> Ex3.soma_100_lista([1, 2, 3, 4, 5])
  [101, 102, 103, 104, 105]
  """
  def soma_100_lista([]), do: []
  def soma_100_lista(l), do: map(l, fn x -> x + 100 end)

  # Existem situações em que queremos aplicar um deslocamento a todos os números
  # de uma coleção, por exemplo em aplicações de processamento de sinais ou de
  # análise de dados e machine learning. O próximo exercício é uma generalização
  # do anterior.

  @doc """
  Dada uma lista de números e um valor de deslocamento, retorna uma lista com
  cada número da lista original somado ao deslocamento.

  Exemplo:
  iex> Ex3.soma_n_lista([1, 2, 3, 4, 5], 500)
  [501, 502, 503, 504, 505]
  """
  def soma_n_lista([], _), do: []
  def soma_n_lista([x | r], n), do: [x + n | soma_n_lista(r, n)]

  @doc """
  Dada uma lista de strings, adiciona um prefixo a cada string da lista,
  retornando uma lista com os resultados.

  Exemplo:
  iex> Ex3.adiciona_prefixo(["fazer", "tornar", "bater"], "re")
  ["refazer", "retornar", "rebater"]
  """
  def adiciona_prefixo([], _), do: []
  def adiciona_prefixo([x | r], pre), do: [pre <> x | adiciona_prefixo(r, pre)]

  @doc """
  Dada uma lista de strings, adiciona um sufixo a cada string da lista,
  retornando uma lista com os resultados.

  Exemplo:
  iex> Ex3.adiciona_sufixo(["geo", "bio", "crono"], "logia")
  ["geologia", "biologia", "cronologia"]
  """
  def adiciona_sufixo([], _), do: []
  def adiciona_sufixo([x | r], sufixo), do: [x <> sufixo | adiciona_sufixo(r, sufixo)]


  # --- Parte 2: Reduções (fold_left, fold_right) --------------------

  @doc """
  fold_right(l, ini, f) reduz os elementos da lista l de acordo com a
  função f, tendo ini como valor inicial. As operações devem ser agrupadas
  à direita.

  Exemplo:
  iex> Ex3.fold_right([1, 2, 3, 4], 0, fn (x, s) -> x + s end)
  10
  """
  def fold_right([], ini, _), do: ini
  def fold_right([x | r], ini, f), do: f.(x, fold_right(r, ini, f))

  @doc """
  Dada uma lista de strings, retorna uma string que é a concatenação de todas
  as strings na lista.

  Exemplo:
  iex> Ex3.concatena_strings(["foo", "bar", "baz"])
  "foobarbaz"
  """
  def concatena_strings([]), do: ""
  def concatena_strings([x | r]), do: x <> concatena_strings(r)

  @doc """
  Dada uma lista de valores booleanos, calcula o AND (E-lógico) de todos os
  valores.

  Exemplo:
  iex> Ex3.and_lista([true, false, true])
  false
  """
  def and_lista([]), do: true
  def and_lista([x | r]) do
    if x == true do
      and_lista(r)
    else
      false
    end
  end


  @doc """
  Dada uma lista de valores booleanos, calcula o OR (OU-lógico) de todos os
  valores.

  Exemplo:
  iex> Ex3.or_lista([true, false, true])
  true
  """
  def or_lista([]), do: false
  def or_lista([x | r]) do
    if x == false do
      and_lista(r)
    else
      true
    end
  end

  # fold-right sempre associa a operação f à direita, e isso pode ser
  # inadequado em muitos casos. Usando o modelo de substituição, podemos
  # ver que a chamada fold_right([1, 2, 3], val, f) terá o valor de
  # f(1, f(2, f(3, val)))
  #
  # Em operadores associativos como adição e multiplicação isso não é problema,
  # mas muitas vezes precisamos associar à esquerda mesmo. Um exemplo é na
  # subtração.
  #
  # Considere uma aplicação para controlar a pontuação de pessoas fazendo uma prova
  # de avaliação de habilidade em que cada um começa com o máximo de pontos, e
  # a cada erro vai causando deduções (similar ao formato de prova prática para
  # carteira de habilitação para dirigir veículos em muitos lugares). O avaliador
  # preenche uma lista com as deduções, e a pontuação inicial é fixa.
  #
  # Suponha que a pontuação inicial seja de 1000 pontos e o avaliador anotou, para
  # uma pessoa, as deduções 10, 20 e 40. O resultado esperado é calculado facilmente:
  # primeiro subtrai-se 10 de 1000, resultando em 990; disto, tiramos 20, chegando a
  # 970, e finalmente subtrai-se mais 40, tendo como resultado final 930.
  #
  # Se tentarmos calcular isso usando
  # fold_right([10, 20, 40], 1000, fn (x, r) -> x - r end), o resultado
  # será dado por (10 - (20 - (40 - 1000))), com resultado -970, claramente errado.
  #
  # Nesse caso é necessário calcular (((1000 - 10) - 20) - 40).
  # Em termos mais gerais,
  # dado a operação f e o valor inicial val precisamos calcular, \
  # para a lista [1, 2, 3], o valor
  # f(f(f(val, 1), 2), 3).
  # Isso é o que faz a função fold_left.

  @doc """
  fold_left(l, ini, f) reduz os elementos da lista l de acordo com a
  função f, tendo ini como valor inicial. As operações devem ser agrupadas
  à esquerda.

  Exemplo:
  iex> Ex3.fold_left([10, 20, 40], 1000, fn (r, x) -> r - x end)
  930
  """
  def fold_left([], ini, _), do: ini
  def fold_left([x | r], ini, f), do: fold_left(r, f.(ini, x), f)

  @doc """
  Dada uma pontuação inicial e uma lista de deduções, calcula a pontuação
  final.

  Exemplo:
  iex> Ex3.pontuacao_final(1000, [30, 40, 15])
  915
  """
  def pontuacao_final(ini, []), do: ini
  def pontuacao_final(ini, [x | r]) do
    result = ini - x
    pontuacao_final(result, r)
  end


  @doc """
  Dada uma lista de listas, concatena todas as listas e retorna o resultado.

  Exemplo:
  iex> Ex3.concatena_listas([[1, 2], [3, 4], [7, 8, 9]])
  [1, 2, 3, 4, 7, 8, 9]
  """
  def concatena_listas([]), do: []
  def concatena_listas([[], []]), do: []
  def concatena_listas([x | r]), do: x ++ concatena_listas(r)

  # Dica: o operador ++ concatena duas listas

  # Opcional: a funcao concatena_listas é mais eficiente se implementada com
  # fold_right ou fold_left? Se quiser, faça experimentos para medir o tempo
  # e descobrir experimentalmente qual das duas é mais rápida.
  # Considerando como a concatenação de duas listas é implementada, é possível
  # descobrir qual é mais eficiente sem precisar comparar as implementações.
  # Mesmo assim, uma comprovação experimental é interessante.


  @doc """
  Dada uma lista de strings e um separador (também string), retorna a
  concatenação das strings da lista, separados pelo separador.

  Exemplo:
  iex> Ex3.concat_strings_sep(["tapioca", "cuscuz", "queijo"], ", ")
  "tapioca, cuscuz, queijo"
  """
  def concat_strings_sep([], _), do: ""
  def concat_strings_sep([x | r], sep), do: x <> sep <> concat_strings_sep(r, sep)

  # --- Parte 3: Filtragem -------------------------------------------

  @doc """
  A função filter(l, pred) retorna apenas os elementos da lista l para
  os quais o predicado pred retorna true.

  Exemplo:
  iex> Ex3.filter([1, 22, 3, 7, 16], fn n -> n > 10 end)
  [22, 16]
  """
  def filter([], _), do: []
  def filter([x | r], pred) do
    if pred.(x) do
      [x | filter(r, pred)]
    else
      filter(r, pred)
    end
  end

  @doc """
  strings_que_contem(ls, meio) retorna apenas as strings da lista ls que contem
  a string meio entre seus caracteres.

  Exemplo:
  iex> Ex3.strings_que_contem(["foo", "euforia", "bar", "Moria", "tapioca"], "oria")
  ["euforia", "Moria"]
  """
  def strings_que_contem([], _), do: []
  def strings_que_contem([x | r], meio) do
    if String.contains? x, meio do
      [x | strings_que_contem(r, meio)]
    else
      strings_que_contem(r, meio)
    end
  end
  # Dica: use a função String.contains? para decidir se uma string contem outra

  @doc """
  Dada uma lista de números, retorna os números n tais que, quando multiplicados
  por 3 e somados a 1, resultam em um número par.

  Exemplo:
  iex> Ex3.par_3n_mais_1([1, 2, 3, 4, 5])
  [1, 3, 5]
  """
  def par_3n_mais_1([]), do: []
  def par_3n_mais_1([x | r]) do
    result = (x * 3) + 1
    if rem(result, 2) == 0 do
      [x | par_3n_mais_1(r)]
    else
      par_3n_mais_1(r)
    end
  end
end
