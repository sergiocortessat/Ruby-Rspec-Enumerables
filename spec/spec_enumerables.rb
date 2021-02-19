# This file was generated by the `rspec --init` command. Conventionally, all
require_relative '../enumerable'

describe Enumerable do
  arr1 = [1, 2, 5, 7, 9]
  arr2 = ['hi', 'hello', 'bybye', true, false]
  arr3 = %w[Sharon Leo Leila Brian Arun]
  arr4 = %w[ant bear cat]
  describe '#my_each' do
    it 'in this it should return  ' do
      expect(arr1.my_each { |x| }).to eql([1, 2, 5, 7, 9])
    end
    it 'this one should print another array' do
      expect(arr2.my_each { |y| }).to eql(['hi', 'hello', 'bybye', true, false])
    end
  end

  describe '#my_each_with_index' do
    it ' this test case return an array' do
      expect(arr1.my_each_with_index { |x| }).to eql(arr1)
    end
    # it ' this should print an even ' do
    # expect(arr3.my_each_with_index { |x, y| x if y%2 == 0 }).to eql(['Sharon','Leila',
    #     'Arun'])
    # end
  end

  describe '#my_select' do
    it 'retunr only the selected items' do
      expect(arr3.my_select { |x| x != 'Brian' }).to eql(%w[Sharon Leo Leila Arun])
    end

    it 'test to check if the return is wrong as Sharon shouldnt be returned' do
      expect(arr3.my_select { |y| y != 'Sharon' }).not_to eql(%w[Sharon Leo Leila Arun])
    end
  end

  describe '#my_all' do
    it 'It should return true as all the elemnts inside comply with the condition' do
      expect(arr4.my_all? { |x| x.length >= 2 }).to be true
    end

    it 'It should return false as not all the elemnts inside comply with the condition' do
      expect(arr4.my_all? { |x| x.length >= 4 }).to be false
    end

    it 'It should return false as all the elemnts inside are not of the type String' do
      expect([1, 2i, 3.14].my_all?(String)).to be false
    end
  end
end
