require './lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_initialize) {described_class.new}

    it 'creates a nested array for six rows and seven columns' do
      board = board_initialize.board
      expect(board).to eq([[nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil]])
    end
  end
end