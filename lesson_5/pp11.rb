arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

p arr.map{ |x| x.select { |y| y % 3 == 0 } }