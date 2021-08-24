class Player
  attr_accessor :piece, :board

  def initialize(name, piece, board)
    @name = name
    @piece = piece
    @board = board
  end

  def ask_for_column_choice
    puts "Please select a column from 1 to 7."
    gets.chomp
  end

  def validate_column_choice(choice)
    choice.match? /\A\d+\z/ ? true : false
      return true
    else
      return false
    end
  end
end