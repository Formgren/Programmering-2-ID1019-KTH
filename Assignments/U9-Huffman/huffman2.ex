defmodule Huffman2 do
  defmodule Node do
    defstruct [:left,:right]
  end
  defmodule Leaf do
    defstruct [:value]
  end
  def encode(text \\ "cheesecake") do
    frequencies =
      text
      |> String.graphemes()
      |> Enum.reduce(%{}, fn char, map ->
        Map.update(map, char, 1, fn val -> val + 1 end)
      end)
      queue =
        frequencies
      |> Enum.sort_by(fn {_char, frequency} -> frequency end)
      |> Enum.map(fn {value, frequency} -> {%Leaf{value: value}, frequency} end)
        tree = build(queue)
        {tree, convert(text, tree)}

      #tree = build(node_tree)
  end

  defp build([{root, _freq}]) do root end # Exit condition
  defp build(queue) do
    [{node_a, freq_a} | queue] = queue # popping two elements from the queue
    [{node_b, freq_b} | queue] = queue #  popping two elements from the queue

    new_node = %Node{left: node_a, right: node_b}

    total = freq_a + freq_b
    queue = [{new_node, total}]++ queue

    queue
    |> Enum.sort_by(fn {_node, frequency} -> frequency end)
    |> build()
  end

  def find(tree, char, path \\ <<>>)
  def find(%Leaf{value: value}, char, path) do
    case value do
      ^char -> path
      _ -> nil
    end
  end
  def find(%Node{left: left, right: right}, char, path) do
    find(left, char, <<path::bitstring, 0::size(1)>>) ||
    find(right, char, <<path::bitstring, 1::size(1)>>)
  end

  defp convert(text, tree) do
    text
    |> String.graphemes()
    |> Enum.reduce(<<>>, fn character, binary ->
      code = find(tree, character)
      <<binary::bitstring, code::bitstring>>
    end)
  end

  defp walk(binary, %Leaf{value: value}) do {binary, value} end
  defp walk(<<0::size(1), rest::bitstring>>, %Node{left: left}) do walk(rest, left) end
  defp walk(<<1::size(1), rest::bitstring>>, %Node{right: right}) do walk(rest,right) end

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
end
