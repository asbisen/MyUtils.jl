

"""
Use Floyd's algorithm to generate random index numbers given
total number of rows

    floydgen(nrows, pct=20)

"""
function floydgen(nrows, pct=20)
  nitems = floor(Int, nrows * (pct/100))

  s = Set{Int}()
  sizehint!(s, nitems)

  for id in (nrows-nitems + 1):nrows
    item = rand(1:id)
    if !(item in s)
      push!(s, item)
    else
      push!(s, id)
    end
  end

  g = Array{Int}(collect(s))
  return g
end
