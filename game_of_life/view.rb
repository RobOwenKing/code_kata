require_relative 'game_of_life.rb'

# Print a board nicely in the terminal
def puts_board(board)
  board_rows_joined = board.map { |row| row.join(' ') }
  puts board_rows_joined.join("\n")
end

# toad = [[0, 1, 0], [1, 0, 1], [0, 1, 0]]

blinker = [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 1, 1, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]

def loop(board)
  puts_board(board)
  new_turn = 'y'
  while new_turn == 'y'
    board = update_board(board, 5, 5)
    puts_board(board)
    puts 'Loop? [y/n]'
    new_turn = gets.chomp.downcase
  end
end

loop(blinker)
