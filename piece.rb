class Piece
  attr_reader :color, :board
  attr_accessor :pos, :king
  
  SYMBOLS = {
    :red => "\u266c",
    :black => "\u260e"
  }
  
  def initialize(color, board, pos, king = false)
    @color, @board, @pos, @king = color, board, pos, king
    
    board.add_piece(self, pos)
  end
  
  def render
    SYMBOLS[color]
  end
  
  def perform_slide(from_pos, to_pos)
    
    if valid_to_pos?(to_pos) 
      board[to_pos], board[from_pos], pos = self, nil, to_pos
      maybe_promote(to_pos)
    end
    
   nil
  end

  def perform_jump(from_pos, to_pos)
  
    if valid_to_pos?(to_pos) && valid_jump?(from_pos, to_pos)
      
      jumped_pos= find_avg(from_pos, to_pos)
      board[to_pos] = self
      board[from_pos] = nil
      board[jumped_pos] = nil
      pos = to_pos
      
      maybe_promote(to_pos)
    end
    
    nil
  end
  
  def valid_jump?(from_pos, to_pos)
    jumped_piece = board[find_avg(from_pos, to_pos)]
  
    if jumped_piece.nil?
      raise "you must jump over an opponent"
    elsif jumped_piece.color != self.color
      raise "you cannot jump over an empty space"
    else
      true
    end
  end
  
  def maybe_promote(to_pos)
    king_row = color == :red ? 0 : 7
    
    king = true if king_row == to_pos.first
  end
  
  def find_avg(from_pos, to_pos)
    first_coord = (from_pos.first + to_pos.first) / 2
    second_coord = (from_pos.last + to_pos.last) / 2
    
    [first_coord, second_coord]
  end
  
  def valid_to_pos?(to_pos)
    raise "you can't move off the board" unless board.valid_pos?(to_pos)
    raise "you can't move into another piece" unless board.empty?(to_pos)
    raise "you can't move there" unless moves.include?(to_pos)
    
    true
  end
  
  def move_diffs
    if self.king
      move_diffs = [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
        [2, -2],
        [2, 2],
        [-2, -2]
      ]
    else
      if color == :red
        move_diffs = [[-1, 1], [-1, -1], [-2, -2], [-2, 2]]
      else
        move_diffs = [[1, -1], [1, 1], [2, -2], [2, 2]]
      end
    end
    
    move_diffs
  end
  
  def moves
    moves = []
    
    move_diffs.each do |(dx, dy)|
      cur_x, cur_y = pos
      pos = [cur_x + dx, cur_y + dy]
      
    moves << pos if board.empty?(pos)
    end
      
    moves  
  end
end