require 'rspec'
require '../src/create_shan_family_tree.rb'

RSpec.describe CreateShanFamilyTree do
  it 'creates a CreateShanFamilyTree class' do
    shan_family = CreateShanFamilyTree.new('root_name')
    expect(shan_family).to be_kind_of(CreateShanFamilyTree)
  end

  it 'adds to family' do
  	shan_family = CreateShanFamilyTree.new('root_name')
  	expect(shan_family).to respond_to(:add_to_family)
  	member1 = 'root_name'
  	hash = {
			'member1': member1,
			'member2': 'member2',
			'member2_gender': 'male',
			'member2_relation_to_member1': 'child'
		}
 	expect(shan_family.add_to_family(hash)).to be_kind_of(Tree::TreeNode)
 	member1 = 'member1'
 	expect(shan_family.add_to_family(hash)).to be false
  end

  it 'creates basic family' do
  	shan_family = CreateShanFamilyTree.new('root_name')
  	expect(shan_family).to respond_to(:create_basic_family)
  end

  it 'gets member' do
  	shan_family = CreateShanFamilyTree.new('root_name')
  	expect(shan_family).to respond_to(:get_member)
  	# return member object if exists
  	expect(shan_family.get_member('root_name')).to be_kind_of(Tree::TreeNode)
  	# return nil incase member doesn't exist
  	expect(shan_family.get_member('rut_name')).to be_nil
  end

  it 'gets root' do
  	shan_family = CreateShanFamilyTree.new('root_name')
  	expect(shan_family).to respond_to(:get_root)
  	expect(shan_family.get_root).to be_kind_of(Tree::TreeNode)
  end
end