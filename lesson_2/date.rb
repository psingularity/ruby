print "Введите день (от 1 до 31): " 

day = gets.chomp.to_i

print "Введите номер месяца (от 1 до 12): " 
month = gets.chomp.to_i

print "Введите год (например 1888): " 
year = gets.chomp.to_i

#check year (used - https://docs.microsoft.com/ru-ru/office/troubleshoot/excel/determine-a-leap-year)

if year % 4 == 0   
  if year % 100 == 0
    if year % 400 == 0
      puts "Год високосный (366 дней)"
      days_feb = 29
    else
      puts "Год невисокосный (365 дней)"
      days_feb = 28
    end
  else
    puts "Год високосный (366 дней)"
    days_feb = 29
  end 
else
  puts "Год невисокосный (365 дней)"
  days_feb = 28
end

months = [31, days_feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

days = months.take(month - 1).sum + day

puts days

