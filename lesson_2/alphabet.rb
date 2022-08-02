vowels = Hash.new

i = 0
('а'..'я').each do |letter|    
  i += 1
  if letter =~ /[ауоыиэяюёе]/ 
    vowels[letter] = i
  end  
end 
puts vowels
