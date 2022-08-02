puts "0 входит в ряд Фибоначчи? y/n"

answer = gets.chomp

num_0 = 0
num_1 = 1
num_2 = 1

fb_array = []

if answer == "y" 
  fb_array.push(num_0, num_1, num_2)
elsif answer == "n"
  fb_array.push(num_1, num_2)
else 
  puts "Пользователь не дал ответ. 0 не входит в ряд"
  fb_array.push(num_1, num_2)
end

sum = num_1 + num_2

until sum > 100 
  sum = num_1 + num_2
  fb_array.push(sum)
  num_2 = num_1
  num_1 = sum
end

if fb_array.last > 100
  fb_array.delete_at(-1)  
end

puts fb_array

