require 'rspec'
require_relative '../lib/runtime/runtime'
require_relative 'spec_helper'

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
    expect{Runtime['Object'].lookup('non-existent')}.to raise_error(RuntimeError)
  end

  it 'should call a method' do
    # Mimic Object.new in the language
    object = Runtime['Object'].call('new')
    expect(Runtime['Object']).to eq(object.runtime_class) # assert object is an Object
  end

  it 'should return that a object class is a class' do
    expect(Runtime['Class']).to eq(Runtime['Number'].runtime_class)
  end

  it 'should print the number value correctly' do
    output = capture_stdout { Runtime['Object'].new.call('print', [Runtime['Number'].new_with_value(42)]) }.chomp
    expect(output).to eq('42')
  end

  it 'should add 2 numbers' do
    n1 = Runtime['Number'].new_with_value(42)
    n2 = Runtime['Number'].new_with_value(33)
    expect(n1.call('+', [n2]).ruby_value).to eq(75)
  end
end