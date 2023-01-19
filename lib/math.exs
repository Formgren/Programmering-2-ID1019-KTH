defmodule Math do
  def sum(a,b) do
    a + b
  end

  # naming convention for boolean returns uses ?
  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end
end

IO.puts Math.sum(1,2)
IO.puts Math.sum(10,12)
IO.puts Math.zero?(3)
