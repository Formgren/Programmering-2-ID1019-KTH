defmodule Moves do
  # import Train
  @type move() :: {:atom, integer()}
  @type state() :: {[], [], []}

  def single({:one, n}, {main,one,two}) do
    if n > 0 do
      {_, remaining, take} = Train.main(main, n)
      {remaining, Train.append(take,one), two}
    else
      {Train.append(main,Train.take(one,abs(n))), Train.drop(one,abs(n)), two}
    end
  end
  def single({:two, n}, {main, one, two}) do
    if n > 0 do
      {_ , remaining, take} = Train.main(main,n)
      {remaining, one, Train.append(take,two)}
    else
      {Train.append(main,Train.take(two,abs(n))),one,Train.drop(two,abs(n))}
    end
  end
  def sequence([], trains) do [trains] end
  def sequence([h|t],trains) do
    [trains|sequence(t,single(h,trains))]
  end
end
