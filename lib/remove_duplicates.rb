# frozen_string_literal:true

# the module for removing duplicates of an array
module RemoveDuplicates
  def remove_duplicates(array)
    removed = false
    until removed
      previous = nil
      removed = true
      array.each_with_index do |e, i|
        now = e
        if now == previous
          array.delete_at(i)
          removed = false
        end
        previous = now
      end
    end
    array
  end
end
