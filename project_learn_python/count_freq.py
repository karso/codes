input = ["a", "d", "l", "w", "s", "w", "a"]
freq = {}

for elem in input:
    if elem in freq:
        freq[elem] = freq[elem] + 1
    else:
        freq.update({elem:1})

for item in freq:
    # print(item)
    print("The key ", item, " appears ", freq[item], " times")

