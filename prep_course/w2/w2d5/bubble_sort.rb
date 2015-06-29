def bubble_sort(arr)
	changed = true
	while changed
		changed = false
		arr[0..-2].each_with_index do |x, idx|
			if x > arr[idx+1]
				arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
				changed = true
			end
		end
	end
	arr
end

p bubble_sort([7, 8, 3,5, 4, 2, 6, 1]) == [1,2,3,4,5,6,7,8]