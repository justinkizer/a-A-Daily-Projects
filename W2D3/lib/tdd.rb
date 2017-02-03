def my_uniq(array)
  raise "Array input required." unless array.is_a?(Array)
  result = []
  array.each do |el|
    result << el unless result.include?(el)
  end
  result
end

def two_sum(array)
  raise "Array input required." unless array.is_a?(Array)

  result = []
  array.each_index do |i|
    array.each_index do |j|
      result << [i, j] if array[i] + array[j] == 0 && i != j && !result.include?([j, i])
    end
  end

  result
end

def my_transpose(array)
  raise "Array input required." unless array.is_a?(Array)
  result = []
  array.each_index do |i|
    running_total = []
    array.each_index do |j|
      running_total << array[j][i]
    end
    result << running_total
  end
  result
end

def stock_picker(array)
  raise "Array input required." unless array.is_a?(Array)

  result = []
  return result if array.sort.reverse == array

  array.each_with_index do |buy_price, buy_day|
    array.each_with_index do |sell_price, sell_day|
      if sell_price > array[buy_day] && buy_day != sell_day && buy_day < sell_day
        result << [(sell_price - array[buy_day]), [buy_day, sell_day]]
      end
    end
  end

  result.sort_by { |stock_options| stock_options[0] }[-1][-1]
end

class TowersOfHanoi
  attr_accessor :left_tower, :right_tower, :middle_tower

  def initialize
    @left_tower = [4, 3, 2, 1]
    @right_tower = []
    @middle_tower = []
  end

  def move(pos_array)
    move_to(pos_array[1], move_from(pos_array[0]))
  end

  def move_to(to_position, piece)
    case to_position
      when "L"
        @left_tower.push(piece)
      when "M"
        @middle_tower.push(piece)
      when "R"
        @right_tower.push(piece)
    end
  end
  #
  def move_from(from_position)
    case from_position
      when "L"
        @left_tower.pop
      when "M"
        @middle_tower.pop
      when "R"
        @right_tower.pop
    end
  end

  def won?
    @left_tower.empty? &&
      (@middle_tower.empty? || @right_tower.empty?) ? true : false
  end

  def play

    until won?
      pos_array = get_answer
      move(pos_array) if valid_move?(pos_array)
    end

    puts "Congratulations you win!"
  end

  def get_answer
    puts "Please select a tower to move from (\"L\"/\"M\"/\"R\"): 
  end

  def valid_move?(pos_array)

  end



end
