require 'pry-byebug'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(7) { Array.new(6) }
  end

  def render
    puts
    puts "1234567"
    render_help(0, 5)|render_help(1, 5)|render_help(2, 5)|render_help(3, 5)|render_help(4, 5)|render_help(5, 5)|render_help(6, 5)
    puts
    render_help(0, 4)|render_help(1, 4)|render_help(2, 4)|render_help(3, 4)|render_help(4, 4)|render_help(5, 4)|render_help(6, 4)
    puts
    render_help(0, 3)|render_help(1, 3)|render_help(2, 3)|render_help(3, 3)|render_help(4, 3)|render_help(5, 3)|render_help(6, 3)
    puts
    render_help(0, 2)|render_help(1, 2)|render_help(2, 2)|render_help(3, 2)|render_help(4, 2)|render_help(5, 2)|render_help(6, 2)
    puts
    render_help(0, 1)|render_help(1, 1)|render_help(2, 1)|render_help(3, 1)|render_help(4, 1)|render_help(5, 1)|render_help(6, 1)
    puts
    render_help(0, 0)|render_help(1, 0)|render_help(2, 0)|render_help(3, 0)|render_help(4, 0)|render_help(5, 0)|render_help(6, 0)
    puts
    puts
  end
  
  def render_help(column, column_index)
    board[column][column_index].nil? ? print("-") : print(board[column][column_index].to_s)
  end

  def add_piece(choice, piece)
    if column_valid?(choice)
      empty_slots = board[choice - 1].count { |slot| slot.nil? }
      empty_row = 6 - empty_slots
      board[choice - 1][empty_row] = piece
      return true
    else
      return false
    end
  end

  def column_valid?(choice)
    if in_choice_range?(choice)
      column_choice_available?(choice)
    else
      puts 'Input error!'
      return false
    end
  end

  def in_choice_range?(choice)
    choice.between?(1, 7)
  end

  def column_choice_available?(choice)
    board[choice - 1].any?(&:nil?)
  end

  def winning_combination?(piece)
    winning_vertical?(piece) ||
    winning_horizontal?(piece) ||
    winning_ascending_diagonal?(piece) ||
    winning_descending_diagonal?(piece)
  end

  def winning_vertical?(piece)
    board.each do |column|
      (0..3).each do |row|
        won = column[row..(row + 3)].all? { |piece| piece == column[row] && !piece.nil? }
        return true if won
      end
    end
    return false
  end

  def winning_horizontal?(piece)
    transposed_board = board.transpose
    transposed_board.each do |column|
      (0..3).each do |row|
        won = column[row..(row + 3)].all? { |piece| piece == column[row] && !piece.nil? }
        return true if won
      end
    end
    return false
  end

  def winning_ascending_diagonal?(piece)
    board.each_with_index { |column, column_index|
      column.each_index { |row|
        next if board[column_index].nil? || board[column_index][row].nil?
        next if board[column_index + 1].nil? || board[column_index + 1][row + 1].nil?
        next if board[column_index + 2].nil? || board[column_index + 2][row + 2].nil?
        next if board[column_index + 3].nil? || board[column_index + 3][row + 3].nil?

        return true if ( (board[column_index][row] == board[column_index+ 1][row + 1]) && 
        (board[column_index + 1][row + 1] == board[column_index + 2][row + 2]) && 
        (board[column_index + 2][row + 2] == board[column_index + 3][row + 3]) &&
        (board[column_index][row] == piece) )
      }
    }
    return false
  end

  def winning_descending_diagonal?(piece)
    board.each_with_index { |column, column_index|
      column.each_index { |row|
        next if board[column_index].nil? || board[column_index][row].nil?
        next if board[column_index + 1].nil? || board[column_index + 1][row - 1].nil?
        next if board[column_index + 2].nil? || board[column_index + 2][row - 2].nil?
        next if board[column_index + 3].nil? || board[column_index + 3][row - 3].nil?

        return true if ( (board[column_index][row] == board[column_index+ 1][row - 1]) && 
        (board[column_index + 1][row - 1] == board[column_index + 2][row - 2]) && 
        (board[column_index + 2][row - 2] == board[column_index + 3][row - 3]) &&
        (board[column_index][row] == piece) )
      }
    }
    return false
  end
end