require './lib/player'

describe Player do
  subject(:player) { described_class.new("Player 1", "\e[37mO\e[0m", @board) }

  describe '#column_choice_valid?' do
    context 'when given a valid number as an argument' do
      it 'returns true' do
        valid_number = '1'
        verified_input = player.column_choice_valid?(valid_number)
        expect(verified_input).to be true
      end
    end

    context 'when given a letter as an argument' do
      it 'returns false' do
        valid_number = 'a'
        verified_input = player.column_choice_valid?(valid_number)
        expect(verified_input).to be false
      end
    end

    context 'when given a decimal as an argument' do
      it 'returns false' do
        valid_number = '1.0'
        verified_input = player.column_choice_valid?(valid_number)
        expect(verified_input).to be false
      end
    end
  end
end