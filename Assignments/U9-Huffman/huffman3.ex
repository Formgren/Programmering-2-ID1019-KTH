defmodule Huffman3 do

  defmodule Node do
    defstruct [:left,:right]
  end

  defmodule Leaf do
    defstruct [:value]
  end

  def encode(text \\ 'cheesecake') do
    frequencies =
      text
      |> to_atom_list()
      |> Enum.reduce(%{}, fn char, map ->
        Map.update(map, char, 1, fn val -> val + 1 end)
      end)

      queue =
        frequencies
      |> Enum.sort_by(fn {_char, frequency} -> frequency end)
      |> Enum.map(fn {value, frequency} ->
          {%Leaf{value: value}, frequency}
        end)
        tree = huffman_tree(queue)

        convert(text, tree)
  end

  defp huffman_tree([{root, _freq}]) do root end # Exit condition
  defp huffman_tree(queue) do
    [{node_a, freq_a} | queue] = queue # popping two elements from the queue
    [{node_b, freq_b} | queue] = queue #  popping two elements from the queue

    new_node = %Node{left: node_a, right: node_b}

    total = freq_a + freq_b
    queue = [{new_node, total}] ++ queue

    queue
    |> Enum.sort_by(fn {_node, frequency} -> frequency end)
    |> huffman_tree()
  end

  def find(tree, char, path \\ [])
  def find(%Leaf{value: value}, char, path) do
    case value do
      ^char -> {char, Enum.reverse(path)}
      _ -> nil
    end
  end
  def find(%Node{left: left, right: right}, char, path) do
    find(left, char, [0|path]) ||
    find(right, char, [1|path])
  end

  defp convert(sample, tree) do
   sample = to_atom_list(sample)
   map = Enum.map(sample, fn char -> find(tree,char) end)
   Enum.reverse(map)
  end
  
  defp walk(binary, %Leaf{value: value}) do {binary, value} end
  defp walk([0|rest], %Node{left: left}) do walk(rest, left) end
  defp walk([1|rest], %Node{right: right}) do walk(rest,right) end

  def decode(tree, data, result \\ [])

  def decode(_tree, <<>>, result) do result end
  def decode(tree, data, result) do
    {rest, value} = walk(data, tree)
    decode(tree,rest,result ++ [value])
  end

  def read(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, :all)
    File.close(file)
    case :unicode.characters_to_binary(binary, :utf8) do
    {:incomplete, list, _} -> list
    list -> list
    end
  end

  def to_atom_list(sample, acc \\ [])
  def to_atom_list([], acc) do acc end
  def to_atom_list([char | rest], acc) do
    to_atom_list(rest, [List.to_string([char])| acc])
  end
end
