#logic behind this example is pretty weird because if you gotta find a number which is divisible by all numbers up to 20 you just need to find prime numbers of each
#of the numbers below 20 and then create an array which has enough numbers to make each of the numbers from 1..20 so if you have number 6 it consists of 2 primes
#[2,3] because 2 * 3 = 6 and you have number 4 which consists of [2,2] because 2 * 2 = 4, your array which would have all the primes should only include [2,2,3] so it 
#can recreate 4 and 6 with [2,2] and [2,3]
def find_primes(num,prime_array=[])
  i = 2
  until num % i == 0 
    i += 1
  end
  prime_array << i
  return prime_array if num == i
  find_primes(num/i, prime_array) 
end

def merge_primes(full_array, compound, iterator)
  return full_array if iterator == 20 # change this number to whatever you want so for example 20 will be equal to a number which is divisible by all numbers below 20, 30 will equal a number divisible by all numbers below 30
  full_array = check_add(full_array, compound)
  merge_primes(full_array, find_primes(iterator+1), iterator+1)
end

def check_add(full_array, compound)
  full_array_hash = full_array.flatten.reduce(Hash.new(0)){ |hash,element| hash[element] += 1; hash }
  compound_hash = compound.reduce(Hash.new(0)){ |hash,element| hash[element] += 1; hash }
  compound_hash.each do |key,val|
    number_of_times = val - full_array_hash[key]
    if number_of_times > 0 # only add numbers to array that aren't already present or compound array has more of them than full array
      number_of_times.times{ full_array << key } 
    end
  end
  full_array
end


all_primes_of_each_num_below_20 = merge_primes([], find_primes(2), 2)

puts all_primes_of_each_num_below_20.reduce{ |prev,curr| prev *= curr; prev }
