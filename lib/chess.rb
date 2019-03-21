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
          if cell.color == :white
            print "\u265F".encode("utf-8")
          else
            print "\u2659".encode("utf-8")
          end 
        
        end
        print " "
      end

      print "|\n"
      display_letter -= 1
    end
    print "  1  2  3  4  5  6  7  8\n"
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
      if piece[:piece] == :empty
        position = piece[:position]
        @grid[position[0]][position[1]] = VoidPiece.new position, self
      elsif piece[:piece] == :pawn
        position = piece[:position]
        @grid[position[0]][position[1]] = Pawn.new piece[:color], position, self
      end
    end 
  end
end

game = Chess.new
game.load_grid "spec/pieces_spec.yml"

game.display_grid

#puts "\u265F".encode("utf-8")





