require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
CURRENT_PLAYER = 'Choose'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, pwins, cwins, tie)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "First player to 5 wins the match"
  puts "Player: #{pwins}    Computer: #{cwins}    Ties:#{tie}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def joinor(arr, delimit = ', ', joining_word = 'or')
  if arr.size == 1
    arr.join
  elsif arr.size == 2
    arr.join(" #{joining_word} ")
  elsif arr.size > 2
    arr[0..-2].join(delimit) + "#{delimit}#{joining_word} " + arr[-1].to_s
  else
    nil
  end
end

def intialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1 
      return line[brd.values_at(*line).index(INITIAL_MARKER)]
    end
  end
  nil
end

def find_winning_square(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1 
      return line[brd.values_at(*line).index(INITIAL_MARKER)]
    end
  end
  nil
end

def computer_places_piece!(brd)
    if !!find_winning_square(brd)
      square = find_winning_square(brd)
    elsif !!find_at_risk_square(brd)
      square = find_at_risk_square(brd)
    elsif brd[5] == INITIAL_MARKER
      square = 5
    else
      square = empty_squares(brd).sample
    end
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, crrnt_plyr)
  if crrnt_plyr == 'Computer'
    computer_places_piece!(brd)
  else
    player_places_piece!(brd)
  end
end

def alternate_player(crrnt_plyr)
  if crrnt_plyr == 'Computer'
    'Player'
  else
    'Computer'
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

loop do

  computer_wins = 0
  player_wins = 0
  ties = 0

  loop do
    board = intialize_board
    if CURRENT_PLAYER == 'Choose'
      prompt "Should the computer or player make the first move? (C/P)"
      input = ''
      loop do
        input = gets.chomp.downcase[0]
        break if input == 'c' || input == 'p'
      end
      input == 'p' ? (CURRENT_PLAYER = 'Player') : (CURRENT_PLAYER = 'Computer')    
    end

    current_player = CURRENT_PLAYER

    loop do
      display_board(board, player_wins, computer_wins, ties)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
#      player_places_piece!(board)
#      break if someone_won?(board) || board_full?(board)

#      computer_places_piece!(board)
#      break if someone_won?(board) || board_full?(board)
    end

    if someone_won?(board)
      player_wins += 1 if detect_winner(board) == 'Player'
      computer_wins += 1 if detect_winner(board) == 'Computer'
      display_board(board, player_wins, computer_wins, ties)
      prompt "#{detect_winner(board)} has won."
    else
      ties += 1
      display_board(board, player_wins, computer_wins, ties)
      prompt "It's a tie."
    end

    prompt "Press enter to start the next game."
    gets

    if player_wins == 5 || computer_wins == 5
      display_board(board, player_wins, computer_wins, ties)
      prompt "#{detect_winner(board)} has won the game!"
      break
    end

  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')

end

prompt "Thanks for playing Tic Tac Toe. Goodbye."