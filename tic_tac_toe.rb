# 1. Create tic tac toe playboard with 9 cells
# 2. Prompt user input for move
# 3. Place user move to the appropriate cell
# 4. Generate computer move
# 5. Check result to determine winner
# 6. If no winner yet, repeat from step 2
# 7. If there is a winner or all 9 cells are filled, prompt user to play again?

require 'pry'

def board_positions(position)
  8.times { |i| position[i] = " "}
end

def display_board(player_moves, comp_moves, position, available_moves)
  system 'clear'
  player_moves.each do |moves|
    position[moves-1] = "O"
  end
  if available_moves.length != 0
    comp_moves.each do |moves|
    position[moves-1] = "X"
    end
  end
  puts "============Tic Tac Toe============"
  puts "           |           |           "
  puts "           |           |           "
  puts "     #{position[0]}     |     #{position[1]}     |     #{position[2]}      "
  puts "           |           |           "
  puts "           |           |           "
  puts "-----------------------------------"
  puts "           |           |           "
  puts "           |           |           "
  puts "     #{position[3]}     |     #{position[4]}     |     #{position[5]}      "
  puts "           |           |           "
  puts "           |           |           "
  puts "-----------------------------------"
  puts "           |           |           "
  puts "           |           |           "
  puts "     #{position[6]}     |     #{position[7]}     |     #{position[8]}      "
  puts "           |           |           "
  puts "           |           |           "
  puts "==================================="
end


def generate_comp_move(available_moves, comp_moves)
  comp_moves << available_moves.sample
  available_moves.delete(comp_moves[-1])
end

def register_player_move(move, player_moves, available_moves)
  player_moves << move
  available_moves.delete(move)
end

def validate(move, available_moves, player_moves)
  if move < 1 || move > 9
    puts "Invalid move. Please try again."
    return false
  elsif player_moves.length == 0
    register_player_move(move, player_moves, available_moves)
    return true
  elsif available_moves.length <= 8 && available_moves.include?(move) == false
    puts "This position has already been filled. Please try again."
    return false
  else
    register_player_move(move, player_moves, available_moves)
    return true
  end
end

def winner_is(player_moves, comp_moves, winning_positions)
  winning_positions.each do |winning|
    if (winning - player_moves).empty?
      puts "You won!"
      return "Game Over."
    elsif (winning - comp_moves).empty?
      puts "Sorry, you lost!"
      return "Game Over."
    end
  end
end

begin
  position = []
  board_positions(position)
  available_moves = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
  player_moves = []
  comp_moves = []
  winning_positions = [[ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], [ 1, 4, 7 ], [ 2, 5, 8 ], [ 3, 6, 9 ], [ 1, 5, 9 ], [ 3, 5, 7 ]]
  game_over = false
  display_board(player_moves, comp_moves, position, available_moves)
  begin
    begin  
      puts "Choose a position (from 1 to 9) to place a piece:"
      move = gets.chomp.to_i
    end until validate(move, available_moves, player_moves)
    display_board(player_moves, comp_moves, position, available_moves)
    game_over = winner_is(player_moves, comp_moves, winning_positions)
    game_over = "tie game" if available_moves.length == 0
    break if game_over == "Game Over."
    generate_comp_move(available_moves, comp_moves)
    display_board(player_moves, comp_moves, position, available_moves)

    game_over = winner_is(player_moves, comp_moves,winning_positions)
    break if game_over == "Game Over."
    game_over = "tie game" if available_moves.length == 0
 
    #binding.pry
  end until available_moves.length == 0
  puts "It's a tie!" if available_moves.length == 0 && game_over == "tie game"
  puts "Play again? (Y/N)"
  repeat = gets.chomp.downcase
end until repeat != "y"


# begin
#   begin
#     puts "Choose a position (from 1 to 9) to place a piece:"
#     move = gets.chomp.to_i
#     player_moves << move
#     available_moves.delete(move)
#     puts "This position has already been placed. Please try again" while available_moves.length < 8 && available_moves.inclue?(move) == false
#   end until validate(move)

#   comp_move << available_moves.sample
# end while available_moves.length > 0
