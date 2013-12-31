require 'rspec'
require_relative '../lib/runtime/runtime'

describe 'Runtime' do
  it 'should get constant' do
    expect(Runtime['Object']).not_to be_nil
  end

  it 'should create an object' do
    expect(Runtime['Object']).to eq(Runtime['Object'].new.runtime_class)
  end

  it 'should create an object mapped to ruby value' do
    expect(32).to eql(Runtime['Number'].new_with_value(32).ruby_value)
  end

  it 'should lookup a method in class' do
    expect(Runtime['Object'].lookup('print')).not_to be_nil
    expect{Runtime['Object'].lookup('non-existant')}.to raise_error(RuntimeError)
  end

  it 'should call a method' do
    # Mimic Object.new in the language
    object = Runtime['Object'].call('new')
    expect(Runtime['Object']).to eq(object.runtime_class) # assert object is an Object
  end

  it 'should return that a object class is a class' do
    expect(Runtime['Class']).to eq(Runtime['Number'].runtime_class)
  end
end