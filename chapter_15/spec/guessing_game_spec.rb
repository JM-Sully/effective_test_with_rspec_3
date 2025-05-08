require 'guessing_game'

RSpec.describe GuessingGame do
  context 'when the game is played' do
    let(:game) { GuessingGame.new }

    before { allow(game).to receive(:rand).and_return(50) }

    it 'prompts the player for a guess' do
      allow(game).to receive(:gets).and_return('20', '60')

      expect { game.play }.to output(
        /Pick a number 1-100 \(5 guesses left\).*Pick a number 1-100 \(4 guesses left\)/m
      ).to_stdout
    end

    it 'gives feedback on the guess' do
      allow(game).to receive(:gets).and_return('20', '60', '-50', '150')

      expect { game.play }.to output(
        /20 is too low!.*60 is too high!.*-50 is too low!.*150 is too high!/m
      ).to_stdout
    end

    it 'announces the correct result when the player wins' do
      allow(game).to receive(:gets).and_return('50')

      expect { game.play }.to output(/You won!/).to_stdout
    end

    it 'announces the correct result when the player loses' do
      allow(game).to receive(:gets).and_return('60', '70', '80', '90', '100')

      expect { game.play }.to output(/You lost! The number was: 50/).to_stdout
    end
  end
end
