require_relative 'pieces_classes'
require 'yaml'
#ruby lib/chess.rb

class Chess
  attr_accessor :grid

  def initialize
    empty_grid
  end

  def new_game
    load_grid "lib/new_game.yml"
  end

  def play_game
    display_grid
    white_in_check = false
    black_in_check = false
    loop do

      move_piece :white, white_in_check

      if check_if_check :white
        if check_if_mate :white
          puts "White wins!"
          break
        end
        puts "called"
        black_in_check = true
      end

      white_in_check = false


      move_piece :black, black_in_check

      if check_if_check :black
        if check_if_mate :black
          puts "Black wins!"
          break
        end

        white_in_check = true
      end

      black_in_check = false
    end
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


  def move_piece color, in_check = false
    if in_check
      loop do
        puts "You are under check! Move your king"
        king = find_king color
        piece = @grid[king[0]][king[1]]

        puts "Your possible moves are:"
        piece.possible_moves.each do |move|
          print "#{array_to_table(move).join('-')}\n"
        end

        puts "Where do you want to go? (ex C-1)"
        new_piece = gets.chomp.split('-') 

        unless check_input new_piece
          puts "Wrong format"
          next
        end

        new_piece = table_to_array new_piece

        unless piece.possible_moves.include? new_piece
          puts "It's not a possible move"
          next
        end

        create_piece piece.piece, piece.color, new_piece
        create_piece :empty, nil, king
  
        display_grid
        break
      end
    else
      loop do
        puts "#{color.to_s.capitalize}, what piece do you want to move? (ex A-2)"
        piece_position = gets.chomp.split('-') 

        unless check_input piece_position
          puts "Wrong format"
          next
        end

        piece_position = table_to_array piece_position
        piece = @grid[piece_position[0]][piece_position[1]]

        if piece.color != color
          puts "This is not a piece of yours!"
          next
        end

        puts "These are your possible moves"
        piece.possible_moves.each do |move|
          print "#{array_to_table(move).join('-')}\n"
        end

        puts "Where do you want to go? (ex C-1)"
        new_piece = gets.chomp.split('-') 

        unless check_input new_piece
          puts "Wrong format"
          next
        end

        new_piece = table_to_array new_piece

        unless piece.possible_moves.include? new_piece
          puts "It's not a possible move"
          next
        end

        create_piece piece.piece, piece.color, new_piece
        create_piece :empty, nil, piece_position
  
        display_grid
        break      
      end
    end
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
          print cell.color == :white ? "\u265C".encode("utf-8") : "\u2656".encode("utf-8")
           
        elsif cell.is_a? Bishop
          print cell.color == :white ? "\u265D".encode("utf-8") : "\u2657".encode("utf-8")
        
        elsif cell.is_a? Knight
          print cell.color == :white ? "\u265E".encode("utf-8") : "\u2658".encode("utf-8")
        elsif cell.is_a? Queen
          print cell.color == :white ? "\u265B".encode("utf-8") : "\u2655".encode("utf-8")
        elsif cell.is_a? King
          print cell.color == :white ? "\u265A".encode("utf-8") : "\u2654".encode("utf-8")
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

          if cell.piece == :pawn
            cell.check_attacking_positions.each do |move|
              possible << move
            end

          elsif cell.piece == :king
            cell.possible_moves(true).each do |move|
              possible << move
            end

          else
            cell.possible_moves.each do |move|
              possible << move
            end
          end
        end
      end
    end
    possible.uniq
  end

  #Functions to save and load grids
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
      create_piece piece[:piece], piece[:color], piece[:position]
    end 
  end


  def check_if_check color
    king = find_king color == :white ? :black : :white

    check_all_possible_moves(color).include? king
  end

  def check_if_mate color
    king = find_king color == :white ? :black : :white

    
    @grid[king[0]][king[1]].possible_moves.empty?
  end

  
  def create_piece piece, color, position 
    if piece == :empty
      @grid[position[0]][position[1]] = VoidPiece.new position, self
    elsif piece == :pawn
      @grid[position[0]][position[1]] = Pawn.new color, position, self
    elsif piece == :rook
      @grid[position[0]][position[1]] = Rook.new color, position, self
    elsif piece == :bishop
      @grid[position[0]][position[1]] = Bishop.new color, position, self
    elsif piece == :knight
      @grid[position[0]][position[1]] = Knight.new color, position, self
    elsif piece == :queen
      @grid[position[0]][position[1]] = Queen.new color, position, self
    elsif piece == :king
      @grid[position[0]][position[1]] = King.new color, position, self
    end
  end

  private

  def check_input input
    return false if input.length != 2 ||
                    /[A-H]{1}/.match(input[0]).to_s != input[0] ||
                    /[1-8]{1}/.match(input[1]).to_s != input[1] 
    return true
  end
  def table_to_array coordinates
    coordinates = [coordinates[0].ord - 65, coordinates[1].to_i - 1]
    coordinates
  end
  def array_to_table coordinates
    coordinates[0] = (coordinates[0] + 65).chr
    coordinates[1] = (coordinates[1] + 1)
    coordinates
  end
  def find_king color 

    king = [10,10]

    @grid.each do |row|
      row.each do |cell|
        king = cell.position if cell.piece == :king && cell.color == color
      end
    end

    king
  end
end









