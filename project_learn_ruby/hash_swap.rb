#!/bin/ruby -w

=begin
Swap the key-values in a hash.
{key=>value} to {value=>key}
=end

myhash = { 'India' => 'ND',
	   'France' => 'FRA',
	   'Germany' => 'BE',
	   'France' => 'PA'
	   }


puts myhash['France']
puts myhash.invert #fails to recognize duplicates

#This also fails to recognise duplicates
myhash_new = {}
myhash.each do |key, val|
  myhash_new[val] = key
  myhash.delete(key)
end
myhash = myhash_new
puts myhash

# DOES HASH RECOGNIZES DUPLICATES AT ALL???
### No, it does not. In case of a duplicate key 
### it gives precedence to the value 
### which the last repetation of the key has. Example: 

myhash = { 'India' => 'ND',
           'France' => 'FRA', #This will be ignored
           'Germany' => 'BE',
           'France' => 'PA'
           }
puts myhash['France'] 

### Output: PA. FRA is ignored.

