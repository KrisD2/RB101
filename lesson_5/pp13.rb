arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

#p arr.sort{ |a, b| [a[0], a[2]] <=> [b[0], b[2]] }

p arr.sort_by{ |subarr| subarr.select { |x| x.odd? } }