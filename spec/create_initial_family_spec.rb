require 'rspec'
require '../src/create_initial_family.rb'

RSpec.describe CreateInitialFamily do

  let(:family) { CreateInitialFamily.new }

  before(:each) do
    CreateInitialFamily.send(:public, *CreateInitialFamily.private_instance_methods)
  end

  it 'creates a CreateInitialFamily class' do
    expect(family).to be_kind_of(CreateInitialFamily)
  end

  it 'creates a root' do
    expect(family).to respond_to(:create_root)
  end

  it 'creates basic family' do
    expect(family).to respond_to(:create_basic_family)
  end

  it 'gets root' do
    expect(family).to respond_to(:get_root)
    family.create_root('root')
    expect(family.get_root).to be_kind_of(Tree::TreeNode)
  end

  it 'add_to_family' do
    expect(family).to respond_to(:add_to_family)
  end

  it 'gets member' do
    expect(family).to respond_to(:get_member)
  end 

  it 'prints tree' do 
    expect(family).to respond_to(:print_tree)
  end
end
