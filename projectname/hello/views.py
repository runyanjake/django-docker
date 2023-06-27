from django.shortcuts import render

from django.http import HttpResponse

def hello_world(request):
    return HttpResponse("Hello World!");

def hello_queryparam(request, query_param):
    return HttpResponse("Passed Query Param: " + str(query_param));

