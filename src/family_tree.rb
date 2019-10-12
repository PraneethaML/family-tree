class FamilyTree

	def initialize(tree)
		@tree = tree
		@root = tree.root
	end
	
	def add_child(params)
		puts "hey you are in add child function of family tree and params are #{params}"
	end

	def get_relationship(params)
		puts "hey you are in get get_relationship of family tree and params are #{params}"
	end

	# def get_gender
		
	# end

	# def get_siblings
		
	# end

	# def get_children
		
	# end

	# def get_paternal_uncle
		
	# end

	# def get_maternal_uncle
		
	# end

	# def get_paternal_aunt
		
	# end

	# def get_maternal_aunt
		
	# end

	def get_member(member_name)
		@root.detect { |node|
			node.name.downcase == member_name.downcase 
		}
	end
end