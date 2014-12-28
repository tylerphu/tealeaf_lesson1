def validate(num)
  valid = /^-?[0-9]*\.?[0-9]*$/ =~ num
  if valid
    return true
  else
    puts "Your input is not a valid number. Please try again."
    return false
  end
end

begin
  puts "----------- Simple Calculator App ----------"

  begin
    puts "=> Please input the first number:"
    num1 = gets.chomp
  end until validate(num1)

  begin
    puts "=> Please input the second number:"
    num2 = gets.chomp
  end until validate(num2)

  begin
    puts '=> Please enter "1" to Add, "2" to Subtract, "3" to Multiply, "4" to Divide'
    operator = gets.chomp
  end until /[1-4]/ =~ operator

  case operator
  when "1"
    result = num1.to_i + num2.to_i
  when "2"
    result = num1.to_i - num2.to_i
  when "3"
    result = num1.to_i * num2.to_i
  when "4"
    result = num1.to_i / num2.to_i
  end

  puts "=> The result is #{result}"
  puts "=> Do another calculation? (Y/N)"
  repeat = gets.chomp.downcase

end while repeat == "y"
