import requests
import json

url = "https://ccstack.p.rapidapi.com/search/cards"

headers = {
	"X-RapidAPI-Key": "b8f5570f99msh1a376a342cb9c13p150fb6jsn0721ce0baa0d",
	"X-RapidAPI-Host": "ccstack.p.rapidapi.com"
}

# for i in range (2, 146):
#     querystring = {"page":f"{i}"}
#     response = requests.request("GET", url, headers=headers, params=querystring)
#     file = open(f"card_benefits/page{i}.json", "w")
#     data = json.loads(response.text)
#     # formatted = json.dumps(data, indent=2)
#     json.dump(data, file, indent=2)

#
# print(response.text)
for i in range(1, 146):
    file = open(f"card_benefits/page{i}.json", "r")
    data = json.load(file)
    # formatted = json.dumps(data["results"][1], indent=2)
    # print(formatted)
    for card in data["results"]:
        filename = f"individual_card_benefits/{card['title'].replace('/', ' ')}.json"
        file = open(filename, "w")
        json.dump(card, file, indent=2)
