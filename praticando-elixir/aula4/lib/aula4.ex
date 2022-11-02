defmodule Aula4 do
  def map([], _), do: []
  def map([x | r], f), do: [f.(x) | map(r, f)]

  def dobro_lista(l), do: map(l, fn x -> 2 * x end)

  def quadrado_lista(l), do: map(l, fn x -> x * x end)

  def reduce([], ini, _), do: ini
  def reduce([x | r], ini, f), do: f.(x, reduce(r, ini, f))

  def soma_lista(l), do: reduce(l, 0, fn x, y -> x + y end)

  def mult_lista(l), do: reduce(l, 1, fn x, y -> x * y end)

  def reduce_left([], val, _), do: val
  def reduce_left([x | r], val, f), do: reduce_left(r, f.(val, x), f)

  def filter([], _), do: []
  def filter([x | r], pred) do
    if pred.(x) do
      [x | filter(r, pred)]
    else
      filter(r, pred)
    end
  end

  def positivos_lista(l), do: filter(l, fn x -> x > 0 end)

  def combina_listas([], _, _), do: []
  def combina_listas(_, [], _), do: []
  def combina_listas([x1 | r1], [x2 | r2], f), do: [f.(x1, x2) | combina_listas(r1, r2, f)]

  def soma_listas(l1, l2), do: combina_listas(l1, l2, fn x, y -> x + y end)
end
