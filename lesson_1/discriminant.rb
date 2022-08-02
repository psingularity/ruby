print "Введите значение первого коэффицента (a): "
a = gets.chomp.to_f

print "Введите значение второго коэффицента (b): "
b = gets.chomp.to_f

print "Введите значение третьего коэффицента (с): "
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d < 0
  puts "Дискриминант: #{d}. Корней нет"
elsif d == 0
  root_0 = b/(-2 * a)
  puts "Дискриминант: #{d}. Корень уравнения: #{root_0}"
elsif d > 0
  root_1 = (-b + Math.sqrt(d)) / (2*a)
  root_2 = (-b - Math.sqrt(d)) / (2*a)
  puts "Дискриминант: #{d}. Корни уравнения: #{root_1}, #{root_2}"
end
