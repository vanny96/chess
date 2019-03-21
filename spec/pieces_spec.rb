require './lib/pieces_classes.rb'
require_relative '../lib/chess.rb'

#Numbers near pieces indicate what tests they are related to

#pawn_test scheme
# _________________________
#H|  |♟3|  |  |  |  |♙9|  |
# _________________________
#G|♟1|  |  |  |  |♟8|  |♟7|
# _________________________
#F|♟4|  |  |  |  |  |  |  |
# _________________________
#E|  |  |  |  |  |  |  |  |
# _________________________
#D|  |  |  |  |  |  |  |  |
# _________________________
#C|  |  |  |  |  |  |  |  |
# _________________________
#B|♙2|♙6|  |  |  |  |  |  |
# _________________________
#A|  |♙5|  |  |  |  |  |  |
# 1  2  3  4  5  6  7  8

describe Pawn do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_tests/pawn_test.yml"

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



# _________________________
#H|  |  |  |  |  |  |  |  |
# _________________________
#G|  |  |  |  |♜3|  |♙ |  |
# _________________________
#F|  |  |  |  |  |  |  |  |
# _________________________
#E|  |  |  |  |  |  |♖4|  |
# _________________________
#D|  |  |  |  |  |  |  |  |
# _________________________
#C|  |  |♖1|  |  |  |  |  |
# _________________________
#B|  |  |  |  |  |  |  |  |
# _________________________
#A|♖2|  |  |  |  |  |  |  |
#  1  2  3  4  5  6  7  8

describe Rook do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_tests/rook_test.yml"
    
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


# _________________________
#H|  |  |  |  |  |  |  |  |
# _________________________
#G|  |  |  |  |♙3|  |  |  |
# _________________________
#F|  |♟2|  |  |  |  |  |  |
# _________________________
#E|  |  |♗2|  |  |  |  |  |
# _________________________
#D|  |  |  |  |  |  |  |  |
# _________________________
#C|  |  |♝1|  |  |  |  |  |
# _________________________
#B|  |  |  |  |  |  |  |  |
# _________________________
#A|  |  |  |  |  |  |  |  |
# 1  2  3  4  5  6  7  8

describe Bishop do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_tests/bishop_test.yml"
  
  #1
    it "Moves in diagonally" do
      expect(game.grid[2][2].possible_moves).to eql([[1,1],[0,0],[1,3],[0,4],[3,1],[4,0],
                                                     [3,3],[4,4],[5,5],[6,6],[7,7]])
    end 
  #2
    it "Suggests to eat an enemy" do
      expect(game.grid[4][2].possible_moves.include?([5,1])).to eql(true)
    end
  #4 
    it "Doesn't suggest to eat an ally" do
      expect(game.grid[4][2].possible_moves.include?([6,4])).to eql(false)
    end
  end
end

#  _________________________
#H|  |  |  |♖4|  |  |  |♟3|
# _________________________
#G|  |  |  |  |  |♘3|  |  |
# _________________________
#F|  |  |  |  |  |  |  |  |
# _________________________
#E|  |  |  |  |  |  |  |  |
# _________________________
#D|  |  |  |♞1|  |  |  |  |
# _________________________
#C|  |  |  |  |  |  |  |  |
# _________________________
#B|  |♘2|  |  |  |  |  |  |
# _________________________
#A|  |  |  |  |  |  |  |  |
# 1  2  3  4  5  6  7  8

describe Knight do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_tests/knight_test.yml"

  #1
    it "Moves by L rule if free" do
      expect(game.grid[3][3].possible_moves).to eql([[2, 1], [1, 2], [1, 4], [2, 5], [4, 5], [5, 4], [5, 2], [4, 1]])  
    end   
  #2 
    it "Doesn't broke near edges" do
      expect(game.grid[1][1].possible_moves).to eql([[0, 3], [2, 3], [3, 2], [3, 0]])  
    end
  #3
    it "Includes a cell occupied by a piece of another color" do
      expect(game.grid[6][5].possible_moves.include?([7,7])).to eql(true)
    end
  #4
    it "Doesn't include a cell occupied by a piece of same color" do
      expect(game.grid[6][5].possible_moves.include?([7,3])).to eql(false)
    end
  end
end

describe Queen do
  describe "#possible_moves" do
  game = Chess.new
  game.load_grid "spec/pieces_tests/queen_test.yml"
    it "Moves like a rook and a bishop" do
      expect(game.grid[2][2].possible_moves).to eql([[1,1],[0,0],[1,3],[0,4],[3,1],[4,0], #bishop-like
                                                      [3,3],[4,4],[5,5],[6,6],[7,7], 
                                                      [1,2],[0,2],[3,2],[4,2],[5,2],[6,2],[7,2], #rook-like
                                                      [2,1],[2,0],[2,3],[2,4],[2,5],[2,6],[2,7]])  
    end
  end 
end



describe King do
  describe "#possible_moves" do
    game = Chess.new
    game.load_grid "spec/pieces_tests/king_test.yml"
    it "Can move in all directions if free" do
      expect(game.grid[1][3].possible_moves).to eql([[2, 3], [2, 4], [1, 4], [0, 4], 
                                                      [0, 3], [0, 2], [1, 2], [2, 2]])  
    end
    it "Works near the edges" do
      expect(game.grid[0][0].possible_moves).to eql([[1, 0], [1, 1], [0, 1]]) 
    end
  end
end
