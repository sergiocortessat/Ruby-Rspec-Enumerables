require_relative '../enumerable'
describe Enumerable do
  let(:arr1) { [1, 2, 5, 7, 9] }
  let(:arr2) { ['hi', 'hello', 'bybye', true, false] }
  let(:arr3) { %w[Sharon Leo Leila Brian Arun] }
  let(:arr4) { %w[ant bear cat] }
  let(:map_arr) { ['small Pizza', 'small garlic bread', 'small milkshake'] }
  let(:test_proc) { proc { |i| i * i } }
  let(:negativetest) { ['pp', 'ww', 'mm', true, false] }

  describe '#my_each' do
    it 'in this it should return an array ' do
      expect(arr1.my_each { |x| }).to eql([1, 2, 5, 7, 9])
    end
    it 'this one should print another array' do
      expect(arr2.my_each { |y| }).to eql(['hi', 'hello', 'bybye', true, false])
    end
    it 'this one should print the negative scenarios' do
      expect(negativetest.my_each { |z| }).not_to eql(['sergio', 'billo', 'lorem', false, true])
    end
  end

  describe '#my_each_with_index' do
    it ' this test case return an array' do
      expect(arr1.my_each_with_index { |x| }).to eql(arr1)
    end
    it ' this test case return an array with negative scenario ' do
      expect(arr1.my_each_with_index { |y| }).not_to eql([3, 5, 4, 7, 9])
    end
  end

  describe '#my_select' do
    it 'retunr only the selected items' do
      expect(arr3.my_select { |x| x != 'Brian' }).to eql(%w[Sharon Leo Leila Arun])
    end

    it 'test to check if the return is wrong as Sharon shouldnt be returned ,also it is a negative scenario' do
      expect(arr3.my_select { |y| y != 'Sharon' }).not_to eql(%w[Sharon Leo Leila Arun])
    end
  end

  describe '#my_all?' do
    it 'It should return true as all the elemnts inside comply with the condition' do
      expect(arr4.my_all? { |x| x.length >= 2 }).to be true
    end
    it 'It should return true as all the elemnts inside comply with the condition asserted to not_to eq' do
      expect(arr4.my_all? { |x| x.length >= 2 }).not_to be false
    end

    it 'It should return false as not all the elemnts inside comply with the condition' do
      expect(arr4.my_all? { |x| x.length >= 4 }).to be false
    end
    it 'It should return true as all the elemnts inside comply with the condition asserted to not_to eq' do
      expect(arr4.my_all? { |x| x.length >= 4 }).not_to be true
    end
    it 'It should return negative scenario' do
      expect(arr4.my_all? { |x| x.length >= 4 }).not_to be true
    end

    it 'It should return false as all the elemnts inside are not of the type String' do
      expect([1, 2i, 3.14].my_all?(String)).to be false
    end
    it 'negative scenario' do
      expect([1, 2i, 3.14].my_all?(String)).not_to be true
    end
  end

  describe '#my_any?' do
    it 'It should return true as one of the elemnts inside comply with the condition' do
      expect(arr4.my_any? { |x| x.length >= 3 }).to be true
    end
    it 'negative scenario' do
      expect(arr4.my_any? { |x| x.length >= 3 }).not_to be false
    end

    it 'It should return false as any elemnts inside has a true value  tocomply with the condition' do
      expect(arr4.my_any? { |x| x.length >= 7 }).to be false
    end
    it 'It should return false as any elemnts inside has a true value but asserted to not_to equ' do
      expect(arr4.my_any? { |x| x.length >= 7 }).not_to be true
    end

    it 'It should return false as an negative scenario' do
      expect([].my_any?).not_to be true
    end
    it 'postive scenario scenario' do
      expect([].my_any?).to be false
    end
  end

  describe '#my_none?' do
    it 'It should return true as none of the elemnts inside comply with the condition' do
      expect(arr4.my_none? { |x| x.length >= 5 }).to be true
    end
    it 'It should return true as none of the elemnts inside comply with the condition asserted to not_to eq' do
      expect(arr4.my_none? { |x| x.length >= 5 }).not_to be false
    end

    it 'It should return false as one of  elemnts inside has a true value  to comply with the condition' do
      expect(arr4.my_none? { |x| x.length >= 4 }).to be false
    end
    it 'It should return false as one of the elemnts inside comply with the condition asserted to not_to eq' do
      expect(arr4.my_none? { |x| x.length >= 4 }).not_to be true
    end

    it 'It should return true as none  of the element are integer' do
      expect(arr4.my_none?(Integer)).to be true
    end
    it 'It should return true as none  of the element are integer' do
      expect(arr4.my_none?(Integer)).not_to be false
    end
    it 'It should return true as none  of the element are integer' do
      expect([nil, false, true].my_none?).to be false
    end
    it 'It should return true as none  of the element are integer asserted to a not_to eq ' do
      expect([nil, false, true].my_none?).not_to be true
    end
  end

  describe '#my_count' do
    it 'It should return the number of element ' do
      expect(arr2.my_count).to eql(5)
    end
    it 'negative scenario of It should return the number of element ' do
      expect(arr2.my_count).not_to eql(7)
    end

    it ' It should return count if it is even element' do
      expect(arr1.my_count { |x| (x % 2).zero? }).to eql(1)
    end
    it ' negative scenario ,It should return count if it is even element' do
      expect(arr1.my_count { |x| (x % 2).zero? }).not_to eql(2)
    end

    it ' It should return 1 as there is one Leo in the list' do
      expect(arr3.my_count('Leo')).to eql(1)
    end
    it ' neagtive scenario ,It should return 1 as there is one Leo in the list' do
      expect(arr3.my_count('Leo')).not_to eql(3)
    end
  end

  describe '#my_map' do
    it 'It should return the map_array with modified size to large ' do
      expect(map_arr.my_map do |x|
               x.gsub('small', 'large')
             end).to eql(['large Pizza', 'large garlic bread', 'large milkshake'])
    end
    it 'negative scenario, It should return the map_array with modified size to large ' do
      expect(map_arr.my_map do |x|
               x.gsub('small', 'large')
             end).not_to eql([' Pizza', ' garlic bread', ' milkshake'])
    end

    it ' It should return the modified array with numbers multiply i*i' do
      expect(arr1.my_map(test_proc) { |i| i }).to eql([1, 4, 25, 49, 81])
    end
    it ' negative scenario ,It should return the modified array with numbers multiply i*i' do
      expect(arr1.my_map(test_proc) { |i| i }).not_to eql([2, 6, 28, 39, 91])
    end

    it ' It should return the modified array with numnbers sum +10' do
      expect(arr1.my_map { |x| x + 10 }).to eql([11, 12, 15, 17, 19])
    end
    it ' neagtive scenario, It should return the modified array with numnbers sum +10' do
      expect(arr1.my_map { |x| x + 10 }).not_to eql([15, 16, 18, 19, 29])
    end
  end

  describe '#my_inject' do
    it 'It should return the total sum of of i[n] + i[n+1] of the array' do
      expect(arr1.my_inject { |x, y| x * y }).to eql(630)
    end
    it 'negative scenario, It should return the total sum of of i[n] + i[n+1] of the array' do
      expect(arr1.my_inject { |x, y| x * y }).not_to eql(209)
    end

    it 'It should return the longest string in the array' do
      expect(arr4.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('bear')
    end
    it 'negative scenario, It should return the longest string in the array' do
      expect(arr4.my_inject { |memo, word| memo.length > word.length ? memo : word }).not_to eql('juice')
    end

    it 'It should return 1 as 1 to the power of anything is equal to 1' do
      expect(arr1.my_inject { |z, w| z**w }).to eql(1)
    end
    it 'negative scenario, It should return 1 as 1 to the power of anything is equal to 1' do
      expect(arr1.my_inject { |z, w| z**w }).not_to eql(3)
    end
  end

  describe '#multiply_els' do
    it 'It should return the total multiplication of i[n] * i[n+1] of the array' do
      expect(multiply_els([1, 2, 4])).to eql(8)
    end
    it ' negative scenario, It should return the total multiplication of i[n] * i[n+1] of the array' do
      expect(multiply_els([1, 2, 4])).not_to eql(10)
    end

    it 'It should return the total multiplication of i[n] * i[n+1] of the array' do
      expect(multiply_els([3, 5, 8])).to eql([3, 5, 8].inject { |a, b| a * b })
    end
    it 'megative scenario, It should return the total multiplication of i[n] * i[n+1] of the array' do
      expect(multiply_els([3, 5, 8])).not_to eql([4, 6, 9].inject { |a, b| a * b })
    end
  end
end
