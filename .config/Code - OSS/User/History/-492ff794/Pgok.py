import requests as req
import datetime as dt
import json
import sys
from typing import Tuple

# def choose_from_search(merchant_list):
#     dict_merchants = {}
#     i = 0
#     for _ in merchant_list:
#         name = merchant_list[i]["responseValues"]["visaMerchantName"]
#         if name not in dict_merchants:
#             print(str(i) + ": " + name)
#             dict_merchants[name] = i
#         i += 1
#     choice = int(input("Select from results: "))
#     return choice
#
def get_mcc(merchant: str) -> Tuple[list, list, str, bool]:
    url = "https://sandbox.api.visa.com/merchantsearch/v2/search"

    # Credentials
    user_id = '3NUUUSZED3T6RWRIIBFB21urlNY0C9i-M8U4-WQy2gxaCY0wA'
    password = '21KVAB9jpA'
    cert = 'creds/cert.pem'
    key = 'creds/key_a3206cd6-ea45-484b-ab7f-63b257505140.pem'

    date = dt.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")

    header = {
        "cdisiAutoGenId": "CDISIVDP97666-1992148876"
    }

    body = {
        "searchOptions": 
        {
            "matchScore": "true",
            "maxRecords": "10",
            "matchIndicators": "true",
            # "proximity": 
            # ["merchantName"],
            # "wildCard": 
            # ["merchantName"]
        },
        "header": 
        {
            "requestMessageId": "VCO_GMR_001",
            "startIndex": "0",
            "messageDateTime": date
        },
        "searchAttrList": 
        {
            "merchantName": merchant,
            "merchantCountryCode": "840",
        },
        "responseAttrList": 
        [
            "GNSTANDARD"
        ]
    }

    print("MERCHANT: ", merchant)
    try:
        response = req.post(url, cert=(cert, key), auth=(user_id, password), headers=header, json=body)
        print(response.text)
    except req.exceptions.RequestException as e:
        print(e)
        sys.exit()

    if (response.status_code == 500):
        print("Visa API is currently offline... Try again later...")
        sys.exit()

    p = json.loads(json.dumps(response.json()))
    check = p["merchantSearchServiceResponse"]["header"]["numRecordsReturned"]

    if check == 0:
        print("Invalid search term... please try again")
        sys.exit()

    # merchant_list = p["merchantSearchServiceResponse"]["response"][0]
    # choice = choose_from_search(merchant_list)

    values = p["merchantSearchServiceResponse"]["response"][0]["responseValues"]
    mcc = values["merchantCategoryCode"]
    mcc_desc = values["merchantCategoryCodeDesc"]
    name = values["visaMerchantName"]

    has_chip = False
    if "terminalType" in values:
        has_chip = "CHIP" in values["terminalType"]
    return mcc, mcc_desc, name, has_chip
