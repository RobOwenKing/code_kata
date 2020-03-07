# Create an empty board of given width and height
def create_board(rows, cols)
  board = []
  row = []
  cols.times { row << 0 }
  rows.times { board << row }
  board
end

# For a given cell, count its living neighbours
def cell_neighbours(board, x_index, y_index, rows, cols)
  cell_total = 0
  cell_total += board[y_index - 1][x_index - 1]
  cell_total += board[y_index - 1][x_index]
  cell_total += board[y_index - 1][(x_index + 1) % rows]
  cell_total += board[y_index][(x_index + 1) % rows]
  cell_total += board[(y_index + 1) % cols][(x_index + 1) % rows]
  cell_total += board[(y_index + 1) % cols][x_index]
  cell_total += board[(y_index + 1) % cols][x_index - 1]
  cell_total += board[y_index][x_index - 1]
  cell_total
end

# Produce a board with how many living neighbours each cell in the real board has
def total_neighbours(board, rows, cols)
  neighbours_board = []
  board.each_with_index do |row, y_index|
    neighbours_row = []
    row.each_with_index do |_cell, x_index|
      neighbours_row << cell_neighbours(board, x_index, y_index, rows, cols)
    end
    neighbours_board << neighbours_row
  end
  neighbours_board
end

def update_cell(current_state, neighbours)
  if current_state == 1
    neighbours < 2 || neighbours > 3 ? 0 : 1
  else
    neighbours == 3 ? 1 : 0
  end
end

def update_board(board, rows, cols)
  neighbours_board = total_neighbours(board, rows, cols)
  board.each_with_index do |row, y|
    row.each_with_index do |_col, x|
      board[y][x] = update_cell(board[y][x], neighbours_board[y][x])
    end
  end
  board
end
