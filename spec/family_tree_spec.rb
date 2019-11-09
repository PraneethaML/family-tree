require 'rspec'
require 'byebug'
require '../src/family_tree.rb'
require '../src/create_initial_family.rb'

RSpec.describe FamilyTree do

  let(:family) { CreateInitialFamily.new }
  let(:tree) { FamilyTree.new(family) }

  before(:each) do
    FamilyTree.send(:public, *FamilyTree.private_instance_methods)
  end

  it 'creates a FamilyTree class' do
    expect(tree).to be_kind_of(FamilyTree)
  end

  it 'creates relation' do
    family.create_root('root_name')
    expect(tree).to respond_to(:create_relation)

    params = %w[Anga Vich male]
    value = tree.create_relation(params)
    expect(value).to be false

    params = %w[root_name Vich male]
    value = tree.create_relation(params)
    expect(value).to be true
  end

  it 'gets relationship' do
    expect(tree).to respond_to(:get_relationship)
  end

  it 'gets members' do
    family.create_root('root_name')
    expect(tree).to respond_to(:get_member)
    # return member object if exists
    expect(tree.get_member('root_name')).to be_kind_of(Tree::TreeNode)
    # return nil incase member doesn't exist
    expect(tree.get_member('rut_name')).to be_nil
  end

  it 'responds to creates member' do
    expect(tree).to respond_to(:create_member)
  end

  it 'creates member if mother is present' do 
    family.create_root('root_name')
    params = %w[root_name Vich male]
    create_relation_hash = {}
    create_relation_hash['mothers_name'] = params[0].downcase
    create_relation_hash['child_name'] = params[1].downcase
    create_relation_hash['gender'] = params[2].downcase
    create_relation_hash['relation'] = 'child'
    mem_created = tree.create_member(create_relation_hash)
    expect(mem_created).to be true
  end

  it 'doesnt create member if mother is not present' do
    family.create_root('root_name')
    params = %w[root1_namssse Vich male]
    create_relation_hash = {}
    create_relation_hash['mothers_name'] = params[0].downcase
    create_relation_hash['child_name'] = params[1].downcase
    create_relation_hash['gender'] = params[2].downcase
    create_relation_hash['relation'] = 'child'
    mem_created = tree.create_member(create_relation_hash)
    expect(mem_created).to be false
  end

  it 'gets siblings' do
    expect(tree).to respond_to(:get_siblings)
    family.create_root('root_name')
    expect(tree.get_siblings('root_name')).to be_an_instance_of(Array)
  end

  it 'print output' do
    expect(tree).to respond_to(:print_output)
  end

  it 'gets children' do
    expect(tree).to respond_to(:get_children)
    expect(tree.get_children('root_name','daughter')).to be_an_instance_of(Array)
  end

  it 'gets uncles' do
    expect(tree).to respond_to(:get_uncles)
    expect(tree.get_uncles('root_name')).to be_an_instance_of(Array)
  end

  it 'gets paternal uncles' do
    expect(tree).to respond_to(:get_paternal_uncle)
    expect(tree.get_paternal_uncle('root_name')).to be_an_instance_of(Array)
  end

  it 'gets maternal uncles' do
    expect(tree).to respond_to(:get_maternal_uncle)
    expect(tree.get_maternal_uncle('root_name')).to be_an_instance_of(Array)
  end

  it 'gets aunts' do
    expect(tree).to respond_to(:get_aunts)
    expect(tree.get_aunts('root_name')).to be_an_instance_of(Array)
  end

  it 'gets paternal aunt' do
    expect(tree).to respond_to(:get_paternal_aunt)
    expect(tree.get_paternal_aunt('root_name')).to be_an_instance_of(Array)
  end

  it 'gets maternal aunt' do
    expect(tree).to respond_to(:get_maternal_aunt)
    expect(tree.get_maternal_uncle('root_name')).to be_an_instance_of(Array)
  end

  it 'gets brothers sisters' do
    expect(tree).to respond_to(:brothers_sisters)
  end

  it 'gets spouse' do
    expect(tree).to respond_to(:get_spouse)
  end

  it 'gets relatives' do
    expect(tree).to respond_to(:relation_wrt_spouse)
    expect(tree).to respond_to(:relation_wrt_child)
  end

  it 'gets relation' do
    expect(tree).to respond_to(:get_relation)
  end
end
