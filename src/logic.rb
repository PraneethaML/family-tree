class Logic
	
	def initialize
		if ARGV.length == 1
			filename = ARGV.first
			is_file_exists = File.file?(filename)
			puts filename
			puts is_file_exists
			if is_file_exists
				read_input(filename)
			else
				puts "File #{filename} does not exist"
			end
		else
			puts "Input filename must be given as an argument"
		end
	end

	def read_input(filename)
		
		# print no file found for invalid or no file available
		# read the file contents line by line if found

		puts "yay"

	end

	# def validate_input
		
	# end

	# def process_input
		
	# end
end

begin 
Logic.new
end