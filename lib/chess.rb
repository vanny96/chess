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

  def default_grid
    load_grid "default_game.yml"
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








