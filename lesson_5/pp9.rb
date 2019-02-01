arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

p (arr.map do |subarr|
    subarr.sort { |a, b| b <=> a }
end)


