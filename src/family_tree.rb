require 'tree'  
class FamilyTree

	GENDER={
		male: 'male',
		female: 'female'
	}

	def initialize(family)
		@root = family.get_root
	end

	def create_relation(params)
		create_relation_hash = {}
		create_relation_hash['mothers_name'] = params[0].downcase
		create_relation_hash['child_name'] = params[1].downcase
		create_relation_hash['gender'] = params[2].downcase
		create_relation_hash['relation'] = 'child'
		is_node_added = create_member(create_relation_hash)
		return is_node_added
	end

	def get_relationship(params)
		person = params[0]
		relation = params[1]
		case relation
		when 'Siblings'
      siblings = get_siblings(person)
      print_output(siblings)
		when 'Daughter'
			get_children(person, GENDER[:female])
		when 'Son'
			get_children(person, GENDER[:male])
		when 'Brother-In-Law','Sister-In-Law'
			get_relation_in_law(person, relation)
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

	def get_member(member_name)
		@root.detect do |node|
			node.name.downcase == member_name.downcase 
		end
	end

private

	def create_member(child_hash)
		mother = get_member(child_hash['mothers_name'])
		begin
			mother << Tree::TreeNode.new(child_hash['child_name'], {gender: child_hash['gender'], relation: child_hash['relation'], created_time: Time.now})
			return true
		rescue
			return false
		end
	end

	def get_siblings(member_name)
		siblings = []
		all_siblings = get_member(member_name).siblings	
		all_siblings.each { |sib|
			siblings << sib.name.capitalize if sib.content[:relation] == 'child'		
		}
    return siblings
	end

  def print_output(array)
    if array.empty?
      puts "NONE"
    else
      puts array.join(' ')
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
				paternal_uncles << uncle.name.capitalize if uncle.content[:gender] == GENDER[:male] && uncle.content[:relation] == 'child'
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
			maternal_uncles << uncle.name.capitalize if uncle.content[:gender] == GENDER[:male] && uncle.content[:relation] == 'child'
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
				paternal_aunts << aunt.name.capitalize if aunt.content[:gender] == GENDER[:female] && aunt.content[:relation] == 'child'
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
			maternal_aunts << aunt.name.capitalize if aunt.content[:gender] == GENDER[:female] && aunt.content[:relation] == 'child'
		}
		
		if maternal_aunts.empty?
			puts "NONE"
		else
			puts maternal_aunts.join(' ')
		end
	end

  def get_male_siblings(member_name)
    get_siblings(member_name)
  end

	def get_relation_in_law(member_name, relation)
    if relation == 'Brother-In-Law'
      same_gender = GENDER[:male]
      opp_gender = GENDER[:female]
    elsif relation == 'Sister-In-Law'
      same_gender = GENDER[:female]
      opp_gender = GENDER[:male]
    end
    relation_in_laws = []
    person = get_member(member_name)

    if person.content[:relation] == 'spouse'
      spouse = person.parent
      spouse_sibllings = spouse.siblings
      spouse_sibllings.each { |s|
        if s.content[:gender] == same_gender && s.content[:relation] == 'child'
          relation_in_laws << {name: s.name, time: s.content[:created_time]}
        elsif s.content[:gender] == opp_gender && s.content[:relation] == 'child'
            children_nodes = s.children
            children_nodes.each { |c|
              if c.content[:gender] == same_gender && c.content[:relation] == 'spouse'
                relation_in_laws << {name: c.name, time: c.content[:created_time]}
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
              relation_in_laws << {name: c.name, time: c.content[:created_time]}
            end
            }
        end
        }
    end 
    
    if relation_in_laws.empty?
      puts "NONE"
    else
      sorted_relation_in_laws = relation_in_laws.sort_by! { |k| k[:time]  }
      sorted_relation_in_law_names = sorted_relation_in_laws.map { |e| e[:name].capitalize  }
      puts sorted_relation_in_law_names.join(' ')
    end
  end
end