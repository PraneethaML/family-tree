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

  it 'creates member' do
    expect(tree).to respond_to(:create_member)
  end

  it 'gets siblings' do
    expect(tree).to respond_to(:get_siblings)
  end

  it 'print output' do
    expect(tree).to respond_to(:print_output)
  end

  it 'gets children' do
    expect(tree).to respond_to(:get_children)
  end

  it 'gets uncles' do
    expect(tree).to respond_to(:get_uncles)
  end

  it 'gets paternal uncles' do
    expect(tree).to respond_to(:get_paternal_uncle)
  end

  it 'gets maternal uncles' do
    expect(tree).to respond_to(:get_maternal_uncle)
  end

  it 'gets aunts' do
    expect(tree).to respond_to(:get_aunts)
  end

  it 'gets paternal aunt' do
    expect(tree).to respond_to(:get_paternal_aunt)
  end

  it 'gets maternal aunt' do
    expect(tree).to respond_to(:get_maternal_aunt)
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
