require './lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_initialize) { described_class.new }

    it 'creates a nested array for six rows and seven columns' do
      board = board_initialize.board
      expect(board).to eq([[nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]])
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

  describe 'column_choice_available?' do
    subject(:board_available) { described_class.new }

    context 'when given a choice for an empty column in the board and board is empty' do
      before do
        board_available.instance_variable_set(:@board, [[nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]])
      end

      it 'returns true' do
        available_column = 3
        column_check = board_available.column_choice_available?(available_column)
        expect(column_check).to be true
      end
    end

    context 'when given a choice for a nearly column in the board ' do
      before do
        board_available.instance_variable_set(:@board, [["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]])
      end

      it 'returns true' do
        available_column = 1
        column_check = board_available.column_choice_available?(available_column)
        expect(column_check).to be true
      end
    end

    context 'when given a choice for a full column in the board ' do
      before do
        board_available.instance_variable_set(:@board, [["\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m", "\e[31mO\e[0m", "\e[37mO\e[0m"], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]])
      end

      it 'returns false' do
        available_column = 1
        column_check = board_available.column_choice_available?(available_column)
        expect(column_check).to be false
      end
    end
  end
end