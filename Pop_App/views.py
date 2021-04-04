from django.shortcuts import render, redirect
from .models import *

def index(request):
    allP = Product.objects.all().order_by('-created_at')[:6]
    context = {
        'allP': allP
    }
    return render(request, 'index.html', context)

def userAccess(request):
    return render(request, 'useraccess.html')

def categoryPage(request, category):
    allProducts = Product.objects.filter(category=category)
    context = {
        'allProducts': allProducts,
        'category': category
    }
    return render(request, 'categoryBooks.html', context)

def bookDetails(request, bookId):
    bookInfo = Product.objects.get(id=bookId)
    category = bookInfo.category
    context = {
        'bookInfo': bookInfo,
        'category': category
    }
    return render(request, 'bookDetails.html', context)

def catalogue(request):
    allP = Product.objects.all()
    context = {
        'allP': allP
    }
    return render(request, 'catalogue.html', context)
# Create your views here.
