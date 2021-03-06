# 1. Create tic tac toe playboard with 9 cells
# 2. Prompt player for input
# 3. Place player position to the appropriate cell
# 4. Generate computer position
# 5. Check result to determine winner
# 6. If no winner or tie, repeat from step 2
# 7. Announce result if there is a winner or all 9 cells have been filled (tie)
# 8. Prompt player to play again

def create_empty_board(position)
  9.times { |i| position[i] = " "}
end

def display_board(player_positions, comp_positions, board_position, available_positions)
  system 'clear'
  player_positions.each do |pos|
    board_position[pos-1] = "O"
  end
  if available_positions.length != 0
    comp_positions.each do |pos|
    board_position[pos-1] = "X"
    end
  end
  puts "============Tic Tac Toe============"
  puts "           |           |           "
  puts "           |           |           "
  puts "     #{board_position[0]}     |     #{board_position[1]}     |     #{board_position[2]}      "
  puts "           |           |           "
  puts "           |           |           "
  puts "-----------------------------------"
  puts "           |           |           "
  puts "           |           |           "
  puts "     #{board_position[3]}     |     #{board_position[4]}     |     #{board_position[5]}      "
  puts "           |           |           "
  puts "           |           |           "
  puts "-----------------------------------"
  puts "           |           |           "
  puts "           |           |           "
  puts "     #{board_position[6]}     |     #{board_position[7]}     |     #{board_position[8]}      "
  puts "           |           |           "
  puts "           |           |           "
  puts "==================================="
end


def generate_comp_position(available_positions, comp_positions)
  comp_positions << available_positions.sample
  available_positions.delete(comp_positions[-1])
end

def register_player_position(new_position, player_positions, available_positions)
  player_positions << new_position
  available_positions.delete(new_position)
end

def validate_player_input(new_position, available_positions, player_positions)
  if (1..9).include?(new_position) == false 
    puts "Invalid position. Please try again."
    return false
  elsif player_positions.length == 0
    register_player_position(new_position, player_positions, available_positions)
    return true
  elsif available_positions.length <= 8 && available_positions.include?(new_position) == false
    puts "This position has already been filled. Please try again."
    return false
  else
    register_player_position(new_position, player_positions, available_positions)
    return true
  end
end

def check_winner(player_positions, comp_positions, winning_positions)
  winning_positions.each do |winning|
    if (winning - player_positions).empty?
      return "You won!"
    elsif (winning - comp_positions).empty?
      return "Computer won!"
    end
  end
  return false
end

def announce_result(winner)
  puts winner if winner == "You won!" || winner == "Computer won!"
  puts "It's a tie!" if winner == false
end  

begin
  board_position = []
  create_empty_board(board_position)
  available_positions = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
  player_positions = []
  comp_positions = []
  winning_positions = [[ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], [ 1, 4, 7 ], [ 2, 5, 8 ], [ 3, 6, 9 ], [ 1, 5, 9 ], [ 3, 5, 7 ]]
  winner = false
  display_board(player_positions, comp_positions, board_position, available_positions)
  begin
    begin  
      puts "Choose a position (from 1 to 9) to place a piece:"
      new_position = gets.chomp.to_i
    end until validate_player_input(new_position, available_positions, player_positions)
    display_board(player_positions, comp_positions, board_position, available_positions)
    winner = check_winner(player_positions, comp_positions, winning_positions)
    break if winner   
    generate_comp_position(available_positions, comp_positions)
    display_board(player_positions, comp_positions, board_position, available_positions)
    winner = check_winner(player_positions, comp_positions,winning_positions)
    break if winner
  end until available_positions.length == 0
  announce_result(winner) 
  puts "Play again? (Y/N)"
  repeat = gets.chomp.downcase
end until repeat != "y"
