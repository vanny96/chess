require './lib/pieces_classes.rb'
require_relative '../lib/chess.rb'

describe Pawn do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_spec.yml"

  #1  
    it "Suggests moves forwards if it's white" do
      expect(game.grid[6][0].possible_moves).to eql([[7,0]])
    end
  #2
    it "Suggests moves backwards if it's black" do
      expect(game.grid[1][0].possible_moves).to eql([[0,0]])
    end
  #3
    it "Doesn't suggest anything if against the wall-white" do
      expect(game.grid[7][1].possible_moves).to eql([])
    end
  #4
    it "Doesn't suggest anything if another piece occupies the slot-white" do
      expect(game.grid[5][0].possible_moves).to eql([])
    end
  #5
    it "Doesn't suggest anything if against the wall-black" do
      expect(game.grid[0][1].possible_moves).to eql([])
    end
  #6
    it "Doesn't suggest anything if another piece occupies the slot-black" do
      expect(game.grid[1][1].possible_moves).to eql([])
    end
  #7
    it "Suggests possibility to eat a black piece on left -white" do 
      expect(game.grid[6][7].possible_moves).to eql([[7, 7], [7, 6]])
    end
  #8
    it "Suggests possibility to eat a black piece on right -white" do
      expect(game.grid[6][5].possible_moves).to eql([[7, 5], [7, 6]])
    end
  #9 
    it "Suggests possibility to eat a white piece on left and right -black" do 
      expect(game.grid[7][6].possible_moves).to eql([[6, 6], [6, 5], [6,7]])
    end
  end
end