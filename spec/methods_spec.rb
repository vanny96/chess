require './lib/pieces_classes.rb'
require_relative '../lib/chess.rb'

describe Chess do
  describe "#check_if_check" do

    it "Returns true if king is under check" do
      game = Chess.new
      game.create_piece :king, :black, [7,5]
      game.create_piece :pawn, :white, [6,4]

      expect(game.check_if_check :white).to eql(true) 
    end

    it "Isn't always true" do
      game = Chess.new
      game.create_piece :king, :black, [7,5]
      game.create_piece :pawn, :white, [5,4]

      expect(game.check_if_check :white).to eql(false) 
    end
  end

  describe "check_if_mate" do
    it "Returns true if is check-mate" do
      game = Chess.new
      game.create_piece :king, :black, [7,7]
      game.create_piece :queen, :white, [6,6]
      game.create_piece :pawn, :white, [5,5]

      expect(game.check_if_mate :white).to eql(true)
    end    
    it "Doesn't always return true" do
      game = Chess.new
      game.create_piece :king, :black, [7,7]
      game.create_piece :queen, :white, [6,6]
      game.create_piece :pawn, :white, [4,5]

      expect(game.check_if_mate :white).to eql(false)
    end    
  end
  
  describe "#check_promotion" do

    it "Return the pawn position if it is on promotion line" do
      game = Chess.new
      game.create_piece :pawn, :white, [7,7]

      expect(game.check_promotion :white).to eql([[7,7]])  
    end
    it "Works with black pieces" do
      game = Chess.new
      game.create_piece :pawn, :black, [0,0]

      expect(game.check_promotion :black).to eql([[0,0]])  
    end
    it "Only works with pawns" do
      game = Chess.new
      game.create_piece :bishop, :black, [0,0]

      expect(game.check_promotion :black).to eql([])  
    end
  end
end