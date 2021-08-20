# frozen_string_literal:true

# merge sort algorithm
module MergeSort
  def merge(left, right, arr = [])
    (left.size + right.size).times do
      if left.empty?
        arr << right
        return arr
      elsif right.empty?
        arr << left
        return arr
      else
        if left[0] > right[0]
          arr.push(right[0])
          right.shift
        else
          arr.push(left[0])
          left.shift
        end
      end
    end
    arr
  end

  def msort(arr)
    if arr.size < 2
      arr
    else 
      left = msort(arr[0...arr.size/2])
      right = msort(arr[arr.size/2...arr.size])
      merge(left, right)
    end
  end
end
