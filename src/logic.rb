load 'family_tree.rb'
load 'create_shan_family_tree.rb'

class Logic
	
	def initialize(shan_family)
		if ARGV.length == 1
			filename = ARGV.first
			is_file_exists = File.file?(filename)
			if is_file_exists
				@shan_family = shan_family
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
    			 	child_added = @family_tree.add_child(params)
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
		@family_tree = FamilyTree.new(@shan_family)
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
shan_family = CreateShanFamilyTree.new('anga')
# create_basic_family(member1, member2, member2_gender, member2_relation_to_member1)
shan_family.create_basic_family('anga','shan','male','spouse')
shan_family.create_basic_family('anga','chit','male','child')
shan_family.create_basic_family('anga','ish','male','child')
shan_family.create_basic_family('anga','vich','male','child')
shan_family.create_basic_family('anga','aras','male','child')
shan_family.create_basic_family('anga','satya','male','child')
shan_family.create_basic_family('chit','amba','female','spouse')
shan_family.create_basic_family('vich','lika','female','spouse')
shan_family.create_basic_family('aras','chitra','female','spouse')
shan_family.create_basic_family('vyan','satya','male','spouse')
shan_family.create_basic_family('amba','dritha','female','child')
shan_family.create_basic_family('amba','tritha','female','child')
shan_family.create_basic_family('amba','vritha','male','child')
shan_family.create_basic_family('dritha','jaya','male','spouse')
shan_family.create_basic_family('lika','vila','female','child')
shan_family.create_basic_family('lika','chika','female','child')
shan_family.create_basic_family('chitra','jnki','female','child')
shan_family.create_basic_family('chitra','ahit','male','child')
shan_family.create_basic_family('jnki','arit','male','spouse')
shan_family.create_basic_family('satya','asva','male','child')
shan_family.create_basic_family('satya','vyas','male','child')
shan_family.create_basic_family('satya','atya','female','child')
shan_family.create_basic_family('dritha','yodhan','male','child')
shan_family.create_basic_family('asva','satvy','female','spouse')
shan_family.create_basic_family('vyas','krpi','female','spouse')
shan_family.create_basic_family('jnki','lavnya','female','child')
shan_family.create_basic_family('satvy','vasa','male','child')
shan_family.create_basic_family('krpi','kriya','male','child')
shan_family.create_basic_family('krpi','krithi','female','child')

# shan_family.print_tree
Logic.new(shan_family)

# shan_family.print_tree
end