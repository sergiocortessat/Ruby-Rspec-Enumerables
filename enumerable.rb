# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength
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
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity,  Metrics/ModuleLength
