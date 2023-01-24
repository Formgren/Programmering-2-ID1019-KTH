defmodule EnvTree do
  def new() do nil end
  def add(nil, key, value) do {:node, key, value, nil, nil} end
  def add({:node, key,_,left,right},key,value) do
    {:node,key,value,left,right}
  end
end
 