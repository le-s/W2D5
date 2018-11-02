require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    # lines 7-15 return an integer based on
    # the values in the array and their indices
    return 0 if self.empty?

    sum = 0
    self.each_with_index do |el, i|
      if i.even?

        sum -= el.hash
      else
        sum += el.hash
      end
    end

    sum % self.length # determines which bucket to put array in
  end
end

class String
  def hash
    sum = 0
    self.chars.each_with_index do |char, i|
      if i.even?
        sum -= char.ord
      else
        sum += char.ord
      end
    end

    sum % self.length
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
   #debugger
   if self.length == 0
     0
   else
    sum = 0
    self.each do |key, value|
      if value.is_a?(Integer)
        sum += value ** 2
      else
        sum += value.ord
      end
    end
    sum % self.length
    end
  end
end
