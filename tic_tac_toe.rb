class Board
  attr_accessor :cells

  def initialize
    self.cells = [%w[empty empty empty], %w[empty empty empty], %w[empty empty empty]]
  end

  def display
    @cells.each_with_index do |row, index|
      puts row.join(' | ').gsub(/(empty)/, ' ').center(11) # Adjust the width as needed
      puts '---------'.center(11) if index < 2
    end
  end

  def move(location_row, location_column, player_symbol)
    if cells[location_row][location_column] == 'empty'
      cells[location_row][location_column] = player_symbol
      true
    else
      false
    end
  end

  def check_win
    # Check rows
    cells.each do |row|
      return true if row.all? { |cell| cell == 'X' } || row.all? { |cell| cell == 'O' }
    end
    # Check columns
    (0..2).each do |i|
      return true if cells.all? { |row| row[i] == 'X' } || cells.all? { |row| row[i] == 'O' }
    end
    # Check diagonals
    if cells[0][0] == cells[1][1] && cells[1][1] == cells[2][2] && (cells[0][0] == 'X' || cells[0][0] == 'O')
      return true
    end
    if cells[0][2] == cells[1][1] && cells[1][1] == cells[2][0] && (cells[0][2] == 'X' || cells[0][2] == 'O')
      return true
    end

    # No winner yet
    false
  end

  def full?
    cells.all? { |row| row.none? { |cell| cell == 'empty' } }
  end
end

class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    self.name = name
    self.symbol = symbol
  end
end

class Game
  attr_accessor :board, :players, :current_player

  def initialize(player1_name, player1_symbol, player2_name, player2_symbol)
    self.board = Board.new
    self.players = [Player.new(player1_name, player1_symbol), Player.new(player2_name, player2_symbol)]
    self.current_player = players[0]
  end

  def switch_players
    self.current_player = current_player == players[0] ? players[1] : players[0]
  end

  def start
    until board.full? || board.check_win
      board.display
      puts "#{current_player.name}'s turn:"
      puts 'Enter row (0-2):'
      row = gets.chomp.to_i
      puts 'Enter column (0-2):'
      column = gets.chomp.to_i
      if row.between?(0, 2) && column.between?(0, 2)
        if board.move(row, column, current_player.symbol)
          switch_players
        else
          puts 'Invalid move. Try again'
        end
      else
        puts 'Invalid input. Rows and columns need to be between 0 and 2.'
      end
    end

    board.display
    if board.check_win
      switch_players
      puts "Congratulations, #{current_player.name}! You just won the game."
    else
      puts "It's a draw!"
    end
  end
end
