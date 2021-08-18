require './lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_initialize) { described_class.new }

    it 'creates a nested array for six rows and seven columns' do
      board = board_initialize.board
      expect(board).to eq([[nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil]])
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
        valid_number = 7
        verified_number = board_choice.in_choice_range?(valid_number)
        expect(verified_number).to be false
      end
    end
  end
end