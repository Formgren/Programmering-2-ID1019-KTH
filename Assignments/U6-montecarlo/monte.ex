defmodule Monte do
  def dart(r) do
    x = :rand.uniform(r)
    y = :rand.uniform(r)
    if :math.pow(r,2) > (:math.pow(x,2) + :math.pow(y,2))
      do true else false end
  end

  def round(0,_,hits) do hits end
  def round(n,r,hits) do
    if dart(r)
    do
      round(n-1, r, hits+1)
    else
      round(n-1, r, hits)
    end
  end

  def rounds(k,r) do
    a = round(1000,r,0)
    rounds(k,1000,r,a)
  end

  def rounds(0,n,_,a) do 4*a/n end
  def rounds(k,n,r,a) do
    a = round(n,r,a)
    n = n*2
    pi = 4*a/n
    :io.format(" n = ~12w, pi = ~14.10f,  dp = ~14.10f, da = ~8.4f,  dz = ~12.8f\n", [n, pi,  (pi - :math.pi()), (pi - 22/7), (pi - 355/113)])

    rounds(k-1,n,r,a)

  end
  def liebniz do
    4 * Enum.reduce(0..10000000, 0,
    fn(k,a) -> a + 1/(4*k + 1) - 1/(4*k + 3) end)
  end
end
