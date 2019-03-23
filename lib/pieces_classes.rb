#ruby lib/pieces_classes.rb

module FreeMovement
  def vertical_moves position, parent, color
    possible = []
    possible_position = position

    while possible_position[0] > 0
      possible_position = [possible_position[0] -1, possible_position[1]]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = position

    while possible_position[0] < 7
      possible_position = [possible_position[0] +1, possible_position[1]]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == color
      possible << possible_position

      break unless grid_element.color.nil?
    end

    possible
  end

  def horizontal_moves position, parent, color
    possible = []
    possible_position = position

    while possible_position[1] > 0
      possible_position = [possible_position[0], possible_position[1] - 1]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = position

    while possible_position[1] < 7
      possible_position = [possible_position[0], possible_position[1] + 1]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    
    possible
  end

  def moves_diagonally_right position, parent, color
    possible = []
    possible_position = position

    while possible_position[0] > 0 && possible_position[1] > 0
      possible_position = [possible_position[0] -1, possible_position[1] - 1]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = position

    while possible_position[0] > 0 && possible_position[1] < 7
      possible_position = [possible_position[0] -1, possible_position[1] + 1]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end

    possible
  end 

  def moves_diagonally_left position, parent, color
    possible = []
    possible_position = position

    while possible_position[0] < 7 && possible_position[1] > 0
      possible_position = [possible_position[0] + 1, possible_position[1] - 1]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = position

    while possible_position[0] < 7 && possible_position[1] < 7 
      possible_position = [possible_position[0] + 1, possible_position[1] + 1]
      grid_element = parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == color
      possible << possible_position

      break unless grid_element.color.nil?
    end

    possible
  end
end

class VoidPiece
  attr_accessor :piece, :position, :color, :parent

  def initialize position, parent=nil
    @piece = :empty
    @color = nil
    @position = position
    @parent = parent
  end
end

class Pawn
  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :pawn
    @color = color
    @position = position
    @parent = parent
  end
  def possible_moves
    possible = []

    #check possible moves ahead, on the left and then on the right
    if color == :white
      
      unless check_edges[:top]
        if @parent.grid[@position[0]+1][@position[1]].color.nil?

          possible << [@position[0]+1, @position[1]]
          if position[0] == 1 &&
            @parent.grid[@position[0]+2][@position[1]].color.nil?

            possible << [@position[0]+2, @position[1]]
          end
        end
        
        if !check_edges[:left] &&
            @parent.grid[@position[0]+1][@position[1] - 1].color == :black

            possible << [@position[0]+1, @position[1] - 1]
        end
        if !check_edges[:right] &&
          @parent.grid[@position[0]+1][@position[1] + 1].color == :black

          possible << [@position[0]+1, @position[1] + 1]
        end
      end

    else
      unless check_edges[:bottom]

        if @parent.grid[@position[0]-1][@position[1]].color.nil?

          possible << [@position[0]-1, @position[1]]

          if position[0] == 6 && 
             @parent.grid[@position[0]-2][@position[1]].color.nil?
            

            possible << [@position[0]-2, @position[1]]
          end
        end
        
        if !check_edges[:left] &&
          @parent.grid[@position[0]-1][@position[1] - 1].color == :white

          possible << [@position[0]-1, @position[1] - 1]
        end
        if !check_edges[:right] &&
          @parent.grid[@position[0]-1][@position[1] + 1].color == :white

          possible << [@position[0]-1, @position[1] + 1]
        end
      end
    end

    possible
  end

  def check_attacking_positions
    possible = []
    if color == :white
      if !check_edges[:left]

        possible << [@position[0]+1, @position[1] - 1]  
      end
      if !check_edges[:right] 

        possible << [@position[0]+1, @position[1] + 1]
      end
    else
      if !check_edges[:left] 

        possible << [@position[0]-1, @position[1] - 1]
      end
      if !check_edges[:right] 

        possible << [@position[0]-1, @position[1] + 1]
      end
    end
    
    possible
  end

  private
  def check_edges
    edges = {top: false, right: false, bottom: false, left: false}
    edges[:top] = true if @position[0] == 7
    edges[:bottom] = true if @position[0] == 0
    edges[:right] = true if @position[1] == 7
    edges[:left] = true if @position[1] == 0
    edges
  end
end


class Rook
  include FreeMovement

  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :rook
    @color = color
    @position = position
    @parent = parent
  end
  def possible_moves

    possible = []

    vertical_moves(@position, @parent, @color).each do |move|
      possible << move
    end

    horizontal_moves(@position, @parent, @color).each do |move|
      possible << move
    end

    possible
  end
end

class Bishop
  include FreeMovement

  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :bishop
    @color = color
    @position = position
    @parent = parent
  end

  def possible_moves
    possible = []

    moves_diagonally_right(@position, @parent, @color).each do |move|
      possible << move
    end

    moves_diagonally_left(@position, @parent, @color).each do |move|
      possible << move
    end
    
    possible
  end
end

class Knight
  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :knight
    @color = color
    @position = position
    @parent = parent
  end

  def possible_moves
    possible = []
    
    possible << [@position[0]-1, @position[1]-2] if check_cell -1,-2
    possible << [@position[0]-2, @position[1]-1] if check_cell -2,-1
    possible << [@position[0]-2, @position[1]+1] if check_cell -2,+1
    possible << [@position[0]-1, @position[1]+2] if check_cell -1,+2
    possible << [@position[0]+1, @position[1]+2] if check_cell +1,+2
    possible << [@position[0]+2, @position[1]+1] if check_cell +2,+1
    possible << [@position[0]+2, @position[1]-1] if check_cell +2,-1
    possible << [@position[0]+1, @position[1]-2] if check_cell +1,-2
    possible
  end

  private

  def check_cell x,y
    return @position[0]+x >= 0 && @position[0]+x <= 7 &&
            @position[1]+y >= 0 && @position[1]+y <= 7 &&
            @parent.grid[@position[0]+x][@position[1]+y].color != @color
  end
end

class Queen
  include FreeMovement

  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :queen
    @color = color
    @position = position
    @parent = parent
  end

  def possible_moves
    possible = []
    possible_position = @position

    moves_diagonally_right(@position, @parent, @color).each do |move|
      possible << move
    end

    moves_diagonally_left(@position, @parent, @color).each do |move|
      possible << move
    end

    vertical_moves(@position, @parent, @color).each do |move|
      possible << move
    end

    horizontal_moves(@position, @parent, @color).each do |move|
      possible << move
    end
    
    possible
  end
end

class King
  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :king
    @color = color
    @position = position
    @parent = parent
  end

  def possible_moves stop = false
    possible = []

    possible << [@position[0] + 1, @position[1]]      if check_cell 1,0
    possible << [@position[0] + 1, @position[1] + 1]  if check_cell 1,1
    possible << [@position[0], @position[1] + 1]      if check_cell 0,1
    possible << [@position[0] - 1, @position[1] + 1]  if check_cell -1,1
    possible << [@position[0] - 1, @position[1]]      if check_cell -1,0
    possible << [@position[0] - 1, @position[1] - 1]  if check_cell -1,-1
    possible << [@position[0], @position[1] - 1]      if check_cell 0,-1
    possible << [@position[0] + 1, @position[1] - 1]  if check_cell 1,-1

    return possible if stop

    possible = possible.filter do |move|
      !@parent.check_all_possible_moves(@color == :white ? :black : :white).include?([move[0], move[1]])
    end

    possible
  end

  private

  def check_cell y,x
    position_y = @position[0] + y
    position_x = @position[1] + x

    return false if position_y > 7 || position_y < 0 ||
                    position_x > 7 || position_x < 0 ||
                    @parent.grid[position_y][position_x].color == @color

    return true
  end
end