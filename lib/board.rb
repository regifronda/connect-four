class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def render
    puts
    @board.each do |row|
      row.each do |cell|
      cell.nil? ? print("-") : print(cell.to_s)
      end
      puts
    end
    puts
  end

  def in_choice_range?(choice)
    choice.between?(0, 6)
  end

  def column_choice_available?(choice)
    @board[choice].any?(&:nil?)
  end
end