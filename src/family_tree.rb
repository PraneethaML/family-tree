class FamilyTree
	
	def add_child
		
	end

	def get_relationship
		
	end

	def get_gender
		
	end

	def get_siblings
		
	end

	def get_children
		
	end

	def get_paternal_uncle
		
	end

	def get_maternal_uncle
		
	end

	def get_paternal_aunt
		
	end

	def get_maternal_aunt
		
	end

	def get_member(member_name)
		anga.detect { |node|
			node.name.downcase == member_name.downcase 
		}
	end
end