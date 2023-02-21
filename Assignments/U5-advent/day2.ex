defmodule Day2 do
  def task1 do
    File.read!("day2Input.csv")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(&score_round(&1))
    |> Enum.sum()
  end
  defp score_round(["A","Z"]) do 3 end
  defp score_round(["A","Y"]) do 8 end
  defp score_round(["A","X"]) do 4 end
  defp score_round(["B","Z"]) do 9 end
  defp score_round(["B","Y"]) do 5 end
  defp score_round(["B","X"]) do 1 end
  defp score_round(["C","Z"]) do 6 end
  defp score_round(["C","Y"]) do 2 end
  defp score_round(["C","X"]) do 7 end

  def task2 do
    File.read!("day2Input.csv")
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(&score_round(&1))
    |> Enum.sum()
  end
  defp score_round(["A","Z"]) do 9 end
  defp score_round(["A","Y"]) do 4 end
  defp score_round(["A","X"]) do 3 end
  defp score_round(["B","Z"]) do 9 end
  defp score_round(["B","Y"]) do 5 end
  defp score_round(["B","X"]) do 1 end
  defp score_round(["C","Z"]) do 6 end
  defp score_round(["C","Y"]) do 2 end
  defp score_round(["C","X"]) do 7 end

  end
end
