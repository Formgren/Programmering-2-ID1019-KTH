defmodule Deriv do

  @type literal() :: {:num, number()} | {:var, atom()}
  @type expr() ::
  literal()
  |   {:add, expr(), expr()}
  |   {:mul, expr(), expr()}
  |   {:exp, expr(), literal()}
  |   {:log, expr()}
  |   {:sin, expr()}
  |   {:cos, expr()}

  def test() do
    e = {:add,
    {:mul, {:num, 2}, {:var, :x}},
    {:log, {:mul, {:num, 3}, {:var, :x}}}}
    d = deriv(e, :x)
    pprint(d)
    IO.write("Expression: #{(pprint(e))}\n")
    IO.write("Derivitive: #{(pprint(d))}\n")
    IO.write("Derivitive simplied: #{(pprint(simplify(d)))}\n")
    :ok
  end

  def test2() do
    e = {:add,
          {:exp, {:var, :x}, {:num, 3}},
          {:num, 4}}

    d = deriv(e, :x)
    pprint(d)
    IO.write("Expression: #{(pprint(e))}\n")
    IO.write("Derivitive: #{(pprint(d))}\n")
    IO.write("Simplied: #{(pprint(simplify(d)))}\n")
    :ok
  end

  def test3() do
    e =
      {:log, {:num, 10}}
    d = deriv(e, :x)
    pprint(d)
    IO.write("Expression: #{(pprint(e))}\n")
    IO.write("simplified Expression: #{(pprint(simplify(e)))}\n")
    IO.write("Derivitive: #{(pprint(d))}\n")
    IO.write("Derivitive simplied: #{(pprint(simplify(d)))}\n")
    :ok
  end
  def test4() do
    e = {:mul, {:cos, {:var, :x}}, {:var, :x}}
    d = deriv(e, :x)
    pprint(d)
    IO.write("Expression: #{(pprint(e))}\n")
    IO.write("Derivitive: #{(pprint(d))}\n")
    IO.write("Derivitive simplied: #{(pprint(simplify(d)))}\n")
  end

  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do 0 end
  def deriv({:add, e1, e2}, v) do {:add, deriv(e1,v), deriv(e2,v)} end
  def deriv({:mul, e1, e2}, v) do
    {:add,
      {:mul, deriv(e1, v), e2},
      {:mul, e1, deriv(e2, v)}}
  end
  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
      deriv(e, v)}
  end
  def deriv({:log, {:num, _}}, _) do
    {:num, 0}
  end
  def deriv({:log, e}, v) do
    {:mul, deriv(e, v), {:exp, e, {:num, -1}}}
  end

  def deriv({:sin, {:num, _}}, _) do {:num, 0} end
  def deriv({:sin, e}, v) do {:mul, {:cos, e}, deriv(e, v)} end

  def deriv({:cos, {:num, _}}, _) do {:num, 0} end
  def deriv({:cos, e}, v) do
    {:mul, {:mul, {:num, -1}, {:sin, e}}, deriv(e, v)}
  end
  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end

  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end

  def simplify(e) do e end


  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end

  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end


  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul({:mul, {:var, v}, {:exp, {:var, v}, {:num, n}}}) do
    ({:exp, {:var, v}, {:num, n+1}}) end
  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:var, v}, {:var, v}) do {:exp, {:var, v}, {:num, 2}} end # Simplified squares (x*x = x^2)
  def simplify_mul(e1, e2) do {:mul, e1, e2} end


  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:x}) do "#{:x}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)})^(#{pprint(e2)})" end
  def pprint({:log, v}) do "ln(#{pprint(v)})" end
  def pprint({:sin, {:var, v}}) do "Sin(#{v})" end
  def pprint({:cos, {:var, v}}) do "Cos(#{v})" end
end
