defmodule Vector do
  defmodule Ray do
    defstruct( pos: {0, 0, 0}, dir: {0,0,1})
  end
  
  defprotocol Object do
    def intersect(object, ray)
  end



  defmodule Sphere do

  end
  defmodule Object do

  end
  def scalar_mul({x1,x2,x3},s) do
    {x1*s, x2*s, x3*s}
  end
  def add({x1,x2,x3}, {y1,y2,y3}) do
    {x1+y1, x2+y2, x3+y3}
  end
  def sub({x1,x2,x3}, {y1,y2,y3}) do
    {x1-y1, x2-y2, x3-y3}
  end
  def normalize (x) do
    n = norm(x)
    scalar_mul(x, 1 / n)

  end
  def norm({x,y,z}) do
    :math.sqrt((x*x)+(y*y)+(z*z))
  end
  def dot({x1,y1,z1},{x2,y2,z2}) do
    x1*x2 + y1*y2 + z1*z2
  end
end
