require 'tree'  
class FamilyTree

	def initialize(shan_family)
		@root = shan_family.get_root
	end

	def create_node(hash)
		mother = get_member(hash['mothers_name'])
		begin
			mother << Tree::TreeNode.new(hash['child_name'], {gender: hash['gender'], relation: hash['relation']})
			return true
		rescue
			return false
		end
	end
	
	def add_child(params)
		puts "hey you are in add child function of family tree and params are #{params}"
		add_child_hash = {}
		add_child_hash['mothers_name'] = params[0].downcase
		add_child_hash['child_name'] = params[1].downcase
		add_child_hash['gender'] = params[2].downcase
		add_child_hash['relation'] = 'child'
		is_node_added = create_node(add_child_hash)
		return is_node_added
	end

	def get_relationship(params)
		puts "hey you are in get get_relationship of family tree and params are #{params}"
	end


	def get_siblings(member_name)
		all_siblings = get_member(member_name).siblings


		
	end

	def get_children(member_name)
		all_children = get_member(member_name).children
	end

	def get_paternal_uncle(member_name)
		
	end

	def get_maternal_uncle(member_name)
		
	end

	def get_paternal_aunt(member_name)
		
	end

	def get_maternal_aunt(member_name)
		
	end

	def get_member(member_name)
		@root.detect { |node|
			node.name.downcase == member_name.downcase 
		}
	end
end