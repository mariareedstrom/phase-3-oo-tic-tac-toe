require 'pry'

class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @board =Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(str)
    if str =~ /[1-9]/
       @mark = str.to_i - 1
    else raise InvalidInput
    end
  end

  def move(input, token = 'X')
    @board[input] = token
  end

  def position_taken?(index)
    @board[index.to_i] == "X" or @board[index.to_i] == "O"
  end

  def valid_move?(index)
     !position_taken?(index) and @board[index]
  end

  def turn_count
    count = 0
    @board.each {|i| count += 1 if i == 'X' or i == 'O'}
    count
  end

  def current_player
    if turn_count.even?
      'X'
    else
      'O'
    end
  end

  def turn
    puts 'Enter position between 1-9'
    choice = gets.chomp
    # rescue block around input
    begin
      position = input_to_index(choice)
    rescue InvalidInput
      turn
    else
      player = current_player

      if valid_move?(position)
        move(position, player)
        display_board
      else
        turn
      end
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
        @board[combo[1]] == @board[combo[2]] &&
        position_taken?(combo[0])
    end
  end

  def full?
    @board.all? {|token| token == 'X' || token == 'O'}
  end

  def draw?
    if won?
      false
      else full?
    end
  end

  def over?
     won? || full? || draw?
  end

  def winner
    if (winning_combo = won?)
      @board[winning_combo.first]
    end
  end

  def play
    until over?
      turn
    end
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end


  private

  class InvalidInput < StandardError
  end

end


