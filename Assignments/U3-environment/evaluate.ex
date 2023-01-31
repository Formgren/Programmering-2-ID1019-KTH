
defmodule Evaluate do

    @type literal() :: {:num, number()}
    | {:var, atom()}
    | {:q, number(), number()}
    @type expr() :: literal()
    | {:add, expr(), expr()}
    | {:mul, expr(), expr()}
    | {:sub, expr(), expr()}
    | {:div, expr(), expr()}

    def test() do
      expr = {:add, {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 3}}, {:q, 1,2}}
      expr
    end

    def simplify({:add, e1, e2}) do simplify_add(simplify(e1), simplify(e2)) end
    def simplify({:mul, e1, e2}) do simplify_mul(simplify(e1), simplify(e2)) end
    def simplify(e) do e end

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


    # variablerna får ett värde i miljön
    # map biblioteket får användas -  Map.add(:x, 6) etc

    # E för evaluate
    # P för pattern matching
    # Real world serverless sML systems buiild at kth
    # lambda kalkylen
    #
    #
    #
    #
    #
end
