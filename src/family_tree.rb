# frozen_string_literal: true

# Builds the family tree
class FamilyTree
  GENDER = {
    male: 'male',
    female: 'female'
  }.freeze

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
    is_node_added
  end

  def validate_input_relation(relation)
    # rubocop:disable LineLength
    valid_inputs = %w[Siblings Daughter Son Brother-In-Law Sister-In-Law Maternal-Aunt Paternal-Aunt Maternal-Uncle Paternal-Uncle]
    # rubocop:enable LineLength
    valid_inputs.include? relation
  end

  def get_relationship(params)
    person = params[0]
    relation = params[1]
    
    case relation
    when 'Siblings'
      siblings = get_siblings(person)
      print_output(siblings)
    when 'Daughter','Son'
      children = get_children(person, relation)
      print_output(children)
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
      puts 'Sorry! we will get back to you later'
    end
  end

  def get_member(member_name)
    @root.detect do |node|
      node.name.casecmp(member_name).zero?
    end
  end

  private

  def create_member(child_hash)
    mother = get_member(child_hash['mothers_name'])
    begin
      # rubocop:disable LineLength
      mother << Tree::TreeNode.new(child_hash['child_name'], { gender: child_hash['gender'], relation: child_hash['relation'], created_time: Time.now })
      # rubocop:enable LineLength
      return true
    rescue 
      return false
    end
  end

  def get_siblings(member_name)
    siblings = []
    all_siblings = get_member(member_name).siblings
    all_siblings.each do |sib|
      siblings << sib.name.capitalize if sib.content[:relation] == 'child'
    end
    siblings
  end

  def print_output(array)
    if array.empty?
      puts 'NONE'
    else
      puts array.join(' ')
    end
  end

  def get_children(member_name, relation)
    gender = GENDER[:male] if relation == 'Son'
    gender = GENDER[:female] if relation == 'Daughter'
    children = []
    all_children = get_member(member_name).children
    all_children.each do |node|
      # rubocop:disable LineLength
      children << node.name.capitalize if node.content[:relation] == 'child' && node.content[:gender] == gender
      # rubocop:enable LineLength
    end
    children
  end

  def get_uncles(parent)
    parent_siblings = parent.siblings
    uncles = []
    parent_siblings.each do |sibling|
      # rubocop:disable LineLength
      uncles << sibling.name.capitalize if sibling.content[:gender] == GENDER[:male] && sibling.content[:relation] == 'child'
      # rubocop:enable LineLength
    end
    uncles
  end

  def get_paternal_uncle(member_name)
    person = get_member(member_name)
    father = sofi.parent.parent if person.parent.content[:relation] == 'spouse'
    paternal_uncles = get_uncles(father)
    paternal_uncles
  end

  def get_maternal_uncle(member_name)
    person = get_member(member_name)
    mother = person.parent
    maternal_uncles = get_uncles(mother)
    maternal_uncles
  end

  def get_aunts(parent)
    parent_siblings = parent.siblings
    aunts = []
    parent_siblings.each do |sibling|
      # rubocop:disable LineLength
      aunts << sibling.name.capitalize if sibling.content[:gender] == GENDER[:female] && sibling.content[:relation] == 'child'
      # rubocop:enable LineLength
    end
    aunts
  end

  def get_paternal_aunt(member_name)
    person = get_member(member_name)
    # rubocop:disable LineLength
    father = person.parent.parent if person.parent.content[:relation] == 'spouse'
    # rubocop:enable LineLength
    paternal_aunts = get_aunts(father)
    paternal_aunts
  end

  def get_maternal_aunt(member_name)
    person = get_member(member_name)
    mother = person.parent
    maternal_aunts = get_aunts(mother)
    maternal_aunts
  end

  def brothers_sisters(member)
    siblings_nodes = member.siblings
    # rubocop:disable LineLength
    actual_siblings = siblings_nodes.select { |sibling| sibling.content[:relation] == 'child' }
    # rubocop:enable LineLength
    actual_siblings
  end

  def get_spouse(person)
    children_nodes = person.children
    spouse = children_nodes.select { |node| node.content[:relation] == 'spouse' }
    spouse.first
  end

  def relation_wrt_spouse(person)
    relatives = []
    spouse = person.parent
    brothers_sisters.each do |sibling|
      if sibling.content[:gender] == same_gender
        relatives << { name: sibling.name, time: sibling.content[:created_time] }
      elsif sibling.content[:gender] == opp_gender
        spouse = get_spouse(sibling)
        # rubocop:disable LineLength
        relatives << { name: spouse.name, time: spouse.content[:created_time] } if spouse.content[:gender] == same_gender
        # rubocop:enable LineLength
      end
    end
    relatives
  end

  def relation_wrt_child(person, opp_gender)
    relatives = []
    siblings = brothers_sisters(person)
    siblings.each do |s|
      if s.content[:gender] == opp_gender
        spouse = get_spouse(s)
        relatives << { name: spouse.name, time: spouse.content[:created_time] }
      end
    end
    relatives
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

    relatives1 = if person.content[:relation] == 'spouse'
                   relation_wrt_spouse(person, same_gender, opp_gender)
                 else
                   relation_wrt_child(person, opp_gender)
                 end
    relatives += relatives1
    sorted_relation = relatives.sort_by! { |k| k[:time] }
    sorted_relation_names = sorted_relation.map { |e| e[:name].capitalize }
    sorted_relation_names
  end
end
