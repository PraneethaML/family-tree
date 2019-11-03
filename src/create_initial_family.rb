# frozen_string_literal: true

require 'tree'

# creates basic family tree
class CreateInitialFamily
  def create_root(root)
    # rubocop:disable LineLength
    @root = Tree::TreeNode.new(root, { gender: 'female', relation: 'root', created_time: Time.now })
    # rubocop:enable LineLength
  end

  def create_basic_family(params)
    hash = {
      'member1': params[0],
      'member2': params[1],
      'member2_gender': params[2],
      'member2_relation_to_member1': params[3]
    }
    add_to_family(hash)
  end

  def get_root
    @root
  end
  
  private

  def add_to_family(hash)
    member1 = get_member(hash[:member1])
    begin
      # rubocop:disable LineLength
      member1 << Tree::TreeNode.new(hash[:member2], { gender: hash[:member2_gender], relation: hash[:member2_relation_to_member1], created_time: Time.now })
      # rubocop:enable LineLength
    rescue
      return false
    end
  end

  def get_member(member_name)
    @root.detect do |node|
      node.name.downcase == member_name.downcase
    end
  end

  def print_tree
    @root.print_tree
  end
end
