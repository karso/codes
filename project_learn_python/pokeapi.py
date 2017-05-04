import requests, json, ast
poke_url = "http://pokeapi.co/api/v1/pokedex/1/"
r = requests.get(poke_url)
result = json.loads(r.text)
listofpokes = result["pokemon"]
print "There are %d pokemons in pokedex" %(len(listofpokes))

Name = raw_input("Enter a pokemon name: ")
result2 = [entry for entry in listofpokes if entry["name"] == Name]
result2str = result2[0]
print len(result2)
#print result2str
#result2dict = ast.literal_eval("result2str")
#print type(result2dict)
