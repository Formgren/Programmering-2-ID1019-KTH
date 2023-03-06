defmodule Train do
  def take(_, 0) do [] end
  def take([h|t], n) do [h|take(t, n-1)] end

  def drop(t, 0) do t end
  def drop([_|t], n) do drop(t,n-1) end

  def append(train1, train2) do
    train1 ++ train2
  end
  def member([], _) do false end
  def member([h|t], wagon) do
    if h == wagon do
      true
    else
      false
      member(t, wagon)
    end
  end
  def position([y|_], y) do 1 end
  def position([_|t], y) do
    position(t, y) + 1
  end

  def split([y|t], y) do {[],t} end
  def split([h|t], y) do
      {t,drop} = split(t,y)
      {[h|t], drop}
  end

  # ([:a,:b,:c], 2)
  def main([], n) do {n, [], []}  end
  def main([h|t], n) do
    case main(t, n) do
      {0, drop, take} ->
        {0, [h|drop], take}
      {n, drop, take} ->
        {n-1, drop, [h|take]}
    end
  end
end

# split(train, y) return a tuple with two trains,
# all the wagons before y and all wagons after y
# (i.e. y is not part in either).
# For example:
# split([:a,:b,:c],:a) = {[],[:b,:c]}
# split([:a,:b,:c],:b) = {[:a],[:c]}
