arr = ['10', '11', '9', '7', '8']

sorted_arr = arr.sort { |a, b| b.to_i <=> a.to_i }

p sorted_arr