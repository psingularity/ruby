print "Введите ваше имя: "
user_name = gets.chomp

print "Введите ваш рост: "
user_height = gets.chomp.to_i

user_weight = (user_height - 110) * 1.15

if user_weight < 0
    puts "Ваш вес уже оптимальный"
else 
    puts "#{user_name}, ваш идеальный вес - #{user_weight}"
end