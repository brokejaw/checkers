class Game
  
  def initialize
    @board = Board.new
  end
  
  def play
    puts board.render
  end
  
  def display_board
    puts @board.print
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  puts b.print
  p b[[7,1]].color
end

=begin
perform_moves!(positions)
if slide => one slide
 if try to do anything else => error
  
  if jumping 
  take position -> perform jump
  recursively call perform_moves on remaining positions

  =====
  valid_moves?(positions)
  dups board
  calls perform_moves!
  return true if no errors raised
=end