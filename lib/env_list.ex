defmodule EnvList do

  def new() do
    []
  end
  
  def add([], key, value) do  [{key,value}] end #If the list is empty add the key value pair
  def add([{key,_value}|map], key, value) do [{key,value}|map] end #  match the head of the list to a key value tuple
  def add([item|map], key, value) do [item|add(map,key,value)] end

  def lookup([], _key) do nil end
  def lookup([{key,_}=item|_], key) do item end
  def lookup([_|map], key) do lookup(map, key) end

  def remove([], _key) do [] end
  def remove([{key,_}|map], key) do map end
  def remove([item|map], key) do [item|remove(map,key)] end
end
