defmodule Aula4Test do
  use ExUnit.Case
  doctest Aula4

  test "greets the world" do
    assert Aula4.hello() == :world
  end
end
