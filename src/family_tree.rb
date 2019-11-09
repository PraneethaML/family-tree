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
    required_relatives = []
    case params[1]
    when 'Siblings'
      required_relatives = get_siblings(params[0])
    when 'Daughter', 'Son'
      required_relatives = get_children(params[0], params[1])
    when 'Brother-In-Law', 'Sister-In-Law'
      required_relatives = get_relation(params[0], params[1])
    when 'Maternal-Aunt'
      required_relatives = get_maternal_aunt(params[0])
    when 'Paternal-Aunt'
      required_relatives = get_paternal_aunt(params[0])
    when 'Maternal-Uncle'
      required_relatives = get_maternal_uncle(params[0])
    when 'Paternal-Uncle'
      required_relatives = get_paternal_uncle(params[0])
    else
      required_relatives
    end
    print_output(required_relatives)
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
    begin
      all_siblings = get_member(member_name).siblings
      all_siblings.each do |sib|
        siblings << sib.name.capitalize if sib.content[:relation] == 'child'
      end
    rescue
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
    begin
      all_children = get_member(member_name).children
      all_children.each do |node|
        # rubocop:disable LineLength
        children << node.name.capitalize if node.content[:relation] == 'child' && node.content[:gender] == gender
        # rubocop:enable LineLength
      end
    rescue
    end
    children
  end

  def get_uncles(parent)
    uncles = []
    begin
      parent_siblings = parent.siblings
      parent_siblings.each do |sibling|
        # rubocop:disable LineLength
        uncles << sibling.name.capitalize if sibling.content[:gender] == GENDER[:male] && sibling.content[:relation] == 'child'
        # rubocop:enable LineLength
      end
    rescue
    end
    uncles
  end

  def get_paternal_uncle(member_name)
    begin
      person = get_member(member_name)
      father = sofi.parent.parent if person.parent.content[:relation] == 'spouse'
    rescue
    end
    paternal_uncles = get_uncles(father)
    paternal_uncles
  end

  def get_maternal_uncle(member_name)
    begin
      person = get_member(member_name)
      mother = person.parent
    rescue
    end
    maternal_uncles = get_uncles(mother)
    maternal_uncles
  end

  def get_aunts(parent)
    aunts = []
    begin
      parent_siblings = parent.siblings
      parent_siblings.each do |sibling|
        # rubocop:disable LineLength
        aunts << sibling.name.capitalize if sibling.content[:gender] == GENDER[:female] && sibling.content[:relation] == 'child'
        # rubocop:enable LineLength
      end
    rescue
    end
    aunts
  end

  def get_paternal_aunt(member_name)
    begin
      person = get_member(member_name)
      # rubocop:disable LineLength
      father = person.parent.parent if person.parent.content[:relation] == 'spouse'
      # rubocop:enable LineLength
    rescue
    end
    paternal_aunts = get_aunts(father)
    paternal_aunts
  end

  def get_maternal_aunt(member_name)
    begin
      person = get_member(member_name)
      mother = person.parent
    rescue
    end
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
        # rubocop:disable LineLength
        relatives << { name: sibling.name, time: sibling.content[:created_time] }
        # rubocop:enable LineLength
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
