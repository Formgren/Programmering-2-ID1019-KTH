defmodule Huffman2 do

  defmodule Node do
    defstruct [:left,:right]
  end

  defmodule Leaf do
    defstruct [:value]
  end

  # def test(text \\ "cheeeeeeeesssseeeecaaake") do
  #   text = read("kallocain.txt")
  #   encode = encode(text)
  #   {tree, encoded} = encode
  #   decoded = decode(tree,encoded)
  # end

  def encode(text \\ "cheesecake") do
    frequencies =
      text
      |> String.graphemes()
      |> Enum.reduce(%{}, fn key, map ->
        Map.update(map, key, 1, fn val -> val + 1 end)
      end)
      queue =
        frequencies
      |> Enum.sort_by(fn {_char, frequency} -> frequency end)
      |> Enum.map(fn {value, frequency} -> {%Leaf{value: value}, frequency} end)
      tree = build(queue)
      {tree, convert(text, tree)}

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
  def decode(_tree, <<>>, result) do List.to_string(result) end
  def decode(tree, data, result) do
    {rest, value} = walk(data, tree)
    decode(tree,rest,result ++ [value])
  end

  def bench(file,n) do
    text = read(file)
    length_kallocain = String.length(read("kallocain.txt"))
    c = String.length(text)
    # c = length(text)
    {{tree,encoded}, t2} = time(fn -> encode(text) end)


    {string, t3} = time(fn -> decode(tree,encoded) end)

    IO.puts("length of kallocain #{length_kallocain} characters")
    IO.puts("text of #{c} characters")
    IO.puts("text encoded in #{t2} ms")
    IO.puts("text decoded in #{t3} ms")
    # IO.puts("encoded in #{t5} ms")
    # IO.puts("decoded in #{t6} ms")
    # IO.puts("source #{b} bytes, encoded #{e} bytes, compression #{r}")
  end

  def time(func) do
    initial = Time.utc_now()
    result = func.()
    final = Time.utc_now()2
    {result, Time.diff(final, initial, :microsecond) / 1000}
  end

 # Get a suitable chunk of text to encode.
  # def read(file, n) do
  #  {:ok, fd} = File.open(file, [:read, :utf8])
  #   binary = IO.read(fd, n)
  #   File.close(fd)

  #   length = byte_size(binary)
  #   case :unicode.characters_to_list(binary, :utf8) do
  #     {:incomplete, chars, rest} ->
  #       {chars, length - byte_size(rest)}
  #     chars ->
  #       {chars, length}
  #   end
  # end
  def read(file) do
    binary = File.read!(file)
    # :unicode.characters_to_list(binary, :utf8)
  end


  # def read(file) do
  #   {:ok, file} = File.open(file, [:read, :utf8])
  #   binary = IO.read(file, :all)
  #   File.close(file)
  #   case :unicode.characters_to_binary(binary, :utf8) do
  #   {:incomplete, list, _} -> list
  #   list -> list
  #   end
  # end
end
