load 'src/family_tree.rb'
load 'src/create_initial_family.rb'

class InputProcessor
	
	def initialize()
		if ARGV.length == 1
			filename = ARGV.first
			is_input_file_exists = File.file?(filename)
			if is_input_file_exists
				@family = create_initial_family
				process_input(filename)
			else
				puts "File #{filename} does not exist"
			end
		else
			puts "Input filename must be given as an argument"
		end
	end
	
private

	def create_initial_family	
		basic_family_file = File.file?('basic_family.txt')
		if !basic_family_file
			puts "Cannot create initial family. Need basic_family.txt to create it"
			exit
		end
		queen = CreateInitialFamily.new
		File.open('basic_family.txt').each do |input|
			command, *params = input.split /\s/
			case command
			when 'create_root'
				queen.create_root(params[0])
			when 'create_basic_family'
				queen.create_basic_family(params)
			else
				puts "Not a valid command while creating basic family"
			end
		end
		return queen
	end

	def process_input(filename)
	 	File.open(filename).each do |input|
	 		command, *params = input.split /\s/
    		is_valid_input, message = validate_input(command,params)
    		if is_valid_input
    			case command
    			 when 'ADD_CHILD'
    			 	child_added = @family_tree.create_relation(params)
    			 	if child_added
    			 		puts "CHILD_ADDITION_SUCCEEDED"
    			 	else
    			 		puts message
    			 	end
    			 when 'GET_RELATIONSHIP'
    			 	@family_tree.get_relationship(params)
    			 end			
    		else 
    			puts message
    		end
	 	end
	end

	def validate_input(command,params)
		@family_tree = FamilyTree.new(@family)
		case command
		when 'ADD_CHILD' 
			if params.length != 3
				return false, "3 parameters required"
			else
				mother_name = params[0]
				child_name = params[1]
				child_gender = params[2]
				mother_node = @family_tree.get_member(mother_name)
				
				return false, "PERSON_NOT_FOUND" if mother_node.nil?
				return false, "CHILD_ADDITION_FAILED" if mother_node.content[:gender] != 'female'

				return true	
			end
		when 'GET_RELATIONSHIP' 
			person = @family_tree.get_member(params[0])
			return false, "PERSON_NOT_FOUND" if person.nil?

			return true
		else 
			return false, "Invalid input command"
		end
	end
end

begin 
	InputProcessor.new
end