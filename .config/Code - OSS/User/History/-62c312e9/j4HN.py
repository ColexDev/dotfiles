#!/usr/bin/env python3
import sys
from mcc import *
from choose_card import *

if len(sys.argv) != 2:
    print("Please input merchant name")
    sys.exit()

# def final_determine_card(input_merchant: str):
def final_determine_card(input):
    mcc, mcc_desc, merchant, nfc = get_mcc(input["merchant"])
    print(f"\nMCC Description of {merchant}: {mcc_desc}")

    if nfc:
        print(f"{merchant} accepts NFC\n")
    else:
        print(f"{merchant} does NOT accept NFC\n")


    cards_fp = open("user_cards.txt", "r")
    users_cards = cards_fp.read()
    users_cards = users_cards.split("\n")
    users_cards.pop()

    print("USERS CARDS: ", users_cards)
    determine_card(users_cards, mcc_desc)
