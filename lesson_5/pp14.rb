hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

p (hsh.each_with_object([]) do |(_, v), arr|
  arr << v[:colors].map(&:capitalize) if v[:type] == 'fruit'
  arr << v[:size].upcase if v[:type] == 'vegetable'
end)

