from django.shortcuts import render
# from django.http import HttpResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from visa_mcc_test import final_determine_card
import json

# Create your views here.

@api_view(['GET'])
def index(request):
    return Response({'message': 'index'})

@api_view(['GET', 'POST'])
def determine_optimal_card(request):
    if request.method == 'GET':
        return Response({'card_name': 'get_request_testing'})
    elif request.method == 'POST':
        # Do try except here
        print(type(request.data))
        # card_name = final_determine_card(request.data["merchant"])
        return_info = final_determine_card(request.data)
        card_info = return_info[0]
        return Response({'card_name': card_info[0], 
                         'cashback_percent': card_info[1], 
                         'cashback_category': card_info[2], 
                         'merchant_name': return_info[1]}, 
                        status=status.HTTP_200_OK)