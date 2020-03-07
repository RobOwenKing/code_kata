def match_password(string)
  latest_array = ['']
  iteration_array = []
  new_element = ''
  until new_element == string
    latest_array.each do |element|
      ('a'..'z').each do |letter|
        new_element = element + letter
        iteration_array << new_element
        if new_element == string
          p iteration_array
          return true
        end
      end
    end
    latest_array = iteration_array
    iteration_array = []
  end
end

match_password('q')
match_password('hi')
