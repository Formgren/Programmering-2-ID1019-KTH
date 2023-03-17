defmodule Morse do
  @type nodes() :: {:nodes, char(), nodes(), nodes()} | :nil
  def morse() do

    {:nodes, :na,
    {:nodes, 116,
    {:nodes, 109,
    {:nodes, 111,
    {:nodes, :na, {:nodes, 48, nil, nil}, {:nodes, 57, nil, nil}},
    {:nodes, :na, nil, {:nodes, 56, nil, {:nodes, 58, nil, nil}}}},
    {:nodes, 103,
    {:nodes, 113, nil, nil},
    {:nodes, 122,
    {:nodes, :na, {:nodes, 44, nil, nil}, nil},
    {:nodes, 55, nil, nil}}}},
    {:nodes, 110,
    {:nodes, 107, {:nodes, 121, nil, nil}, {:nodes, 99, nil, nil}},
    {:nodes, 100,
    {:nodes, 120, nil, nil},
    {:nodes, 98, nil, {:nodes, 54, {:nodes, 45, nil, nil}, nil}}}}},
    {:nodes, 101,
    {:nodes, 97,
    {:nodes, 119,
    {:nodes, 106,
    {:nodes, 49, {:nodes, 47, nil, nil}, {:nodes, 61, nil, nil}},
    nil},
    {:nodes, 112,
    {:nodes, :na, {:nodes, 37, nil, nil}, {:nodes, 64, nil, nil}},
    nil}},
    {:nodes, 114,
    {:nodes, :na, nil, {:nodes, :na, {:nodes, 46, nil, nil}, nil}},
    {:nodes, 108, nil, nil}}},
    {:nodes, 105,
    {:nodes, 117,
    {:nodes, 32,
    {:nodes, 50, nil, nil},
    {:nodes, :na, nil, {:nodes, 63, nil, nil}}},
    {:nodes, 102, nil, nil}},
    {:nodes, 115,
    {:nodes, 118, {:nodes, 51, nil, nil}, nil},
    {:nodes, 104, {:nodes, 52, nil, nil}, {:nodes, 53, nil, nil}}}}}}
    end




    def convert do convert_to_map(morse(), [], Map.new()) end

    def convert_to_map(nil, _, map) do map end
    def convert_to_map({:nodes, char, nil, nil}, path, map) do
      map = Map.put(map, char, path)
      map
    end
    def convert_to_map({:nodes, :na, long, short}, path, map) do
      Map.merge(convert_to_map(short, path ++ [0], map),
                convert_to_map(long, path ++ [1], map))
    end
    def convert_to_map({:nodes, char, long, short}, path, map) do
      map = Map.put(map, char, path)
      Map.merge(convert_to_map(long, path ++ [1], map),
                convert_to_map(short, path ++ [0], map))
    end

    def do_translate do
     IO.puts("bjorn = ")
     translator('bjorn', convert(), [])
    end

    def translator([], _encode_table, acc) do acc end
    def translator([char|rest], encode_table, acc) do
      code = encode_table[char]
      acc = acc ++ translate_char(code)
      translator(rest, encode_table, acc)
    end

    def translate_char([1|rest]) do [45] ++ translate_char(rest) end
    def translate_char([0|rest]) do [46] ++ translate_char(rest) end
    def translate_char([]) do [32] end


    def do_decode([], _) do [] end
    def do_decode(msg, tree) do
      {char,rest} = decode(msg,tree)
      List.to_string([char | do_decode(rest,tree)])
    end

    def decode([], _) do {46,[]} end
    def decode([h|encoded], {:nodes, char, left, right}) do
      case h do
        ?- ->   decode(encoded, left)
        ?. ->   decode(encoded, right)
        32 ->   {char, encoded}
      end
    end
    def basers do '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... ' end
    def rolled do
      '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- ' end
end
