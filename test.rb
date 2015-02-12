test_hand = [["Ace", "Diamond"], ["Jack", "Club"], ["Queen", "Spade"]]

def show_card(hand)
  cards = []
  hand.map do |card|
    card_string = card.join("-")
    cards.push(card_string)
  end
  cards.join(", ")
end

flatten_cards = show_card(test_hand)
puts flatten_cards
