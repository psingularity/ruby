puts "Введите данные товара через пробел (название стоимость количество):"

goods = Hash.new

loop do
  good = Hash.new

  input = gets.chomp

  if input != "стоп"

    input_ar = input.split(" ")    
   
    goods[input_ar[0]] = good

    good[:piece_price] = input_ar[1].to_f
    good[:quantity] = input_ar[2].to_f

    good[:good_price] = good[:piece_price] * good[:quantity] 
  
  else
    break
  end

end

price_list = []
total_price = 0

goods.each do |title, data|
  total_price += data[:good_price]
  price_item = "#{title}: #{data.delete(:good_price)}"   
  price_list.push(price_item)  
end

puts "Основной хеш" 
puts goods
puts "Стоимость товара за все единицы" 
puts price_list
puts "Общая стоимость товаров в корзине" 
puts total_price
