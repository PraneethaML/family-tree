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
	 	File.open("input.txt").each do |input|
	 		command, *params = input.split /\s/
    		is_valid_input = validate_input(command,params)
	 	end
	end

	def validate_input(command,params)
		@family_tree = FamilyTree.new
		case command
		when ADD_CHILD 
			if params.length != 3
				return false, "3 parameters required"
			else
				mother_name = params[0]
				child_name = params[1]
				child_gender = params[2]
				mother_node = @family_tree.validate_member(mother_name)
				
				return false if mother_node.nil?
				return false if mother_node.content[:gender] != 'female'

				return true		
			end
		when GET_RELATIONSHIP 
			puts "pass"
		else 
			return false, "Invalid input command"
		end
	end
end

begin 
Logic.new
end