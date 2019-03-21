require './lib/pieces_classes.rb'
require_relative '../lib/chess.rb'

describe Pawn do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_spec.yml"

    it "Suggests moves forwards if it's white" do
      expect(game.grid[6][0].possible_moves).to eql([[7,0]])
    end
    it "Suggests moves backwards if it's black" do
      expect(game.grid[1][0].possible_moves).to eql([[0,0]])
    end
    it "Doesn't suggest anything if against the wall" do
      expect(game.grid[7][1].possible_moves).to eql([])
    end
    it "Doesn't suggest anything if another piece occupies the slot" do
      expect(game.grid[5][0].possible_moves).to eql([])
    end
  end
end