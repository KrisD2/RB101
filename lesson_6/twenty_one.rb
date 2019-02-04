CARDS = ['Ace', '2', '3', '4', '5', '6', '7',
         '8', '9', '10', 'J', 'Q', 'K']

DECK = ['H', 'D', 'S', 'C'].product(CARDS)

def deal_cards!(deck)
  hand = []
  2.times { hand << deck.delete(deck.sample) }
  hand
end

def card_total(hand)
  total = 0
  hand.each do |card|
    total += if card[1].to_i.to_s == card[1]
               card[1].to_i
             elsif card[1] == 'Ace'
               11
             else
               10
             end
  end

  if total > 21 && hand.flatten.include?('Ace')
    total = calculate_ace_value(hand, total)
  end
  total
end

def calculate_ace_value(hand, total)
  hand.each do |card|
    total -= 10 if card[1] == 'Ace'
    break if total <= 21
  end
  total
end

def read_hand(hand)
  values = hand.map { |card| card[1] }
  if values.size == 2
    values[0..-2].join(' ') + " and #{values[-1]}"
  else
    values[0..-2].join(', ') + ", and #{values[-1]}"
  end
end

def hit!(hand, deck)
  hand << deck.delete(deck.sample)
end

def busted?(hand)
  card_total(hand) > 21
end

def winner(players_hand, dealers_hand)
  if !busted?(players_hand) && busted?(dealers_hand)
    'Player'
  elsif busted?(players_hand)
    'Dealer'
  elsif card_total(players_hand) > card_total(dealers_hand)
    'Player'
  elsif card_total(players_hand) < card_total(dealers_hand)
    'Dealer'
  else
    'Tie'
  end
end

def display_winner(player)
  puts "#{player} has won!" if player == 'Dealer' || player == 'Player'
  puts "It's a tie!" if player == 'Tie'
end

loop do
  deck = DECK

  dealers_hand = deal_cards!(deck)
  players_hand = deal_cards!(deck)

  puts "Dealer has: #{dealers_hand[0][1]} and an unknown card."
  puts "You have: #{read_hand(players_hand)}"

  choice = ''

  loop do
    puts "Hit or stay?"
    choice = gets.chomp.downcase[0]
    players_hand = hit!(players_hand, deck) if choice == 'h'
    puts "You have: #{read_hand(players_hand)}"
    break if busted?(players_hand) || choice == 's'
  end

  play_again = false

  if busted?(players_hand)
    puts "You have busted! Dealer wins. Play again? (Y/N)"
    play_again = true if gets.chomp.downcase[0] == 'y'
  else
    puts "You chose to stay!"
  end

  if choice == 's'
    loop do
      puts "Dealer has: #{read_hand(dealers_hand)}"
      if card_total(dealers_hand) < 17
        hit!(dealers_hand, deck)
      elsif busted?(dealers_hand)
        puts "Dealer busts! Player wins."
        break
      else
        puts "Dealer stays."
        break
      end
    end

    display_winner(winner(players_hand, dealers_hand))
    puts "Play again? (Y/N)"
    play_again = true if gets.chomp.downcase[0] == 'y'
  end

  break unless play_again
end
