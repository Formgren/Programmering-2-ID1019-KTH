defmodule Shunting do
  @typedoc """

  """
  def take(_, 0) do [] end
  def take([h|t], n) do [h|take(t, n-1)] end

  def drop(t, 0) do t end
  def drop([h|t], n) do drop(t,n-1) end

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
end
