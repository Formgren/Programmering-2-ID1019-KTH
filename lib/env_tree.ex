defmodule EnvTree do
  def new() do nil end
  def add(nil, key, value) do {:node, key, value, nil, nil} end
  def add({:node, key,_, left, right}, key, value) do
    {:node, key, value, left, right}
  end
  def add({:node, k, v, left, right}, key, value) when key < k do
    {:node, k, v, add(left, key, value), right}
  end
  def add({:node, k, v, left, right}, key, value) do
    {:node, k, v, left, add(right, key, value)} end

  def member(:nil, _key) do :error end
  def member({:node, key, value, _left, _right }, key) do {key,value} end
  def member({:node, k, _v, left, _right}, key) when key < k do member(left, key) end
  def member({:node, _k, _v, _left, right}, key) do member(right, key) end


end
