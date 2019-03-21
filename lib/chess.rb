require_relative 'pieces_classes'
require 'yaml'
#ruby lib/chess.rb

class Chess
  attr_accessor :grid

  def initialize
    empty_grid
  end

  def empty_grid
    grid = []
    for i in 0..7
      row = []
      for j in 0..7
        row << VoidPiece.new([i,j], self)
      end
      grid << row
    end
    @grid = grid
  end

  def display_grid
    
    display_letter = "H".ord
    row_separetor = ""
    25.times{row_separetor += "_"}

    @grid.reverse.each do |row|
      print " #{row_separetor}\n#{display_letter.chr}"

      row.each do |cell|
        print "|"

        if cell.is_a? VoidPiece
          print  " " 

        elsif cell.is_a? Pawn
          print cell.color == :white ?  "\u265F".encode("utf-8") : "\u2659".encode("utf-8")
        
        elsif cell.is_a? Rook
          print cell.color == :white ? "\u2659".encode("utf-8") : "\u2656".encode("utf-8")
           
        elsif cell.is_a? Bishop
          print cell.color == :white ? "\u265D".encode("utf-8") : "\u2657".encode("utf-8")
        
        elsif cell.is_a? Knight
          print cell.color == :white ? "\u265E".encode("utf-8") : "\u2658".encode("utf-8")
        elsif cell.is_a? Queen
          print cell.color == :white ? "\u265B".encode("utf-8") : "\u2655".encode("utf-8")
        end
        print " "
      end

      print "|\n"
      display_letter -= 1
    end
    print "  1  2  3  4  5  6  7  8\n"
  end

  def check_all_possible_moves color
    possible = []
    grid.each do |row|
      row.each do |cell|
        if cell.color == color
          cell.possible_moves.each do |move|
            possible << move
          end
        end
      end
    end
    possible.uniq
  end

  #functions to save and load grids
  def save_grid
    File.open 'default_game.yml', 'w' do |file|
      save = []
      @grid.each do |row|
        row.each do |cell|
          save << {piece: cell.piece, position: cell.position, color: cell.color} 
        end
      end
      file.puts YAML.dump save
    end
  end

  def load_grid file_route
    load = YAML.load_file file_route
    load.each do |piece|
      position = piece[:position]
      if piece[:piece] == :empty
        @grid[position[0]][position[1]] = VoidPiece.new position, self
      elsif piece[:piece] == :pawn
        @grid[position[0]][position[1]] = Pawn.new piece[:color], position, self
      elsif piece[:piece] == :rook
        @grid[position[0]][position[1]] = Rook.new piece[:color], position, self
      elsif piece[:piece] == :bishop
        @grid[position[0]][position[1]] = Bishop.new piece[:color], position, self
      elsif piece[:piece] == :knight
        @grid[position[0]][position[1]] = Knight.new piece[:color], position, self
      elsif piece[:piece] == :queen
        @grid[position[0]][position[1]] = Queen.new piece[:color], position, self
      elsif piece[:piece] == :king
        @grid[position[0]][position[1]] = King.new piece[:color], position, self
      end
    end 
  end
end

game = Chess.new
game.load_grid "spec/pieces_tests/king_test.yml"









