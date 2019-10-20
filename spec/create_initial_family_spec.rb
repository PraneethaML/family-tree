require 'rspec'
require '../src/create_initial_family.rb'

RSpec.describe CreateInitialFamily do
  it 'creates a CreateInitialFamily class' do
    family = CreateInitialFamily.new
    expect(family).to be_kind_of(CreateInitialFamily)
  end

  it 'creates a root' do
    family = CreateInitialFamily.new
    expect(family).to respond_to(:create_root)
  end

  it 'creates basic family' do
  	family = CreateInitialFamily.new
  	expect(family).to respond_to(:create_basic_family)
  end

  it 'gets root' do
  	family = CreateInitialFamily.new
  	expect(family).to respond_to(:get_root)
    family.create_root('root')
  	expect(family.get_root).to be_kind_of(Tree::TreeNode)
  end
end