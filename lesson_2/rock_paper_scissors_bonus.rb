VALID_CHOICES = %w(rock paper scissors spock lizard)

MOVES = { rock: %w(scissors lizard),
          paper: %w(rock spock),
          scissors: %w(paper lizard),
          spock: %w(rock scissors),
          lizard: %w(spock paper) }

def prompt(message)
  puts "=> #{message}"
end

def game_result(player, computer)
  return "It's a tie!" if player == computer
  if MOVES[player.to_sym].include? computer
    "You won!"
  else
    "Computer won!"
  end
end

def tally_win(result, current_tally)
  case result
  when 'You won!'
    current_tally[:player] += 1
  when 'Computer won!'
    current_tally[:computer] += 1
  when "It's a tie!"
    current_tally[:ties] += 1
  end
end

def process_player_choice(player)
  return player if VALID_CHOICES.include?(player)
  case player
  when 'r'
    return 'rock'
  when 'p'
    return 'paper'
  when 'sc'
    return 'scissors'
  when 'sp'
    return 'spock'
  when 'l'
    return 'lizard'
  end
end

def wins_reached?(wins)
  wins[:player] == 5 || wins[:computer] == 5
end

def match_result(wins)
  if wins[:player] == 5
    prompt("You won the match!")
  else
    prompt("The computer won the match!")
  end
end

prompt("Welcome to rock, paper, scissors, spock, lizard.
        Win 5 games to win the match.
<------------------------------------------------------------->")

loop do
  wins_total = { player: 0, computer: 0, ties: 0 }
  loop do
    choice = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = process_player_choice(gets.chomp)

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt "You chose: #{choice}; Computer chose: #{computer_choice}"

    current_game_result = game_result(choice, computer_choice)
    tally_win(current_game_result, wins_total)
    prompt current_game_result
    prompt("Current Score---> Player: #{wins_total[:player]}
                     Computer: #{wins_total[:computer]}
                     Ties: #{wins_total[:ties]}")

    break if wins_reached? wins_total
  end
  match_result(wins_total)
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Goodbye!")