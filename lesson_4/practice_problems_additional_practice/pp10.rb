munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.map do|key, value| 
  value['age_group'] = 'kid' if value['age'] < 18
  value['age_group'] = 'adult' if value['age'] > 18 && value['age'] < 65
  value['age_group'] = 'senior' if value['age'] > 64
end

p munsters