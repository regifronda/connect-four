class Player
  attr_accessor :name, :piece, :board

  def initialize(name, piece, board)
    @name = name
    @piece = piece
    @board = board
  end

  def get_column_choice
    loop do
      choice = ask_for_column_choice
      return choice if verify_column_choice(choice)

      puts 'Input error!'
    end
  end

  def ask_for_column_choice
    puts "#{name}, please select a column from 1 to 7."
    gets.chomp
  end

  def verify_column_choice(choice)
    if choice.match? /\A\d+\z/
      return choice
    else
      return false
    end
  end
end