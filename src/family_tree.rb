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

  def validate_input_relation(relation)
    valid_inputs = ['Siblings', 'Daughter', 'Son', 'Brother-In-Law', 'Sister-In-Law', 'Maternal-Aunt', 'Paternal-Aunt', 'Maternal-Uncle', 'Paternal-Uncle' ] 
    
    valid_inputs.include? relation
  end

	def get_relationship(params)
		person = params[0]
		relation = params[1]
    
		case relation
		when 'Siblings'
      siblings = get_siblings(person)
      print_output(siblings)
		when 'Daughter'
			daughters = get_children(person, GENDER[:female])
      print_output(siblings)
		when 'Son'
			sons = get_children(person, GENDER[:male])
      print_output(sons)
		when 'Brother-In-Law','Sister-In-Law'
		  relations = get_relation(person, relation)
      print_output(relations)
		when 'Maternal-Aunt'
			maternal_aunts = get_maternal_aunt(person)
      print_output(maternal_aunts)
		when 'Paternal-Aunt'
			paternal_aunts = get_paternal_aunt(person)
      print_output(paternal_aunts)
		when 'Maternal-Uncle'
			maternal_uncles = get_maternal_uncle(person)
      print_output(maternal_uncles)
		when 'Paternal-Uncle'
			paternal_uncles = get_paternal_uncle(person)
      print_output(paternal_uncles)
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
    return children
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
		return paternal_uncles
	end

	def get_maternal_uncle(member_name)
		person = get_member(member_name)
		maternal_uncles = []
		
		mother = person.parent
		uncles = mother.siblings
		uncles.each do |uncle|
			maternal_uncles << uncle.name.capitalize if uncle.content[:gender] == GENDER[:male] && uncle.content[:relation] == 'child'
		end
		return maternal_uncles
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
		return paternal_aunts
	end

	def get_maternal_aunt(member_name)
		person = get_member(member_name)
		maternal_aunts = []
		mother = person.parent
		aunts = mother.siblings
		aunts.each { |aunt|
			maternal_aunts << aunt.name.capitalize if aunt.content[:gender] == GENDER[:female] && aunt.content[:relation] == 'child'
		}
		return maternal_aunts
	end

  def brothers_sisters(member)
    siblings_nodes = member.siblings 
    actual_siblings = siblings_nodes.select{|member| member.content[:relation] == 'child'}
    return actual_siblings
  end

  def get_spouse(person)
    children_nodes = person.children
    spouse = children_nodes.select{|node| node.content[:relation] == 'spouse'}
    return spouse.first
  end

  def relation_wrt_spouse(person)
    relatives = []
    spouse = person.parent
    brothers_sisters.each { |s|
      if s.content[:gender] == same_gender
        relatives << {name: s.name, time: s.content[:created_time]}
      elsif s.content[:gender] == opp_gender 
        spouse = get_spouse(s)
        relatives << {name: spouse.name, time: spouse.content[:created_time]} if spouse.content[:gender] == same_gender
      end
      }
    return relatives
  end

  def relation_wrt_child(person, same_gender, opp_gender)
    relatives = []
    siblings = brothers_sisters(person)
    siblings.each { |s|
      if s.content[:gender] == opp_gender 
        spouse = get_spouse(s)
        relatives << {name: spouse.name, time: spouse.content[:created_time]}
      end
      }
    return relatives
  end

	def get_relation(member_name, relation)
    if relation == 'Brother-In-Law'
      same_gender = GENDER[:male]
      opp_gender = GENDER[:female]
    elsif relation == 'Sister-In-Law'
      same_gender = GENDER[:female]
      opp_gender = GENDER[:male]
    end
    relatives = []
    person = get_member(member_name)

    if person.content[:relation] == 'spouse'
      relatives_1 = relation_wrt_spouse(person,same_gender. opp_gender) 
      relatives = relatives + relatives_1 
    else
      relatives_2 = relation_wrt_child(person, same_gender, opp_gender)
      relatives = relatives + relatives_2
    end 
    sorted_relation = relatives.sort_by! { |k| k[:time]  }
    sorted_relation_names = sorted_relation.map { |e| e[:name].capitalize  }
    return sorted_relation_names
  end
end