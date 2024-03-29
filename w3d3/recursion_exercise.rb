# Recursion exercises
# ⏱ 5 hours
require "byebug"
# Recursion

# Learning Goals
# Know how to reason about recursive programs
# Be able to write a base case for a recursive method
# Be able to write the inductive step for a recursive method
# Be able to explain the benefits of writing a method recursively vs. iteratively
# Be able to trace a recursive method and figure out how many recursive steps it will take
# Know how to write recursive sorting and searching algorithms

# Warmup
# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
# Write both a recursive and iterative version of sum of an array.

def range(min,max) 
  return [] if min > max
  
  # numbers = []
  [min] + range(min+1, max)
  # numbers
end

def sum_r(arr)
  return 0 if arr.count == 0 
  arr.first + sum_r(arr.drop(1))
end

def sum_i(arr)
  arr.inject { |acc, num| acc + num }
end
# p sum_i([1,2,3,4])


# Exponentiation
# Write two versions of exponent that use two different recursions:

# # this is math, not Ruby methods.

# # recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

def exp_1(base, exponent)
  exponent == 0 ? 1 : base * exp_1(base, exponent - 1)
end

# p exp_1(2, 4)

# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
# Note that for recursion 2, you will need to square the results of exp(b, n / 2) and (exp(b, (n - 1) / 2). Remember that you don't need to do anything special to square a number, just calculate the value and multiply it by itself. So don't cheat and use exponentiation in your solution.

def exp_2(base, exponent)
  return 1 if exponent == 0
  debugger
  if exponent.even?
      value = exp_2(base, exponent / 2)
      value *= value
  else
      value = exp_2(base, (exponent - 1) / 2)
      value *= value
      base * value
  end

end

# p exp_2(2, 5)           # 16

# Suggestion: Break the methods down into parts..

# Suggestion 2: Try walking through your code with Simple Examples.

# If the n == 256, about how many nested recursive steps will we run in the first case?

# How deep will we need to recurse for the second? Keep in mind that the first reduces the exponent by one for each recursion, while the second reduces it by half.

# In addition to testing your methods by running the code, try the following exercise:

# On paper, write out the value of each variable for every line in the code:

# Write out what happens with base 0 and power 0 as inputs (should be easy). e.g., if you had run exp(0,0).
# Write out what happens for base 0 and power 1. e.g., if you had run exp(0,1).
# Write out what happens for base 1 and power 0.
# Write out what happens for base 1 and power 1.
# Write out what happens for base 1 and power 2.
# Write out what happens for base 2 and power 0.
# Write out what happens for base 2 and power 1.
# Write out what happens for base 2 and power 2.
# Make sure you can trace from the very beginning to the very end in these examples.

# How many examples do you need to walk through to be confident that it works?


# Deep dup
# The #dup method doesn't make a deep copy:


# robot_parts_copy = robot_parts.dup

# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # but it does
# robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
# When we dup an Array, it creates a new array to hold the elements, but doesn't recursively dup any arrays contained therein. So the dup method creates one new array, but just copies over references to the original interior arrays.

# Sometimes you want a shallow dup and sometimes you want a deep dup. Ruby keeps things simple by giving you shallow dup, and letting you write deep dup yourself.

# Using recursion and the is_a? method, write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

# Note: For simplicity's sake, we are only going to ensure the deep duplication of arrays. Don't worry about deep-duping (or regular-duping) other types of mutable objects (like strings, hashes, instances of custom classes, etc.), since this would require that we implement a deep dup method for each of those classes, as well.

# It's okay to iterate over array elements using the normal each for this one :-)

# You should be able to handle "mixed" arrays. For instance: [1, [2], [3, [4]]].


robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

class Array
    def deep_dup # [1, [2], [3, [4]]]

      # return self.dup if self == self.flatten

      arr = []
      self.each do |ele|
        # debugger
        if ele.is_a?(Array)
          arr << ele.deep_dup
        else
          arr << ele
        end
      end
      arr
        


      
      
      # [self.dup] + self.drop(1).deep_dup


    end
end
# arr = [1, [2], [3, [4]]]
# arr.deep_dup
# arr2 = robot_parts.deep_dup
# arr2[1] << "ele"
# # p arr
# p robot_parts
# p arr2


# Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.


def fib_recur(n) #[1,1, 2, 3, 5, 8,, 13, 21, 34, 55 ]
  return [1,1].take(n) if n <= 2

  seq = fib_recur(n-1) #fib_recur(3) => [1,1,2]

  seq << seq[-1] + seq[-2]

  seq 

end

# p fib_recur(3) #[1,1,2]

def fib_iter(n)
  return [1,1].take(n) if n <= 2

  seq = [1,1]

  until seq.length == n
    seq << seq[-1] + seq[-2]    
  end

  seq
end

# p fib_iter(10)
# Binary Search
# The binary search algorithm begins by comparing the target value to the value of the middle element of the sorted array. If the target value is equal to the middle element's value, then the position is returned and the search is finished. If the target value is less than the middle element's value, then the search continues on the lower half of the array; or if the target value is greater than the middle element's value, then the search continues on the upper half of the array. This process continues, eliminating half of the elements, and comparing the target value to the value of the middle element of the remaining elements - until the target value is either found (and its associated element position is returned), or until the entire array has been searched (and "not found" is returned).

# Write a recursive binary search: bsearch(array, target). Note that binary search only works on sorted arrays. Make sure to return the location of the found object (or nil if not found!). Hint: you will probably want to use subarrays.


def bsearch(arr,val) #[1, 3, 4, 5, 9], 9) # => 4
  return nil if arr.length < 1
  middle_idx = arr.length/2

  if val == arr[middle_idx]
    return middle_idx 
  elsif val < arr[middle_idx]
    left = arr.take(middle_idx)
    bsearch(left, val)
  else
    right = arr.drop(middle_idx + 1)
    right_results = bsearch(right, val) 
    right_results.nil? ? nil : right_results + 1 + middle_idx 
  end
    
end

# Make sure that these test cases are working:

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([1, 3, 4, 5, 9], 3) #=> 1

# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

# Merge Sort
# Implement a method merge_sort that sorts an Array:

# The base cases are for arrays of length zero or one. Do not use a length-two array as a base case. This is unnecessary.
# You'll want to write a merge helper method to merge the sorted halves.
# To get a visual idea of how merge sort works, watch this gif and check out this diagram.

def merge_sort(arr)
  p arr
  return arr if arr.count < 2
  
  middle = arr.count / 2
  
  left = arr.take(middle)
  right = arr.drop(middle)
  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)
  
  # debugger
  merge(sorted_left, sorted_right)
  

end

def merge(arr1,arr2) #[2,8] #[3,4,6]
  sorted = []   # [2, 3, 4, 6] + [8]
  
  until arr1.empty? || arr2.empty?
    arr1[0] < arr2[0] ? sorted << arr1.shift : sorted << arr2.shift
  end

  arr1.empty? ? sorted += arr2 : sorted += arr1

  sorted
  # compare the first element of two arrays
  # grab (shift) lesser of the two elements and add to new array
  # stop when one of the array is empty
  # concatenate new array with leftover input array
  

end

# p merge_sort([1,2,3,4,5,6,7,8,].shuffle)
# p merge([2,8], [3,4,6])


# Array Subsets
# Write a method subsets that will return all subsets of an array.

# def subsets(arr)

#   return [[]] if arr.empty?
#   sets = []
#   sets += [arr.length-1] + subsets(arr.drop(1))
# end




# subsets([])           # => [[]]
# subsets([1])          # => [[], [1]]
# subsets([1, 2])       # => [[], [1], [2], [1, 2]]
# subsets([1, 2, 3])    # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
# You can implement this as an Array method if you prefer.

# Hint: For subsets([1, 2, 3]), there are two kinds of subsets:

# Those that do not contain 3 (all of these are subsets of [1, 2]).
# For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.
# Permutations
# Write a recursive method permutations(array) that calculates all the permutations of the given array. For an array of length n there are n! different permutations. So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.
def permutation(arr)

  

end
# permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
#                         #     [2, 1, 3], [2, 3, 1],
#                         #     [3, 1, 2], [3, 2, 1]]
# You can use Ruby's built in Array#permutation method to get a better understanding of what you will be building.

# [1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
#                             #     [2, 1, 3], [2, 3, 1],
#                             #     [3, 1, 2], [3, 2, 1]]
# Make Change
# RubyQuiz: Make change.

# Here's a game plan for solving the problem:

# First, write a 'greedy' version called greedy_make_change:

# Take as many of the biggest coin as possible and add them to your result.
# Add to the result by recursively calling your method on the remaining amount, leaving out the biggest coin, until the remainder is zero.
# Once you have a working greedy version, talk with your partner about refactoring this to make_better_change. What's wrong with greedy_make_change?

# Consider the case of greedy_make_change(24, [10,7,1]). Because it takes as many 10 pieces as possible, greedy_make_change misses the correct answer of [10,7,7] (try it in pry).

# To make_better_change, we only take one coin at a time and never rule out denominations that we've already used. This allows each coin to be available each time we get a new remainder. By iterating over the denominations and continuing to search for the best change, we assure that we test for 'non-greedy' uses of each denomination.

# Discuss the following game plan and then work together to implement your new method:

# Iterate over each coin.
# Grab only one of that one coin and recursively call make_better_change on the remainder using coins less than or equal to the current coin.
# Add the single coin to the change returned by the recursive call. This will be a possible solution, but maybe not the best one.
# Keep track of the best solution and return it at the end.
# N.B. Don't generate every possible permutation of coins and then compare them. Remember that a permutation is not the same thing as a combination - we will need to check every combination of coins that add up to our target, we just don't want to check the same combination in different orders. If you get stuck you can start by writing a solution that calculates and compares all of the permutations without storing them in an array. Then go back and refactor your solution so that it only calculates and compares all of the different combinations. If you and your partner get totally stuck, or would like to compare your answer, feel free to reference this video walkthrough of the problem.

# Make sure you and your partner understand each line before moving on.



