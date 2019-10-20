require 'rspec'
require '../src/family_tree.rb'
require '../src/create_initial_family.rb'

RSpec.describe FamilyTree do

  it 'creates a FamilyTree class' do
    family = CreateInitialFamily.new
    tree = FamilyTree.new(family)
    expect(tree).to be_kind_of(FamilyTree)
  end

  it 'creates relation' do
    family = CreateInitialFamily.new
    family.create_root('root_name')
    tree = FamilyTree.new(family)
    expect(tree).to respond_to(:create_relation)
    
    params = ['Anga', 'Vich', 'male']
    value = tree.create_relation(params)
    expect(value).to be false
    
    params = ['root_name', 'Vich', 'male']
    value = tree.create_relation(params)
    expect(value).to be true
  end

  it 'gets relationship' do
    family = CreateInitialFamily.new
    tree = FamilyTree.new(family)
    expect(tree).to respond_to(:get_relationship)	
  end

 
  it 'gets members' do
    family = CreateInitialFamily.new
    family.create_root('root_name')
    tree = FamilyTree.new(family)
    expect(tree).to respond_to(:get_member)
    # return member object if exists
    expect(tree.get_member('root_name')).to be_kind_of(Tree::TreeNode)
    # return nil incase member doesn't exist
    expect(tree.get_member('rut_name')).to be_nil
  end
end