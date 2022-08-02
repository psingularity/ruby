print "Введите основание треугольника: "
base_triangle = gets.chomp.to_f

print "Введите высоту треугольника: "
height_triangle = gets.chomp.to_f

area_triangle = (base_triangle * height_triangle) / 2

puts "Площадь треугольника: #{area_triangle}"