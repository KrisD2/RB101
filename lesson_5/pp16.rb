def uuid
  hex = []
  hex << ('0'..'9').to_a << ('a'..'f').to_a
  hex.flatten!
  s1 = hex.sample(8).join
  s2 = hex.sample(4).join
  s3 = hex.sample(4).join
  s4 = hex.sample(4).join
  s5 = hex.sample(12).join
  "#{s1}-#{s2}-#{s3}-#{s4}-#{s5}"
end

p uuid
p uuid
p uuid