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
		add_child_hash = {}
		add_child_hash['mothers_name'] = params[0].downcase
		add_child_hash['child_name'] = params[1].downcase
		add_child_hash['gender'] = params[2].downcase
		add_child_hash['relation'] = 'child'
		is_node_added = create_node(add_child_hash)
		return is_node_added
	end

	def get_relationship(params)
		person = params[0]
		relation = params[1]
		case relation
		when 'Siblings'
			get_siblings(person)
		when 'Daughter'
			get_daughter(person)
		when 'Son'
			get_son(person)
		when 'Brother-In-Law'
			get_brother_in_law(person)
		when 'Sister-In-Law'
			get_sister_in_law(person)
		when 'Maternal-Aunt'
			get_maternal_aunt(person)
		when 'Paternal-Aunt'
			get_paternal_aunt(person)
		when 'Maternal-Uncle'
			get_maternal_uncle(person)
		when 'Paternal-Uncle'
			get_paternal_uncle(person)
		else
			puts "Sorry! we will get back to you later"
		end
	end


	def get_siblings(member_name)
		siblings = []
		all_siblings = get_member(member_name).siblings	
		all_siblings.each { |sib|
			siblings << sib.name if sib.content[:relation] == 'child'		
		}
		if siblings.empty?
			puts "NONE"
		else
			puts siblings.join(' ')
		end
	end

	def get_daughter(member_name)
		daughters = []
		all_children = get_member(member_name).children
		all_children.each { |node| 
			daughters << node.name if node.content[:relation] == 'child' && node.content[:gender] == 'female'
		  }

		if daughters.empty?
			puts "NONE"
		else
			puts daughters.join(' ')
		end
	end

	def get_son(member_name)
		sons = []
		all_children = get_member(member_name).children
		all_children.each { |node| 
			sons << node.name if node.content[:relation] == 'child' && node.content[:gender] == 'male'
		  }

		if sons.empty?
			puts "NONE"
		else
			puts sons.join(' ')
		end
	end

	def get_paternal_uncle(member_name)
		person = get_member(member_name)
		paternal_uncles = []
		if person.parent.content[:relation] == 'spouse'
			father = sofi.parent.parent
			uncles = father.siblings
			uncles.each do |uncle|
				paternal_uncles << uncle.name if uncle.content[:gender] == 'male' && uncle.content[:relation] == 'child'
			end
		end
		if paternal_uncles.empty?
			puts "NONE"
		else
			puts paternal_uncles.join(' ')
		end

	end

	def get_maternal_uncle(member_name)
		person = get_member(member_name)
		maternal_uncles = []
		
		mother = person.parent
		uncles = mother.siblings
		uncles.each do |uncle|
			maternal_uncles << uncle.name if uncle.content[:gender] == 'male' && uncle.content[:relation] == 'child'
		end
		
		if maternal_uncles.empty?
			puts "NONE"
		else
			puts maternal_uncles.join(' ')
		end
	end

	def get_paternal_aunt(member_name)
		person = get_member(member_name)
		paternal_aunts = []
		if person.parent.content[:relation] == 'spouse'
			father = person.parent.parent
			aunts = father.siblings
			aunts.each do |aunt|
				paternal_aunts << aunt.name if aunt.content[:gender] == 'female' && aunt.content[:relation] == 'child'
			end
		end
		if paternal_uncles.empty?
			puts "NONE"
		else
			puts paternal_uncles.join(' ')
		end
	end

	def get_maternal_aunt(member_name)
		person = get_member(member_name)
		maternal_aunts = []
		mother = person.parent
		aunts = mother.siblings
		aunts.each { |aunt|
			maternal_aunts << aunt.name if aunt.content[:gender] == 'female' && aunt.content[:relation] == 'child'
		}
		
		if maternal_aunts.empty?
			puts "NONE"
		else
			puts maternal_aunts.join(' ')
		end
	end

	def get_brother_in_law(member_name)
		brother_in_laws = []
		person = get_member(member_name)

		if person.content[:relation] == 'spouse'
			# spouse brothers and spouse_siters_wives
			spouse = person.parent
			spouse_sibllings = spouse.siblings
			spouse_sibllings.each { |s|
				if s.content[:gender] == 'male' && s.content[:relation] == 'child'
					brother_in_laws << s.name
				elsif s.content[:gender] == 'female' && s.content[:relation] == 'child'
						children_nodes = s.children
						children_nodes.each { |c|
							if c.content[:gender] == 'male' && c.content[:relation] == 'spouse'
								brother_in_laws << c.name
							end
						  }
				end
			  }
		else
			# siter_husbands
			siblings = person.siblings
			siblings.each { |s|
				if s.content[:gender] == 'female' && s.content[:relation] == 'child'
					children_nodes = s.children
					children_nodes.each { |c|
						if c.content[:relation] == 'spouse' && c.content[:gender] == 'male'
							brother_in_laws << c.name
						end
					  }
				end
			  }
		end	
		
		if brother_in_laws.empty?
			puts "NONE"
		else
			puts brother_in_laws.join(' ')
		end
	end

	def get_sister_in_law(member_name)
		sister_in_laws = []
		person = get_member(member_name)

		if person.content[:relation] == 'spouse'
			# spouse sisters and spouse_brothers_wives
			spouse = person.parent
			spouse_sibllings = spouse.siblings
			spouse_sibllings.each { |s|
				if s.content[:gender] == 'female' && s.content[:relation] == 'child'
					sister_in_laws << s.name
				elsif s.content[:gender] == 'male' && s.content[:relation] == 'child'
						children_nodes = s.children
						children_nodes.each { |c|
							if c.content[:gender] == 'female' && c.content[:relation] == 'spouse'
								sister_in_laws << c.name
							end
						  }
				end
			  }
		else
			# brothers_wives
			siblings = person.siblings
			siblings.each { |s|
				if s.content[:gender] == 'male' && s.content[:relation] == 'child'
					children_nodes = s.children
					children_nodes.each { |c|
						if c.content[:relation] == 'spouse' && c.content[:gender] == 'female'
							sister_in_laws << c.name
						end
					  }
				end
			  }
		end	
		
		if sister_in_laws.empty?
			puts "NONE"
		else
			puts sister_in_laws.join(' ')
		end
	end

	def get_member(member_name)
		@root.detect do |node|
			node.name.downcase == member_name.downcase 
		end
	end
end