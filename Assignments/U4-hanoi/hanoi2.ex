defmodule Hanoi do
  def solve(n, from, to, auxiliary) when n > 0 do
    solve(n - 1, from, auxiliary, to)
    IO.puts("Move disk from #{from} to #{to}")
    solve(n - 1, auxiliary, to, from)
  end

  def solve(_, _, _, _), do: nil
end
