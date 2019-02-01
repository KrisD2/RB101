p ([{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  hsh.each{ |key, _| hsh[key] += 1 }
end)

#bad practice - mutating and iterating 