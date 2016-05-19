require 'rspec'
require 'player'

describe Player do
  subject(:player) {Player.new}

  class NoMoreInput < StandardError
  end

  before do
    $stdout = StringIO.new
    $stdin = StringIO.new

    class Player
      def gets
        result = $stdin.gets
        raise NoMoreInput unless result

        result
      end
    end

    def recent_output
      outputs = $stdout.string.split("\n")
      max = [outputs.length, 5].min
      outputs[-max..-1].join(" ")
    end

    def human.get_move!
      get_move
      rescue NoMoreInput
    end
  end

  after :all do
    $stdout = STDOUT
    $stdin = STDIN
  end


  describe "#get_discard" do
    it 'gets user input'
    it 'throws an error for invalid input'
    it 'handles multi cards'
  end

  describe "#get_action" do
    it 'gets user input' do
      player.get_action
      $stdin.string << "fold"
      expect{$stdin.string}.to eq('fold')
    end

    it 'throws an error for invalid input'
  end

  describe '#get_raise_amount' do
    it 'gets user input' do
      $stdin.string << "5"
      expect{Integer($stdin.string.to_i)}.not_to raise_error
    end

    it 'throws an error if amount is more than pot'

  end
end
