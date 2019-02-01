flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.index{ |ele| ele[0] == 'B' && ele[1] == 'e' }