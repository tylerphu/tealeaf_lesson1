# Create cards
# Assemble deck and shuffle
# Deal 2 cards each to dealer & player
# Calculate cards value
# Determine winner if blackjack
# Prompt player for "hit" or "stay"
# Calculate player cards value after "stay"
# Calculate dealer cards value to determine hit or stay (must hit if below 17)
# Compare card values between dealer & players
# Determine winner
# Prompt to play again?

require 'pry'

def dealing_card(deck, receiver)
  receiver << deck.pop
end

def calculate_points(hand, total_points, got_ace)
  hand.each do |card|
    point = 0
    if card[0] == "Jack" || card[0] == "Queen" || card[0] == "King"
      point += 10
    elsif (2..10).include?(card[0]) && card[0] != "Ace"
      point += card[0]
    end
    total_points += point
  end
  got_ace.call(hand, total_points) 
end

def update_points(hand, current_points, got_ace)
  if hand[-1][0] == "Jack" || hand[-1][0] == "Queen" || hand[-1][0] == "King"
    current_points += 10
  elsif (2..10).include?(hand[-1][0]) && hand[-1][0] != "Ace"
    current_points += hand[-1][0]
  end
  got_ace.call(hand, current_points)
end

got_ace = Proc.new do |hand, total_points|
  hand.each do |card|
    if card[0] == "Ace" && total_points <= 10
      total_points += 11
    elsif card[0] == "Ace" && (total_points > 10 || total_points < 21)
      total_points += 1
    end
  end
  total_points
end

def check_if_blackjack(dealer_points, player_points, winner)
  if dealer_points == 21 && player_points == 21
    puts "Blackjack!"
    winner = "tie"
  elsif dealer_points == 21
    puts "Blackjack!"
    winner = "dealer"
  elsif player_points == 21
    puts "Blackjack!"
    winner = "player"
  else
    return false
  end
end

def check_busted(dealer_points, player_points)
  if dealer_points > 21
    puts "Dealer busted!"
  elsif player_points > 21
    puts "You busted!"
  elsif dealer_points > 21 && player_points > 21
    puts "Both you and dealer busted!"
  end
end

def compare_values(dealer_points, player_points, winner)
  if player_points <= 21 && (dealer_points < player_points || dealer_points > 21)
    winner = "player"
  elsif dealer_points <= 21 && (player_points < dealer_points || player_points > 21)
    winner = "dealer"
  elsif (player_points == dealer_points) || (player_points > 21 && dealer_points > 21)
    winner = "tie"
  end       
end

def show_card(hand)
  cards = []
  hand.map do |card|
    card_string = card.join("-")
    cards.push(card_string)
  end
  cards.join(", ")
end

begin
  suits = ["Heart", "Diamond", "Club", "Spade"]
  cards = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  deck = cards.product(suits).shuffle!
  player_hand = []
  dealer_hand = []
  player_points = 0
  dealer_points = 0
  winner = false
  2.times do 
    dealing_card(deck, dealer_hand)
    dealing_card(deck, player_hand)
  end
  player_points = calculate_points(player_hand, player_points, got_ace)
  dealer_points = calculate_points(dealer_hand, dealer_points, got_ace)
  puts "You have #{player_hand[0][0]}-#{player_hand[0][1]}, #{player_hand[1][0]}-#{player_hand[1][1]} : total points is #{player_points}"
  winner = check_if_blackjack(dealer_points, player_points, winner)
  while winner == false
    begin
      puts "Type 'H' to hit or 'S' to stay:"
      hit_or_stay = gets.chomp.upcase!
      if hit_or_stay == "H"
        dealing_card(deck, player_hand)
        player_points = update_points(player_hand, player_points, got_ace)
        flatten_cards = show_card(player_hand)
        puts "You now have #{flatten_cards} : total points is #{player_points}"
        winner = check_if_blackjack(dealer_points, player_points, winner)
        if player_points > 21
          puts "You busted!"
          winner = true
        end
        break if winner
      end
    end while hit_or_stay == "H"    
    while dealer_points < 17 && player_points <= 21
      dealing_card(deck, dealer_hand)
      dealer_cards = show_card(dealer_hand)
      dealer_points = update_points(dealer_hand, dealer_points, got_ace)
      # puts "Dealer has #{dealer_cards} : total points is #{dealer_points}"
    end
    dealer_cards = show_card(dealer_hand)
    puts "Dealer has #{dealer_cards} : total points is #{dealer_points}"
    # dealer_cards = show_card(dealer_hand)
    puts "Dealer busted!" if dealer_points > 21
    winner = compare_values(dealer_points, player_points, winner)
  end
  
  if winner == "player"
    puts "You won!"
  elsif winner == "dealer"
    puts "Sorry, you lost!"
  elsif winner == "tie"
    puts "It's a tie"
  end
  puts "Play again? (Y/N)"
  repeat = gets.chomp.upcase!
end until repeat != "Y"

