class Player
  attr_accessor :piece, :board

  def initialize(name, piece, board)
    @name = name
    @piece = piece
    @board = board
  end

  def get_column_choice
    loop do
      break if verify_column_choice(ask_for_column_choice)

      puts 'Input error!'
    end

  end

  def ask_for_column_choice
    puts "Please select a column from 1 to 7."
    gets.chomp.to_i
  end

  def verify_column_choice(choice)
    if choice.is_a? Integer
      return choice
    else
      return false
    end
  end
end