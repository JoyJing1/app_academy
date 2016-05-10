class Array
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_select
    new_array = []
    self.my_each do |el|
      if yield(el)
        new_array << el
      end
    end
    new_array
  end

  def my_reject
    new_array = []
    self.my_each do |el|
      unless yield(el)
        new_array << el
      end
    end
    new_array
  end

  def my_any?
    self.my_each do |el|
      if yield(el)
        return true
      end
    end
    false
  end

  def my_all?
    self.my_each do |el|
      unless yield(el)
        return false
      end
    end
    true
  end

  def my_flatten
    new_array = []
    self.my_each do |el|
      if el.is_a?(Array)
        el.my_flatten.my_each do |char|
          new_array << char
        end
      else
        new_array << el
      end
    end
    new_array
  end

  def my_zip(*args)
    zipped_array = []
    self.each_with_index do |char, idx|
      sub_array = [char]
      args.each { |arg_array| sub_array << arg_array[idx] }
      zipped_array << sub_array
    end
    zipped_array
  end

  def my_rotate(shift=1)
    rotated_array = []
    (0...self.length).each do |i|
      new_index = (i + shift) % self.length
      rotated_array << self[new_index]
    end
    rotated_array
  end

  def my_join(sep='')
    new_string = ''
    (0...self.length - 1).to_a.my_each do |i|
      new_string << "#{self[i]}#{sep}"
    end
    new_string << self[-1]
  end

  def my_reverse
    copy_array = self.dup
    reversed_array = []
    while copy_array.length > 0
      reversed_array << copy_array.pop
    end
    reversed_array
  end




end
