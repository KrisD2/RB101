flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map!{ |name| name.slice(0, 3) }

p flintstones