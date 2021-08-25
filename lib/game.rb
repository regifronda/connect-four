class Game
  attr_accessor :board, :player_1, :player_2, :current_player
  
  def initialize
    @board = Board.new

    @player_1 = Player.new('Player 1', "\e[37mO\e[0m", @board)
    @player_2 = Player.new('Player 2', "\e[31mO\e[0m", @board)

    @current_player = player_1
  end
  
  def play
    game_intro
    player_turns
  end
  
  def player_turns
    until board.full?
      turn
      break if check_game_over
      switch_players
    end
  end

  def turn
    choice = current_player.get_column_choice.to_i
    board.add_piece(choice, current_player.piece)
    board.render
  end

  def check_game_over
    check_victory
  end

  def check_victory
    if board.winning_combination?(current_player.piece)
      puts "Congratulations! You win, #{current_player.name}!"
      true
    else
      false
    end
  end

  def switch_players
    if current_player == player_1
      @current_player = player_2
    else
      @current_player = player_1
    end
  end

  def game_intro
    puts 'Welcome to Connect 4!'
    puts 'Try to get 4 of your own piece consecutively in a row, column, or diagonal.'
    board.render
  end
end