#ruby lib/pieces_classes.rb
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
  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :rook
    @color = color
    @position = position
    @parent = parent
  end
  def possible_moves
    possible = []
    possible_position = @position

    while possible_position[0] > 0
      possible_position = [possible_position[0] -1, possible_position[1]]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position

    while possible_position[0] < 7
      possible_position = [possible_position[0] +1, possible_position[1]]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position

    while possible_position[1] > 0
      possible_position = [possible_position[0], possible_position[1] - 1]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position

    while possible_position[1] < 7
      possible_position = [possible_position[0], possible_position[1] + 1]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position
    
    possible
  end
end

class Bishop
  attr_accessor :piece, :color, :position, :grid, :parent

  def initialize color, position, parent=nil
    @piece = :bishop
    @color = color
    @position = position
    @parent = parent
  end

  def possible_moves
    possible = []
    possible_position = @position

    while possible_position[0] > 0 && possible_position[1] > 0
      possible_position = [possible_position[0] -1, possible_position[1] - 1]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position

    while possible_position[0] > 0 && possible_position[1] < 7
      possible_position = [possible_position[0] -1, possible_position[1] + 1]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position

    while possible_position[0] < 7 && possible_position[1] > 0
      possible_position = [possible_position[0] + 1, possible_position[1] - 1]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position

    while possible_position[0] < 7 && possible_position[1] < 7 
      possible_position = [possible_position[0] + 1, possible_position[1] + 1]
      grid_element = @parent.grid[possible_position[0]][possible_position[1]]
      
      break if grid_element.color == @color
      possible << possible_position

      break unless grid_element.color.nil?
    end
    possible_position = @position
    
    possible
  end
end