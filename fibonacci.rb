def fibs(number)
  fibonacci_numbers = []
  num1 = 0
  num2 = 1
  number.times do |n|
    fibonacci_numbers << num1 if n.zero?
    fibonacci_numbers << num2 if n == 1
    fibonacci_numbers << fibonacci_numbers[n - 1] + fibonacci_numbers[n - 2] if n > 1
  end
  p fibonacci_numbers
end

fibs(10)

def fibs_rec(number)
  if number == 1
    0
  elsif number == 2
    1
  else
    fibs_rec(number - 1) + fibs_rec(number - 2)
  end
end


puts fibs_rec(10)