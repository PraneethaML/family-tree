require 'tree'  
class FamilyTree

	def initialize(shan_family)
		@root = shan_family.get_root
	end

	def create_node(child_hash)
		mother = get_member(child_hash['mothers_name'])
		begin
			mother << Tree::TreeNode.new(child_hash['child_name'], {gender: child_hash['gender'], relation: child_hash['relation'], created_time: Time.now})
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
			get_children(person, 'female')
		when 'Son'
			get_children(person, 'male')
		when 'Brother-In-Law'
			get_sibling_in_law(person, 'brother')
		when 'Sister-In-Law'
			get_sibling_in_law(person, 'sister')
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

private

	def get_siblings(member_name)
		siblings = []
		all_siblings = get_member(member_name).siblings	
		all_siblings.each { |sib|
			siblings << sib.name.capitalize if sib.content[:relation] == 'child'		
		}
		if siblings.empty?
			puts "NONE"
		else
			puts siblings.join(' ')
		end
	end

	def get_children(member_name, gender)
		children = []
		all_children = get_member(member_name).children
		all_children.each { |node| 
			children << node.name.capitalize if node.content[:relation] == 'child' && node.content[:gender] == gender
		  }

		if children.empty?
			puts "NONE"
		else
			puts children.join(' ')
		end
	end
	
	def get_paternal_uncle(member_name)
		person = get_member(member_name)
		paternal_uncles = []
		if person.parent.content[:relation] == 'spouse'
			father = sofi.parent.parent
			uncles = father.siblings
			uncles.each do |uncle|
				paternal_uncles << uncle.name.capitalize if uncle.content[:gender] == 'male' && uncle.content[:relation] == 'child'
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
			maternal_uncles << uncle.name.capitalize if uncle.content[:gender] == 'male' && uncle.content[:relation] == 'child'
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
				paternal_aunts << aunt.name.capitalize if aunt.content[:gender] == 'female' && aunt.content[:relation] == 'child'
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
			maternal_aunts << aunt.name.capitalize if aunt.content[:gender] == 'female' && aunt.content[:relation] == 'child'
		}
		
		if maternal_aunts.empty?
			puts "NONE"
		else
			puts maternal_aunts.join(' ')
		end
	end

	def get_sibling_in_law(member_name, sibling)
			if sibling == 'brother'
				same_gender = 'male'
				opp_gender = 'female'
			elsif sibling == 'sister'
				same_gender = 'female'
				opp_gender = 'male'
			end
			sibling_in_laws = []
			person = get_member(member_name)

			if person.content[:relation] == 'spouse'
				spouse = person.parent
				spouse_sibllings = spouse.siblings
				spouse_sibllings.each { |s|
					if s.content[:gender] == same_gender && s.content[:relation] == 'child'
						sibling_in_laws << {name: s.name, time: s.content[:created_time]}
					elsif s.content[:gender] == opp_gender && s.content[:relation] == 'child'
							children_nodes = s.children
							children_nodes.each { |c|
								if c.content[:gender] == same_gender && c.content[:relation] == 'spouse'
									sibling_in_laws << {name: c.name, time: c.content[:created_time]}
								end
							  }
					end
				  }
			else
				siblings = person.siblings
				siblings.each { |s|
					if s.content[:gender] == opp_gender && s.content[:relation] == 'child'
						children_nodes = s.children
						children_nodes.each { |c|
							if c.content[:relation] == 'spouse' && c.content[:gender] == same_gender
								sibling_in_laws << {name: c.name, time: c.content[:created_time]}
							end
						  }
					end
				  }
			end	
			
			if sibling_in_laws.empty?
				puts "NONE"
			else
				sorted_sib_in_laws = sibling_in_laws.sort_by! { |k| k[:time]  }
				sorted_sibling_in_law_names = sorted_sibling_in_laws.map { |e| e[:name].capitalize  }
				puts sorted_sibling_in_law_names.join(' ')
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
					brother_in_laws << {name: s.name, time: s.content[:created_time]}
				elsif s.content[:gender] == 'female' && s.content[:relation] == 'child'
						children_nodes = s.children
						children_nodes.each { |c|
							if c.content[:gender] == 'male' && c.content[:relation] == 'spouse'
								brother_in_laws << {name: c.name, time: c.content[:created_time]}
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
							brother_in_laws << {name: c.name, time: c.content[:created_time]}
						end
					  }
				end
			  }
		end	
		
		if brother_in_laws.empty?
			puts "NONE"
		else
			sorted_bro_in_laws = brother_in_laws.sort_by! { |k| k[:time]  }
			sorted_brother_in_law_names = sorted_bro_in_laws.map { |e| e[:name].capitalize  }
			puts sorted_brother_in_law_names.join(' ')
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
					sister_in_laws << {name: s.name, time: s.content[:created_time]}
				elsif s.content[:gender] == 'male' && s.content[:relation] == 'child'
						children_nodes = s.children
						children_nodes.each { |c|
							if c.content[:gender] == 'female' && c.content[:relation] == 'spouse'
								sister_in_laws << {name: c.name, time: c.content[:created_time]}
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
							sister_in_laws << {name: c.name, time: c.content[:created_time]}
						end
					  }
				end
			  }
		end	
		
		if sister_in_laws.empty?
			puts "NONE"
		else
			sorted_sis_in_laws = sister_in_laws.sort_by! { |k| k[:time]  }
			sorted_sister_in_law_names = sorted_sis_in_laws.map { |e| e[:name].capitalize  }
			puts sorted_sister_in_law_names.join(' ')
		end
	end

	def get_member(member_name)
		@root.detect do |node|
			node.name.downcase == member_name.downcase 
		end
	end
end