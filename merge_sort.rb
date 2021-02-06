def merge_sort(array)
  if array.length == 1 || array.length.zero?
    array
  else
    left_half = merge_sort(array[0..((array.length / 2) - 1)])
    right_half = merge_sort(array[(array.length / 2)..-1])
    merge(left_half, right_half)
  end
end

def merge(left_half, right_half)
  merged_array = []
  while left_half.length.positive? || right_half.length.positive?
    if right_half.length.zero? || (left_half.length.positive? && left_half[0] < right_half[0])
      merged_array << left_half.shift
    elsif left_half.length.zero? || (right_half.length.positive? && left_half[0] >= right_half[0])
      merged_array << right_half.shift
    end
  end
  merged_array
end

sorting_array = []
1000000.times do
  sorting_array << rand(1000000)
end

p merge_sort(sorting_array)