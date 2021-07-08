

for x in 1..100 do
    #puts "The value of x is #{x}"
    y = x % 3
    z = x % 5
    if y == 0 && z == 0
        p "FizzBuzz"
    elsif y == 0
        p "Fizz"
    elsif z == 0
        p "Buzz"
    else 
        p x
    end
end