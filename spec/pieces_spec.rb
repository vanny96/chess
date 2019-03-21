require './lib/pieces_classes.rb'
require_relative '../lib/chess.rb'

#pawn_test scheme
# _________________________
#H|  |♟ |  |  |  |  |♙ |  |
# _________________________
#G|♟ |  |  |  |  |♟ |  |♟ |
# _________________________
#F|♟ |  |  |  |  |  |  |  |
# _________________________
#E|  |  |  |  |  |  |  |  |
# _________________________
#D|  |  |  |  |  |  |  |  |
# _________________________
#C|  |  |  |  |  |  |  |  |
# _________________________
#B|♙ |♙ |  |  |  |  |  |  |
# _________________________
#A|  |♙ |  |  |  |  |  |  |
# 1  2  3  4  5  6  7  8

describe Pawn do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pawn_test.yml"

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

describe Rook do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/rook_test.yml"
    
  #1
    it "Moves in horizontally and vertically" do
      expect(game.grid[2][2].possible_moves).to eql([[1,2],[0,2],[3,2],[4,2],[5,2],[6,2],[7,2],
                                                  [2,1],[2,0],[2,3],[2,4],[2,5],[2,6],[2,7]])
    end  
  #2
    it "Works near the edges" do
      expect(game.grid[0][0].possible_moves).to eql([[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],
                                                    [0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]])
    end
  #3
    it "Suggests to eat an enemy" do
      expect(game.grid[6][4].possible_moves.include?([6,6])).to eql(true)
    end
  #4 
    it "Doesn't suggest to eat an ally" do
      expect(game.grid[4][6].possible_moves.include?([6,6])).to eql(false)
    end
  end
end