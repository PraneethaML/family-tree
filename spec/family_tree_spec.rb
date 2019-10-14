require 'rspec'
require '../src/family_tree.rb'
require '../src/create_shan_family_tree.rb'

RSpec.describe FamilyTree do

  it 'creates a FamilyTree class' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to be_kind_of(FamilyTree)
  end

  it 'creates node' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:create_node)
    # if mother present add node else return false

    add_child_hash = {}
    add_child_hash['mothers_name'] = 'root_name'
    add_child_hash['child_name'] = 'vich'
    add_child_hash['gender'] = 'female'
    add_child_hash['relation'] = 'child'

    expect(tree.create_node(add_child_hash)).to be true
     add_child_hash['mothers_name'] = 'anga'
    expect(tree.create_node(add_child_hash)).to be false
  end

  it 'adds child' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:add_child)
    
    params = ['Anga', 'Vich', 'male']
    value = tree.add_child(params)
    expect(value).to be false
    
    params = ['root_name', 'Vich', 'male']
    value = tree.add_child(params)
    expect(value).to be true
  end

  it 'gets relationship' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_relationship)	
  end

  it 'gets siblings' do
  	shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_siblings)  
  end

  it 'gets daughters' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_daughter)  
  end

  it 'gets sons' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_son)  
  end

  it 'gets paternal_uncles' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_paternal_uncle)  
  end

  it 'gets maternal uncles' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_maternal_uncle)  
  end

  it 'get paternal aunts' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_paternal_aunt)  
  end

  it 'get maternal aunts' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_maternal_aunt)  
  end

  it 'gets brother in laws' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_brother_in_law)  
  end

  it 'gets sister in laws' do 
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_sister_in_law)  
  end

  it 'gets members' do
    shan_family = CreateShanFamilyTree.new('root_name')
    tree = FamilyTree.new(shan_family)
    expect(tree).to respond_to(:get_member)
    # return member object if exists
    expect(tree.get_member('root_name')).to be_kind_of(Tree::TreeNode)
    # return nil incase member doesn't exist
    expect(tree.get_member('rut_name')).to be_nil
  end
end