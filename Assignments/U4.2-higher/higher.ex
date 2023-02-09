defmodule Higher do
  # def double ([]) do [] end
  # def double ([h|t]) do [h * 2|double(t)] end

  # def five([]) do [] end
  # def five([h|t]) do [h + 5|five(t)] end

  # def animal([]) do [] end
  # def animal([:dog|t]) do [:fido | animal(t)] end
  # def animal([h|t]) do [h|animal(t)] end


  # def double_five_animal([h|t], :double) do [h * 2|double_five_animal(t,:double)] end
  # def double_five_animal([h|t], :five) do [h + 5|double_five_animal(t, :five)] end
  # def double_five_animal([h|t], :animal) do end
  # def double_five_animal([], _) do [] end
  # def double_five_animal([h|t], op) do
  #   case op do
  #     :double -> [h * 2|double_five_animal(t,:double)]
  #     :five -> [h + 5|double_five_animal(t, :five)]
  #     :animal ->
  #       case h do
  #       :dog  -> [:fido | double_five_animal(t, :animal)]
  #       _     -> [h|double_five_animal(t, :animal)]
  #     end
  #   end
  # end

  # def apply_to_all([], _) do [] end
  # def apply_to_all([h|t], f) do [f.(h)|apply_to_all(t, f)] end



  def sum([]) do 0 end
  def sum([h|t]) do h + sum(t) end

  def fold_right([], val, _) do val end
  def fold_right([h|t], val, f) do f.(h,fold_right(t,val,f)) end

  def fold_left([], acc, _) do acc end
  def fold_left([h|t], acc, f) do
    fold_left(t,f.(h,acc), f)
  end

  def odd([]) do [] end
  def odd([h|t]) when rem(h,2) == 1 do
    [h|odd(t)]
  end
  def odd([_|t]) do
    odd(t)
  end

  def filter([], _) do [] end
  def filter([h|t], f) do
    if f.(h)
     do
      [h|filter(t, f)]
     else
      filter(t, f)
    end
  end


end
