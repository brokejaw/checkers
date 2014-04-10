require './piece.rb'
require 'debugger'

class Board
  
  def initialize(fill_board = true)
    make_starting_grid(fill_board)
  end
   
  def pieces
    @rows.flatten.compact
  end
  
  def add_piece(piece, pos)
    self[pos] = piece
  end
   
  def print
    @rows.map do |row|
      row.map do |piece|
        piece.nil? ? "_" : piece.render
      end.join
    end.join("\n")
  end
  
  def [](pos)
    i, j = pos
    
    @rows[i][j]
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def dup
    duped_board = Board.new(false)
    
    pieces.each do |piece|
      piece.class.new(piece.color, duped_board, piece.pos, piece.king)
    end
    
    duped_board
  end
  
  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end
  
  def []=(pos, piece)
    i, j = pos
    @rows[i][j] = piece
  end
  
  protected
  
  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8) }
    
    if fill_board
      [:red, :black].each { |color| fill_side(color) }
    end
  end
  
  def fill_side(color)
    i = (color == :black) ? [0,1,2] : [7,6,5]
    
    i.each do |i|
      8.times do |j| 
        if (i + j).even?
          Piece.new(color, self, [i, j])
        end
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  # debugger
  b[[5,1]].perform_jump([5,1], [4, 2])
  p b[[4,2]].color
end