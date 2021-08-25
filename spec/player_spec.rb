require './lib/player'

describe Player do

  describe '#verify_column_choice' do
    subject(:player_verify) { described_class.new("Player 1", "\e[37mO\e[0m", @board) }

    context 'when given a valid number as an argument' do
      it 'returns true' do
        valid_number = 1
        verified_input = player_verify.verify_column_choice(valid_number)
        expect(verified_input).to eq(1)
      end
    end

    context 'when given a letter as an argument' do
      it 'returns false' do
        valid_number = 'a'
        verified_input = player_verify.verify_column_choice(valid_number)
        expect(verified_input).to be false
      end
    end

    context 'when given a decimal as an argument' do
      it 'returns false' do
        valid_number = '1.0'
        verified_input = player_verify.verify_column_choice(valid_number)
        expect(verified_input).to be false
      end
    end
  end

  describe '#get_column_choice' do
    subject(:player_choice) { described_class.new("Player 1", "\e[37mO\e[0m", @board) }


    context 'when user input is valid' do
      it 'stops loop and does not display error message' do
        valid_input = 3
        allow(player_choice).to receive(:ask_for_column_choice).and_return(valid_input)
        expect(player_choice).not_to receive(:puts).with('Input error!')
        player_choice.get_column_choice
      end
    end

    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        letter = 'd'
        valid_input = 7
        allow(player_choice).to receive(:ask_for_column_choice).and_return(letter, valid_input)
      end

      it 'completes loop and displays error message once' do
        expect(player_choice).to receive(:puts).with('Input error!').once
        player_choice.get_column_choice
      end
    end
  end
end