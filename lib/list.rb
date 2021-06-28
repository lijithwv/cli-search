class List 
  def self.fields key_data
    key_data.keys.each do |key_item|
      puts "Searchable fields for #{key_item.to_s.capitalize}".light_blue
      puts key_data[key_item]
      puts "-----------------------------\n"
    end
  end
end