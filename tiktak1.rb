require "byebug"

class Tiktak
	POSIBLITIES = ['X', 'O']
	def initialize
		@screen = [['_', '_', '_'], ['_', '_', '_'], ['_', '_', '_']]
		while 1
			show
			row, column = user_input
			@screen[row][column] = 'X'
			break if win_checker
			break if game_draw==false
			computer
			break if win_checker
		end
	end
  
  def game_draw
  	temp=@screen.any? { |row|  row.include?('_')  }
  	if temp==false
  		puts 'match is draw'
  	end
  	return temp
  	
  end
	def show
		@screen.each do |matrix|
			matrix.each_with_index do |value, inx|
				print(value)
				print(' | ') if inx != 2
			end
			puts
		end
	end

	def user_input
		puts("Mr (X) please take your chance by row and column")
		print("Enter row no: ")
		row = gets.chomp.to_i
		print("Enter column no: ")
		column = gets.chomp.to_i
		return [row, column]
	end

	def win_checker
		row, column, digonal = checking_row, checking_column, checking_digonal
		if POSIBLITIES.include?(row)
			puts("Player #{row} win!")
			return true
		elsif POSIBLITIES.include?(column)
			puts("Player #{column} win!")
			return true
		elsif POSIBLITIES.include?(digonal)
			puts("Player #{digonal} win!")
			return true
		end
	end

	def checking_row
		flag = @screen.any? { |row| row.uniq.count == 1 && (row.uniq[0] == 'X' || row.uniq[0] == 'O') }
		@screen[0].uniq[0] if flag
	end

	def checking_column
		(0..2).each do |column|
			return @screen[0][column] if @screen[1][column] != '_' && @screen[0][column] == @screen[1][column] && @screen[1][column] == @screen[2][column]
		end
	end

	def checking_digonal
	  if @screen[0][0] != '_' && @screen[0][0] == @screen[1][1] && @screen[1][1] == @screen[2][2] 
	  	@screen[0][0]
	  elsif @screen[0][2] != '_' && @screen[0][2] == @screen[1][1] && @screen[1][1] == @screen[2][0]
	  	@screen[2][0]
	  end
	end

	def computer
		row, column = ai_prediction
		@screen[row][column] = 'O'
	end

	def ai_prediction
		# human_win_stopper
		for_computer_win

	end

	def human_win_stopper
		row, column, digonal = row_prediction, column_prediction, digonal_prediction

		if row&.count == 2
			row
		elsif column&.count == 2
			column
		elsif digonal&.count == 2
			digonal
		else
			# for_computer_win
			check_valid_move
		end
	end

	def row_prediction
		@screen.each_with_index { |row, inx| return [inx, row.index('_')] if row.count('X') == 2 && row.include?('_') }
	end

	def column_prediction
		(0..2).each do |column|
			row = [@screen[0][column], @screen[1][column], @screen[2][column]]

			return [row.index('_'), column] if row.count('X') == 2 && row.include?('_')
		end
	end

	def digonal_prediction
		row1=[@screen[0][0],@screen[1][1],@screen[2][2]]
		row2=[@screen[0][2],@screen[1][1],@screen[2][0]]
	  if row1.count('X')==2 && row1.include?('_')
	  	return [row1.index('_'),row1.index('_')]
	  elsif row2.count('X')==2 && row2.include?('_')
	  	temp1=row2.index('_')
	  	temp2=temp1==1?1 : temp1==0 ? 2 : 0
	  	return [temp1,temp2]
	  end
	end

	def for_computer_win
		# row, column, digonal = row_prediction, column_prediction, digonal_prediction
		row,col,digonal=cwin_row_prediction,cwin_column_prediction,cwin_diagonal_prediction
		if row&.count == 2
			row
		elsif col&.count == 2
			col
		elsif digonal&.count == 2
			digonal
		else
			# check_valid_move
			human_win_stopper
		end

	end

	def check_valid_move
		@screen.each_with_index { |row,inx| return [inx,row.index('_')]    if row.include?('_')  }
	end

	def cwin_row_prediction
		@screen.each_with_index{ |row,inx| return [inx,row.index('_')]   if row.count('O')==2&&row.include?('_')}
	end

	def cwin_column_prediction
		(0..2).each do |col|
			row=[@screen[0][col],@screen[1][col],@screen[2][col]]
			return [row.index('_'),col]  if row.count('O')==2&&row.include?('_')
		end
	end

	def cwin_diagonal_prediction
		row1=[@screen[0][0],@screen[1][1],@screen[2][2]]
		row2=[@screen[0][2],@screen[1][1],@screen[2][0]]
	  if row1.count('O')==2 && row1.include?('_')
	  	return [row1.index('_'),row1.index('_')]
	  elsif row2.count('O')==2 && row2.include?('_')
	  	temp1=row2.index('_')
	  	temp2=temp1==1?1 : temp1==0 ? 2 : 0
	  	return [temp1,temp2]
	  end
	end

end


Tiktak.new