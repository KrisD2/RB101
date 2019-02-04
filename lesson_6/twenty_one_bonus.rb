CARDS = ['Ace', '2', '3', '4', '5', '6', '7',
         '8', '9', '10', 'J', 'Q', 'K']

SUIT = ['H', 'D', 'S', 'C']

BUST_LIMIT = 21
DEALER_STAY = 17

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

  if total > BUST_LIMIT && hand.flatten.include?('Ace')
    total = calculate_ace_value(hand, total)
  end
  total
end

def calculate_ace_value(hand, total)
  hand.each do |card|
    total -= 10 if card[1] == 'Ace'
    break if total <= BUST_LIMIT
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
  card_total(hand) > BUST_LIMIT
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

def display_score(player, dealer)
  puts "--- Player wins: #{player} --- Dealer wins: #{dealer} ---"
end

def initialize_deck
  SUIT.product(CARDS)
end

puts "Welcome to Twenty-One. First player to 5 wins the game."

loop do
  dealer_wins = 0
  player_wins = 0

  loop do
    deck = initialize_deck

    dealers_hand = deal_cards!(deck)
    players_hand = deal_cards!(deck)

    puts "Dealer has: #{dealers_hand[0][1]} and an unknown card."
    puts "You have: #{read_hand(players_hand)}"

    choice = ''

    loop do
      puts "Hit or stay?"
      choice = gets.chomp.downcase[0]
      break if choice == 's'
      players_hand = hit!(players_hand, deck) if choice == 'h'
      puts "You have: #{read_hand(players_hand)}"
      break if busted?(players_hand)
    end

    if choice == 's'
      loop do
        puts "Dealer has: #{read_hand(dealers_hand)}"
        if card_total(dealers_hand) < DEALER_STAY
          puts "Dealer hits."
          hit!(dealers_hand, deck)
        elsif busted?(dealers_hand)
          puts "Dealer busts! Player wins."
          break
        else
          puts "Dealer stays."
          break
        end
      end
    end

    display_winner(winner(players_hand, dealers_hand))
    case winner(players_hand, dealers_hand)
    when 'Player'
      player_wins += 1
    when 'Dealer'
      dealer_wins += 1
    end
    display_score(player_wins, dealer_wins)
    break if player_wins == 5 || dealer_wins == 5
  end

  puts "Play again? (Y/N)"
  play_again = false
  play_again = true if gets.chomp.downcase[0] == 'y'
  break unless play_again
end
