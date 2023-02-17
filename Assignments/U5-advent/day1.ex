defmodule Day1 do
  def calories do

  end


  def task1 do
    File.read!("calories.csv")
    |> String.split("\n\n")
    |> Enum.map(& String.split(&1, "\n"))
    |> Enum.map(fn inputs ->
      inputs
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum
    end)
    |> Enum.max()
  end
  def task2 do
    File.read!("calories.csv")
    |> String.split("\n\n")
    |> Enum.map(& String.split(&1, "\n"))
    |> Enum.map(fn inputs ->
      inputs
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

end
