flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones = flintstones.each.with_object({}) do | ele, obj |
  obj[ele] = flintstones.index(ele)
end

p flintstones