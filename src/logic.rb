load 'family_tree.rb'
load 'create_shan_family_tree.rb'

class Logic
	
	def initialize(tree)
		if ARGV.length == 1
			filename = ARGV.first
			is_file_exists = File.file?(filename)
			if is_file_exists
				@tree = tree
				process_input(filename)
			else
				puts "File #{filename} does not exist"
			end
		else
			puts "Input filename must be given as an argument"
		end
	end

	def process_input(filename)
	 	File.open(filename).each do |input|
	 		command, *params = input.split /\s/
    		is_valid_input, message = validate_input(command,params)
    		if is_valid_input
    			case command
    			 when 'ADD_CHILD'
    			 	@family_tree.add_child(params)
    			 when 'GET_RELATIONSHIP'
    			 	@family_tree.get_relationship(params)
    			 end			
    		else 
    			puts message
    		end
	 	end
	end

	def validate_input(command,params)
		@family_tree = FamilyTree.new(@tree)
		case command
		when 'ADD_CHILD' 
			if params.length != 3
				return false, "3 parameters required"
			else
				mother_name = params[0]
				child_name = params[1]
				child_gender = params[2]
				mother_node = @family_tree.get_member(mother_name)
				
				return false, "CHILD_ADDITION_FAILED" if mother_node.nil?
				return false, "CHILD_ADDITION_FAILED" if mother_node.content[:gender] != 'female'

				return true	
			end
		when 'GET_RELATIONSHIP' 
			return true
		else 
			return false, "Invalid input command"
		end
	end
end

begin 
c = CreateShanFamilyTree.new
tree = c.create_basic_tree
Logic.new(tree)
end