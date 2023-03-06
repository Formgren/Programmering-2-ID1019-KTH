defmodule Shunt do
  def find([], []) do [] end
  def find(xs,[y|ys]) do
    {hs,ts} = Train.split(xs,y)
    tn = length(ts)
    hn = length(hs)
    [{:one, tn+1}, {:two, hn}, {:one, -(tn+1)}, {:two, -hn}| find(Train.append(ts, hs), ys)]
  end
  def few([], []) do [] end
  def few([y|xs],[y|ys]) do few(xs,ys) end
  def few(xs,[y|ys]) do
    {hs,ts} = Train.split(xs,y)
    tn = length(ts)
    hn = length(hs)
    [{:one, tn+1}, {:two, hn}, {:one, -(tn+1)}, {:two, -hn}| few(Train.append(ts, hs), ys)]
  end
  def rules([]) do [] end
  def rules([{:one,0}|tail]) do rules(tail) end
  def rules([{:two,0}|tail]) do rules(tail) end
  def rules([{:one,n},{:one,m}|tail]) do rules([{:one,n+m}|tail]) end
  def rules([{:two,n},{:two,m}|tail]) do rules([{:two,n+m}|tail]) end
  def rules([move|tail]) do
    [move|rules(tail)]
  end
  def compress(train) do
    new_train = rules(train)
    if new_train == train
      do train
    else
      rules(new_train)
    end
  end

end
