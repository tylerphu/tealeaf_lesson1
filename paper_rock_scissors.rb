def convert(input)
  if input == "p"
    user_choice = "Paper"
  elsif input == "r"
    user_choice = "Rock"
  else
    user_choice = "Scissors"
  end
end

def computer_choice
  r = Random.rand(1..3)
  if r == 1
    comp_choice = "Paper"
  elsif r == 2
    comp_choice = "Rock"
  else
    comp_choice = "Scissors"
  end
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

  user_choice = convert(input)
  comp_choice = computer_choice
  puts "You picked #{user_choice} and computer picked #{comp_choice}."
  battle(user_choice, comp_choice)
  who_win(user_choice, comp_choice)
  puts "Play again? (Y/N)"
  repeat = gets.chomp.downcase
end while repeat == "y"