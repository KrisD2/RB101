hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], 
       third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each_value do |v|
  v.each { |str| puts str.gsub(/[^aeiou]/i, '') }
end