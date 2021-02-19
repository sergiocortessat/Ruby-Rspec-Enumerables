module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    my_each { |item| new_arr << item if yield item }
    new_arr
  end

  def my_all?(param = nil)
    if block_given?
      to_a.my_each { |item| return false if yield(item) == false }
      return true
    elsif param.nil?
      to_a.my_each { |item| return false if item.nil? || item == false }
    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
    elsif !param.nil? && param.instance_of?(Regexp)
      to_a.my_each { |item| return false unless param.match(item) }
    else
      to_a.my_each { |item| return false if item != param }
    end
    true
  end

  def my_any?(param = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
      return false
    elsif param.nil?
      to_a.my_each { |item| return true if item }
    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |item| return true if [item.class, item.class.superclass].include?(param) }
    elsif !param.nil? && param.instance_of?(Regexp)
      to_a.my_each { |item| return true if param.match(item) }
    else
      to_a.my_each { |item| return true if item == param }
    end
    false
  end

  def my_none?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |n| return false if n }
      return true
    end

    if !block_given? && !arg.nil?

      if arg.is_a?(Class)
        my_each { |n| return false if n.instance_of?(arg) }
        return true
      end

      if arg.instance_of?(Regexp)
        my_each { |n| return false if arg.match(n) }
        return true
      end

      my_each { |n| return false if n == arg }
      return true
    end
    my_any? { |item| return false if yield(item) }
    true
  end

  def my_count(param = nil)
    c = 0
    if block_given?
      to_a.my_each { |item| c += 1 if yield(item) }
    elsif !block_given? && param.nil?
      c = to_a.length
    else
      c = to_a.my_select { |item| item == param }.length
    end
    c
  end

  def my_map(proc_x = nil)
    return enum_for unless block_given?

    map_list = []
    if proc_x.nil?
      my_each { |element| map_list.push(yield(element)) }
    else
      my_each { |element| map_list.push(proc_x.call(element)) }
    end
    map_list
  end

  def my_inject(initial = nil, sym = nil)
    if (!initial.nil? && sym.nil?) && (initial.is_a?(Symbol) || initial.is_a?(String))
      sym = initial
      initial = nil
    end
    if !block_given? && !sym.nil?
      to_a.my_each { |item| initial = initial.nil? ? item : initial.send(sym, item) }
    else
      to_a.my_each { |item| initial = initial.nil? ? item : yield(initial, item) }
    end
    initial
  end
end

def multiply_els(par)
  par.my_inject(1) { |a, b| a * b }
end


# puts '1.--------my_each--------'
# %w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend }

# puts '2.--------my_each_with_index--------'
# %w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts friend if index.even? }

# puts '3.--------my_select--------'
# puts (%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' })

# puts '4.--------my_all--------'
# puts (%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
# puts (%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
# puts %w[ant bear cat].my_all?(/t/) #=> false
# puts [1, 2i, 3.14].my_all?(Numeric) #=> true
# puts [].my_all? #=> true

# puts '5.--------my_any--------'
# puts (%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
# puts (%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
# puts %w[ant bear cat].my_any?(/d/) #=> false
# puts [nil, true, 99].my_any?(Integer) #=> true
# puts [nil, true, 99].my_any? #=> true
# puts [].my_any? #=> false

# puts '6.--------my_none--------'
# puts (%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
# puts (%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
# puts %w[ant bear cat].my_none?(/d/) #=> true
# puts [1, 3.14, 42].my_none?(Float) #=> false
# puts [].my_none? #=> true
# puts [nil].my_none? #=> true
# puts [nil, false].my_none? #=> true
# puts [nil, false, true].my_none? #=> false

# puts '7.--------my_count--------'
# arr = [1, 2, 4, 2]
# puts arr.my_count #=> 4
# puts arr.my_count(2) #=> 2
# puts (arr.my_count { |x| (x % 2).zero? }) #=> 3

# puts '8.--------my_maps--------'
# my_order = ['medium Big Mac', 'medium fries', 'medium milkshake']
# puts (my_order.my_map { |item| item.gsub('medium', 'extra large') })
# puts ((0..5).my_map { |i| i * i })
# puts 'my_map_proc'
# my_proc = proc { |i| i * i }
# puts (1..5).my_map(my_proc) { |i| i + i }

# puts '8.--------my_inject--------'
# puts ((1..5).my_inject { |sum, n| sum + n }) #=> 15
# puts (1..5).my_inject(1) { |product, n| product * n } #=> 120
# longest = %w[ant bear cat].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest #=> "bear"

# puts 'multiply_els'
# puts multiply_els([2, 4, 5]) #=> 40

