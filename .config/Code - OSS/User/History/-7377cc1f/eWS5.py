import json
import datetime as dt

category_strings = {
    1: "Airline",
    2: "Cable Services",
    3: "Car Rental",
    4: "Department Store",
    5: "Drug Store",
    6: "Entertainment",
    7: "Everywhere",
    8: "Gas Station",
    9: "Home Improvement Store",
    10: "Hotel",
    11: "Office Supply Store",
    12: "Online Shopping",
    13: "Phone Service",
    14: "Restaurant",
    15: "Selectable Category",
    16: "Supermarket",
    17: "Utility",
}

category_values = {
    "AIRLINE":                     1,
    "CABLE SERVICES":              2,
    "CAR RENTAL":                  3,
    "DEPARTMENT STORE":            4,
    "DRUG STORE":                  5,
    "ENTERTAINMENT":               6,

    "EVERYWHERE":                  7,

    "GAS STATION":                 8,
    "SERVICE STATIONS":            8,
    "AUTOMATED FUEL DISPENSERS":   8,

    "HOME IMPROVEMENT STORE":      9,
    "HOTEL":                       10,
    "OFFICE SUPPLY STORE":         11,
    "ONLINE SHOPPING":             12,
    "PHONE SERVICE":               13,

    "RESTAURANT":                  14,
    "FAST FOOD RESTAURANTS":       14,

    "SELECTABLE CATEGORY":         15,

    "SUPERMARKET":                 16,
    "GROCERY STORES/SUPERMARKETS": 16,

    "UTILITY":                     17,
}

def determine_card(users_cards, mcc_desc):
    best_card_values = {}
    best_card_category = {}
    user_cards_list = []
    for card in users_cards:
        user_cards_list.append(card)

    for mcc in mcc_desc:
        try:
            out = determine_card_for_category(user_cards_list, category_values[mcc])
            if (out[1] == 0):
                out = determine_card_for_category(users_cards, 7)

            try:
                if (best_card_values[out[0]] < out[1]):
                    best_card_values[out[0]] = out[1]
                    best_card_category[out[0]] = out[2]
            except:
                best_card_values[out[0]] = out[1]
                best_card_category[out[0]] = out[2]
        except:
            # FIX: If not in dict, return the amount of points for EVERYWHERE category
            # print("DEBUG: NOT SUPPORTED ", mcc)
            out = determine_card_for_category(users_cards, 7)
            try:
                if (best_card_values[out[0]] < out[1]):
                    best_card_values[out[0]] = out[1]
                    best_card_category[out[0]] = out[2]
            except:
                best_card_values[out[0]] = out[1]
                best_card_category[out[0]] = out[2]

    max_card_value = max(best_card_values.values())
    best_card = [x for x in best_card_values.keys() if best_card_values[x] == max_card_value]

    print(f"\n\033[4mBest Card is {best_card[0]} getting {best_card_values[best_card[0]]}% cashback in {category_strings[best_card_category[best_card[0]]]}\033[0m")

def determine_card_for_category(users_cards, category):
    # 1. Fetch list of cards user has from user database (array of json objects)
    # 2. Fetch all of the benefits for those cards from the card database
    # 3. Search through all of the benefits and see which card has the best
    
    max_benefits = []
    for _ in range(0, len(users_cards)):
        max_benefits.append(0)
    index = 0

    for card in users_cards:
        fp = open(f"individual_card_benefits/{users_cards[index]}.json", "r")
        card_benefits = json.load(fp)

        for earning in card_benefits["earnings"]:
            if earning["category"] == category:
                max_benefits[index] = max(max_benefits[index], earning["points"])

        index += 1

    max_value = max(max_benefits)
    max_value_index = max_benefits.index(max_value)

    return users_cards[max_value_index], max_value, category
