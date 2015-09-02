=begin
	<--Psedocode-->
	Draw a board of nine squares

	Assign player1 to X 
	Assign player2 to y
	
	loop until a winner or all squares are taken
		Ask user to choose a position from 1 to 9
		Place the user's piece with an X
		Check for a winner
		Have computer place a random piece with an O
		Check for a winner

	If there's a winner
		Display winning message when three in row
	Or else
		It's a tie.

	<--Tips-->
	Check that square is empty
  
=end

player1 = "Player 1"
player2 = "Player 2"

def initialize_board
	board = {}
	(1..9).each {|position| board[position] = ' '}
	board
end


def draw_board(board)
	system 'clear'
	puts "#{board[1]} | #{board[2]} | #{board[3]}"
	puts "---------"
	puts "#{board[4]} | #{board[5]} | #{board[6]}"
	puts "---------"
	puts "#{board[7]} | #{board[8]} | #{board[9]}"
end

def empty_positions(board)
	board.select {|k, v| v == ' ' }.keys
end

def player_picks_square(board)
	begin
		puts "Pick a square (1 - 9):"
		position = gets.chomp.to_i
	end until empty_positions(board).include?(position)
	board[position] = 'X'
end

def nine_positions_filled?(board)
	empty_positions(board) == []
end

def computer_picks_square(board)
	position = empty_positions(board).sample
	board[position] = 'O'
end

def check_winner(board)
	winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
	winning_lines.each do |line|
		return "Player" if board.values_at(*line).count('X') == 3
		return "Computer" if board.values_at(*line).count('O') == 3
	end
	nil
end

board = initialize_board
draw_board(board)

begin
	player_picks_square(board)
	computer_picks_square(board)
	draw_board(board)
	winner = check_winner(board)
end until winner || nine_positions_filled?(board)

if winner
	puts "#{winner} won!"
else
	puts "There's a tie!"
end