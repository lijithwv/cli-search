class Result
  def self.display result_data
    unless result_data.empty?
      puts "#{result_data.count} result(s) returned:".green
      ap result_data, options = {indent: -2, index: false}
    else
      puts "Your search returned no results".red
    end
  end
end