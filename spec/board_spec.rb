require './lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_initialize) { described_class.new }

    it 'creates a nested array for six rows and seven columns' do
      board = board_initialize.board
      expect(board).to eq([
        [nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil], 
        [nil, nil, nil, nil, nil, nil]])
    end
  end

  describe 'in_choice_range?' do
    subject(:board_choice) { described_class.new }

    context 'when given a valid number as argument' do
      it 'returns true' do
        valid_number = 3
        verified_number = board_choice.in_choice_range?(valid_number)
        expect(verified_number).to be true
      end
    end

    context 'when given an invalid number as argument' do
      it 'returns false' do
        invalid_number = 8
        unverified_number = board_choice.in_choice_range?(invalid_number)
        expect(unverified_number).to be false
      end
    end
  end

  describe '#column_choice_available?' do
    subject(:board_available) { described_class.new }

    context 'when given a choice for an empty column in the board and board is empty' do
      before do
        board_available.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil]])
      end

      it 'returns true' do
        available_column = 3
        column_check = board_available.column_choice_available?(available_column)
        expect(column_check).to be true
      end
    end

    context 'when given a choice for a nearly column in the board ' do
      before do
        board_available.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
          ])
      end

      it 'returns true' do
        available_column = 1
        column_check = board_available.column_choice_available?(available_column)
        expect(column_check).to be true
      end
    end

    context 'when given a choice for a full column in the board ' do
      before do
        board_available.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
          ])
      end

      it 'returns false' do
        available_column = 1
        column_check = board_available.column_choice_available?(available_column)
        expect(column_check).to be false
      end
    end
  end

  describe '#winning_vertical?' do
    subject(:board_vertical) { described_class.new }

    context 'when four of the same piece are vertically adjacent to one another' do
      before do
        board_vertical.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          ["\e[37mO\e[0m", "\e[37mO\e[0m", "\e[37mO\e[0m", nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
          ])
      end

      it 'returns true' do
        winning_piece = "\e[31mO\e[0m"
        vertical_check = board_vertical.winning_vertical?(winning_piece)
        expect(vertical_check).to be true
      end
    end

    context 'when three of the same piece are vertically adjacent to one another' do
      before do
        board_vertical.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[37mO\e[0m", "\e[37mO\e[0m", nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
          ])
      end

      it 'returns false' do
        piece = "\e[31mO\e[0m"
        vertical_check = board_vertical.winning_vertical?(piece)
        expect(vertical_check).to be false
      end
    end

    context 'when board is empty' do
      before do
        board_vertical.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
          ])
      end

      it 'returns false' do
        piece = "\e[31mO\e[0m"
        vertical_check = board_vertical.winning_vertical?(piece)
        expect(vertical_check).to be false
      end
    end
  end

  describe '#winning_horizontal?' do
    subject(:board_horizontal) { described_class.new }

    context 'when four of the same piece are horizontally adjacent to one another' do
      before do
        board_horizontal.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          ["\e[37mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil, nil, nil]
        ])
      end

      it 'returns true' do
        winning_piece = "\e[31mO\e[0m"
        horizontal_check = board_horizontal.winning_horizontal?(winning_piece)
        expect(horizontal_check).to be true
      end
    end

    context 'when three of the same piece are horizontally adjacent to one another' do
      before do
        board_horizontal.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'returns false' do
        winning_piece = "\e[31mO\e[0m"
        horizontal_check = board_horizontal.winning_horizontal?(winning_piece)
        expect(horizontal_check).to be false
      end
    end
    
    context 'when the board is empty' do
      before do
        board_horizontal.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'returns false' do
        winning_piece = "\e[31mO\e[0m"
        horizontal_check = board_horizontal.winning_horizontal?(winning_piece)
        expect(horizontal_check).to be false
      end
    end
  end

  describe '#winning_ascending_diagonal?' do 
    subject(:board_ascending_diagonal) { described_class.new }
    
    context 'when four of the same piece are in an ascending diagonal line' do
      before do
        board_ascending_diagonal.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          ["\e[31mO\e[0m", nil, nil, nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil],
          [nil, nil, nil, nil, nil, nil],
          ["\e[37mO\e[0m", nil, nil, nil, nil, nil],
        ])
      end

      it 'returns true' do
        winning_piece = "\e[31mO\e[0m"
        ascending_diagonal_check = board_ascending_diagonal.winning_ascending_diagonal?(winning_piece)
        expect(ascending_diagonal_check).to be true
      end
    end

    context 'when four of the same piece are in an ascending diagonal line in the middle of the board' do
      before do
        board_ascending_diagonal.instance_variable_set(:@board, [
          ["\e[37mO\e[0m", nil, nil, nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil],
          [nil, nil, nil, nil, nil, nil],
          ["\e[31mO\e[0m", nil, nil, nil, nil, nil]
        ])
      end

      it 'returns true' do
        winning_piece = "\e[31mO\e[0m"
        ascending_diagonal_check = board_ascending_diagonal.winning_ascending_diagonal?(winning_piece)
        expect(ascending_diagonal_check).to be true
      end
    end

    context 'when board is empty' do
      before do
        board_ascending_diagonal.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'returns false' do
        piece = "\e[31mO\e[0m"
        ascending_diagonal_check = board_ascending_diagonal.winning_ascending_diagonal?(piece)
        expect(ascending_diagonal_check).to be false
      end
    end
  end

  describe '#winning_descending_diagonal?' do 
    subject(:board_descending_diagonal) { described_class.new }

    context 'when four of the same piece are in an descending diagonal line' do
      before do
        board_descending_diagonal.instance_variable_set(:@board, [
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'returns true' do
        winning_piece = "\e[31mO\e[0m"
        descending_diagonal_check = board_descending_diagonal.winning_descending_diagonal?(winning_piece)
        expect(descending_diagonal_check).to be true
      end
    end

    context 'when only three pieces are in an descending diagonal line' do
      before do
        board_descending_diagonal.instance_variable_set(:@board, [
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'returns false' do
        winning_piece = "\e[31mO\e[0m"
        descending_diagonal_check = board_descending_diagonal.winning_descending_diagonal?(winning_piece)
        expect(descending_diagonal_check).to be false
      end
    end

    context 'when descending diagonal is on right side of the board' do
      before do
        board_descending_diagonal.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil, nil],
          ["\e[31mO\e[0m", nil, nil, nil, nil, nil]
        ])
      end

      it 'returns true' do
        winning_piece = "\e[31mO\e[0m"
        descending_diagonal_check = board_descending_diagonal.winning_descending_diagonal?(winning_piece)
        expect(descending_diagonal_check).to be true
      end
    end
    
    context 'when board is empty' do
      before do
        board_descending_diagonal.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'returns false' do
        piece = "\e[31mO\e[0m"
        descending_diagonal_check = board_descending_diagonal.winning_descending_diagonal?(piece)
        expect(descending_diagonal_check).to be false
      end
    end
  end

  describe '#add_piece' do
    subject(:board_add) { described_class.new }

    context 'when the board is empty' do
      before do
        board_add.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'adds the new piece' do
        added_piece_board = [
          ["\e[31mO\e[0m", nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
        added_check = board_add.add_piece(1, "\e[31mO\e[0m")
        expect(board_add.board).to eql(added_piece_board)
      end
    end

    context 'when the selected column has 3 pieces' do
      before do
        board_add.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'does not add the new piece' do
        added_piece_board = [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
        added_check = board_add.add_piece(1, "\e[37mO\e[0m")
        expect(board_add.board).to eql(added_piece_board)
      end
    end

    context 'when the selected column is full' do
      before do
        board_add.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'does not add the new piece' do
        added_piece_board = [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
        added_check = board_add.add_piece(1, "\e[31mO\e[0m")
        expect(board_add.board).to eql(added_piece_board)
      end
    end
  end

  describe '#full?' do
    subject(:board_full) { described_class.new }

    context 'when board is empty' do
      before do
        board_full.instance_variable_set(:@board, [
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m"],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m"],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"],
          ["\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m"],
          ["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"],
        ])
      end

      it 'is full' do
        expect(board_full).to be_full
      end
    end

    context 'when board is empty' do
      before do
        board_full.instance_variable_set(:@board, [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
      end

      it 'is not full' do
        expect(board_full).not_to be_full
      end
    end
  end
end
