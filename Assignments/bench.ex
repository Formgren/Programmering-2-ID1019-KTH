defmodule Bench do
  def map(i, n) do
    seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)

    list = Enum.reduce(seq, EnvTree.new, fn(e, list) ->
        EnvTree.add(list, e, :foo) end)

    seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)

    {:add, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvList.add(list, e, :foo) end) end)

  end
end
