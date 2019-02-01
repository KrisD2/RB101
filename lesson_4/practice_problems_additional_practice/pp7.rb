statement = "The Flintstones Rock"

letter_frequency = Hash.new(0)

statement.gsub(" ", "").split("").each { |letter| letter_frequency[letter] +=1 }

p letter_frequency