choices = {"p" => "Paper", "r" => "Rock", "s" => "Scissors" }

def convert(input, choices)
  user_choice = choices[input]
end

def computer_choice(choices)
  selection = ["p", "r", "s"].sample
  comp_choice = choices[selection]
end

def battle(user_choice, comp_choice)
  choices = [user_choice, comp_choice]
  puts "Bam!!! Paper wraps Rock!" if choices.include?("Paper") && choices.include?("Rock")
  puts "Bam!!! Scissors cuts Paper!" if choices.include?("Paper") && choices.include?("Scissors")
  puts "Bam!!! Rock crushes Scissors!" if choices.include?("Rock") && choices.include?("Scissors")
end

def who_win(user_choice, comp_choice)
  if user_choice == comp_choice
    puts "It's a tie!"
  elsif user_choice == "Paper" && comp_choice == "Rock"
    puts "You won!"
  elsif user_choice == "Rock" && comp_choice == "Scissors"
    puts "You won!"
  elsif user_choice == "Scissors" && comp_choice == "Paper"
    puts "You won!"
  else
    puts "Sorry, you lost!"
  end
end 

begin
  puts "----------Play Paper Rock Scissors!----------"

  begin
    puts "Choose one: (P/R/S)"
    input = gets.chomp.downcase
  end until input =~ /[prs]/

  user_choice = convert(input, choices)
  comp_choice = computer_choice(choices)
  puts "You picked #{user_choice} and computer picked #{comp_choice}."
  battle(user_choice, comp_choice)
  who_win(user_choice, comp_choice)
  puts "Play again? (Y/N)"
  repeat = gets.chomp.downcase
end while repeat == "y"