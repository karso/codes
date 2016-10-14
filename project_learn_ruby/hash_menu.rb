#!/usr/bin/ruby -w

=begin
Suppose you have a list of Dishes, where each dish is associated with a list of ingredients.
Group together dishes with common ingredients.

E.g:
Input:
"Pasta" -> ["Tomato Sauce", "Onions", "Garlic"]
"Chicken Curry" --> ["Chicken", "Curry Sauce"]
"Fried Rice" --> ["Rice", "Onions", "Nuts"]
"Salad" --> ["Spinach", "Nuts"]
"Sandwich" --> ["Cheese", "Bread"]
"Quesadilla" --> ["Chicken", "Cheese"]

Output: ("Pasta", "Fried Rice") ("Fried Rice, "Salad"),
        ("Chicken Curry", "Quesadilla") ("Sandwich", "Quesadilla")

Follow up: What is the time and space complexity?
=end

recipe = { "Pasta" => ["Tomato Sauce", "Onions", "Garlic"],
  "Chicken Curry" => ["Chicken", "Curry Sauce"],
  "Fried Rice" => ["Rice", "Onions", "Nuts"],
  "Salad" => ["Spinach", "Nuts"],
  "Sandwich" => ["Cheese", "Bread"],
  "Quesadilla" => ["Chicken", "Cheese"],
}

str_arr = []
index = 0
recipe.each_key do |key|
  str_arr.push(key)
end
while index < str_arr.size 
  check = index + 1
  while check < str_arr.size 
    dish2 = str_arr[check]
    dish1 = str_arr[index]
    if (recipe["#{dish2}"] - recipe["#{dish1}"]).size < recipe["#{dish2}"].size
      puts "(#{dish1}, #{dish2})"
    end
    check += 1
  end
  index += 1
end

