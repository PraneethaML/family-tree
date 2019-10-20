require 'tree'   
class CreateInitialFamily
	def initialize(root)
		@root = Tree::TreeNode.new(root, {gender: 'female', relation: 'root', created_time: Time.now})
		
	end

	def add_to_family(hash)
		member1 = get_member(hash[:member1])
		begin
			member1 << Tree::TreeNode.new(hash[:member2], {gender: hash[:member2_gender], relation: hash[:member2_relation_to_member1], created_time: Time.now})
		rescue
			return false
		end
	end

	def create_basic_family(member1, member2, member2_gender, member2_relation_to_member1)
		hash = {
			'member1': member1,
			'member2': member2,
			'member2_gender': member2_gender,
			'member2_relation_to_member1': member2_relation_to_member1
		}
		add_to_family(hash)
	end

	def get_member(member_name)
		@root.detect { |node|
			node.name.downcase == member_name.downcase 
		}
	end

	def print_tree
		@root.print_tree
	end

	def get_root
		@root
	end
end