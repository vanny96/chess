require_relative 'pieces_classes'
require 'yaml'
#ruby lib/chess.rb

class Chess
  attr_accessor :grid, :color

  def initialize
    empty_grid
    load_grid "save/new_game.yml"
  end

  def play_game
    display_grid
    @check = false

    @color = :white

    puts "If you want to load a previous game, type 'load' during the move selection"
    puts "If you want to save the game, type 'save' during the move selection"

    loop do
      
      play_turn

      @color = @color == :white ? :black : :white
      
    end
  end


  private
  def play_turn
    move_piece 
    @check = false

    if check_if_check
      @check = true
    end

    if check_promotion.length == 1
      promote check_promotion[0]
    end
  end


  public

  def move_piece 
    puts "You are under check! Free your king or you'll be defeated!" if @check
    
    loop do
      puts "#{@color.capitalize}, what piece do you want to move? (ex A-2)"
      piece_position = gets.chomp.split('-') 

      #Option to save and load games while in your turn

      if piece_position.length == 1
        manage_game_save piece_position[0]
        next
      end

      #Actual movement code

      next unless check_input piece_position

      piece_position = table_to_array piece_position
      piece = @grid[piece_position[0]][piece_position[1]]

      if piece.color != @color
        puts "This is not a piece of yours!"
        next
      end

      where_to_move piece_position, piece
      break
    end

    other_color = @color == :white ? :black : :white
    if check_if_check other_color
      puts "#{other_color.capitalize} wins!"
      exit
    end
  end


  private

  def where_to_move piece_position, piece

    loop do
      print_possible_moves piece

      puts "Type 'back' if you want to chose your piece again"
      puts "Where do you want to go? (ex C-1)"

      new_piece = gets.chomp.split('-') 

      if new_piece == ['back']
        move_piece @check 
        return
      end

      next unless check_input new_piece
          

      new_piece = table_to_array new_piece

      unless piece.possible_moves.include? new_piece
        puts "It's not a possible move"
        next
      end

      create_piece piece.piece, piece.color, new_piece
      create_piece :empty, nil, piece_position
  
      display_grid
      return
    end
  end


  def manage_game_save comand
    if comand == "save"
      save_grid "save/saved_game.yml"
      puts "Game saved!"

    elsif comand == "load"
      if File.exist? "save/saved_game.yml"
        load_grid "save/saved_game.yml"
        display_grid
        puts "Game loaded!"
      else
        puts "No file to load"
      end

    else
      puts "No valid comand"
    end
  end


  public


  def display_grid
    
    display_letter = "H".ord
    row_separetor = ""
    25.times{row_separetor += "_"}

    @grid.reverse.each do |row|
      print " #{row_separetor}\n#{display_letter.chr}"

      row.each do |cell|
        print "|"

        case cell.piece
          when :empty
            print  " "
          when :pawn
            print cell.color == :white ?  "\u265F".encode("utf-8") : "\u2659".encode("utf-8")
          when :rook
            print cell.color == :white ? "\u265C".encode("utf-8") : "\u2656".encode("utf-8")
          when :bishop
            print cell.color == :white ? "\u265D".encode("utf-8") : "\u2657".encode("utf-8")
          when :knight
            print cell.color == :white ? "\u265E".encode("utf-8") : "\u2658".encode("utf-8")
          when :queen
            print cell.color == :white ? "\u265B".encode("utf-8") : "\u2655".encode("utf-8")
          when :king
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

  def save_grid file_route
    File.open file_route, 'w' do |file|
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


  #methods to check status of the game

  def check_if_check color = @color
    king = find_king color == :white ? :black : :white

    check_all_possible_moves(color).include? king
  end

  def check_if_mate 
    king = find_king @color == :white ? :black : :white

    
    @grid[king[0]][king[1]].possible_moves.empty?
  end


  def check_promotion 
    pawns = []
    if @color == :white
      pawn = @grid[7].find{|cell| cell.color == @color && cell.piece == :pawn}
      pawns << pawn.position unless pawn.nil?
    else
      pawn = @grid[0].find{|cell| cell.color == @color && cell.piece == :pawn}
      pawns << pawn.position unless pawn.nil?
    end
    pawns
  end

  def promote position
    loop do
      puts "Your pawn has been promoted! What would you like to turn it into? (ex queen)"
      new_piece = gets.chomp.downcase.to_sym

      if new_piece != :queen &&
         new_piece != :horse &&
         new_piece != :tower &&
         new_piece != :bishop

         puts "Enter a valid piece (queen, tower, bishop, horse)"
         next
      end

      create_piece new_piece, @color, position
      display_grid
      break
    end
  end



  def create_piece piece, color, position 
    case piece
      when :empty
        @grid[position[0]][position[1]] = VoidPiece.new position, self
      when :pawn
        @grid[position[0]][position[1]] = Pawn.new color, position, self
      when :rook
        @grid[position[0]][position[1]] = Rook.new color, position, self
      when :bishop
        @grid[position[0]][position[1]] = Bishop.new color, position, self
      when :knight
        @grid[position[0]][position[1]] = Knight.new color, position, self
      when :queen
        @grid[position[0]][position[1]] = Queen.new color, position, self
      when :king
        @grid[position[0]][position[1]] = King.new color, position, self
    end
  end

  private

  def check_input input
   if input.length != 2 || /[A-H]{1}/.match(input[0]).to_s != input[0] ||
                           /[1-8]{1}/.match(input[1]).to_s != input[1] 
      puts "Wrong format!"
      return false
   else
    return true
   end
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
  

  def print_possible_moves piece
    puts "Your possible moves are:"
    piece.possible_moves.each do |move|
      print "#{array_to_table(move).join('-')}\n"
    end
  end

end


