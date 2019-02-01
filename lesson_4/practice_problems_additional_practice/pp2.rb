ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

sum_of_all_ages = 0
ages.each { | key, value| sum_of_all_ages += value }

p sum_of_all_ages