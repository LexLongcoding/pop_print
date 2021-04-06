from django.shortcuts import render, redirect
from .models import User, Admin, Product, Order
from django.contrib import messages
import datetime

def index(request):
    return render(request, 'index.html')

def userAccess(request):
    return render(request, 'useraccess.html')

def user_register(request):
    if request.method == "GET":
        return redirect('/userAccess')
    errors = User.objects.validate_user(request.POST)
    if len(errors) > 0:
        for key, value in errors.items():
            messages.error(request, value)
        return redirect('/userAccess')
    else:
        if request.method == "POST":
            user = User.objects.register(request.POST)
            request.session['user_id'] = user.id
            request.session['user_name'] = user.first_name
        return redirect('/')

def user_login(request):
    if request.method == "GET":
        return redirect('/userAccess')
    if not User.objects.authenticate_user(request.POST['email'], request.POST['password']):
        messages.error(request, 'Invalid Email/Password')
        return redirect('/userAccess')
    user = User.objects.get(email=request.POST['email'])
    request.session['user_id'] = user.id
    request.session['user_name'] = user.first_name
    return redirect('/')

def admin_register(request):
    '''if request.method == "GET":
        return redirect('/adminRegister')
    errors = Admin.objects.validate(request.POST)
    if len(errors) > 0:
        for key, value in errors.items():
            messages.error(request, value)
        return redirect('/adminRegister')'''
    if request.method == "POST":
        admin = Admin.objects.register(request.POST)
        request.session['admin_id'] = admin.id
        request.session['email'] = admin.email
    return render(request, 'adminDash.html')

def admin_LogReg(request):
    if request.method == "POST":
        admin = Admin.objects.register(request.POST)
        request.session['admin_id'] = admin.id
        request.session['email'] = admin.email
    return render(request, 'admin_LogReg.html')

def logout(request):
    request.session.clear()
    return redirect('/userLogin')

def profile(request):
    user = None if 'user_id' not in request.session else User.objects.get(id=request.session['user_id'])
    if not user:
        return redirect('/userLogin')
    context = {
        'user' : User.objects.get(id=request.session['user_id'])
    }
    return render(request, 'profile.html', context)

def adminDash(request):
    return render(request, 'adminDash.html')

def add_product(request):
    admin = None if 'admin_id' not in request.session else Admin.objects.get(id=request.session['admin_id'])
    if not admin:
        return redirect('/adminLogin')
    return render(request, 'add_product.html')

def create_product(request):
    user = None if 'user_id' not in request.session else User.objects.get(id=request.session['user_id'])
    if not user:
        return redirect('/adminLogin')
    if request.method == 'POST':
        errors = Products.objects.validate(request.POST)
        if len(errors) > 0:
            for key, value in errors.items():
                messages.error(request, value)
            return redirect('/createProduct')
    Product.objects.create(title=request.POST.get('title'), category=request.POST.get('category'), description=request.POST.get('description'), price=request.POST.get('price'), product_added_by=admin, favorited_by=user)
    return redirect('/catalogue')

def view_products(request):
    admin = None if 'admin_id' not in request.session else Admin.objects.get(id=request.session['admin_id'])
    if not admin:
        return redirect('/adminLogin')
    context = {
        'product': Product.objects.get(id=product_id)
    }
    return render('bookDetails.html', context)

def edit_product(request, product_id):
    admin = None if 'admin_id' not in request.session else Admin.objects.get(id=request.session['admin_id'])
    if not admin:
        return redirect('/adminLogin')
    context = {
        'product': Product.objects.get(id=product_id)
    }
    return render(request, 'editBook.html', context)

def update_product(request, product_id):
    errors = Admin.objects.update_validate(request.POST)
    if request.method == "POST":
        update_product = Product.objects.get(id=product_id)
        update_product.title = request.POST['title']
        update_product.category = request.POST['category']
        update_product.description = request.POST['description']
        update_product.price = request.POST['price']
        update_product.save()
    return redirect('/bookDetails/<int:bookId>')

def categoryPage(request, category):
    context = {
        'category': Product.objects.filter(category=category)
    }
    return render(request, 'categoryBooks.html', context)

def catalogue(request):
    context = {
        'product': Product.objects.all()
    }
    return render(request, 'shop.html', context)

def create_order(request):
    order = Order.objects.create(
        ordered_products = request.POST['ordered_products'],
        ordered_by = User.objects.get(id=request.session['user_id'])
    )
    order.save()
    if 'user_id' not in request.session:
        return redirect('/userLogin')
    user = User.objects.get(id=request.session['user_id'])
    user_orders = Order.objects.filter(ordered_by=user.id)
    other_orders = Order.objects.exclude(ordered_by=user.id)
    context = {
        "user": user,
        "user_orders": user_orders,
        "other_orders": other_orders
    }
    return render(request, 'cart.html', context)
    
def cart(request):
    if 'user_id' not in request.session:
        return redirect('/userAccess')
    user = User.objects.get(id=request.session['user_id'])
    user_orders = Order.objects.filter(ordered_by=user.id)
    other_orders = Order.objects.exclude(ordered_by=user.id)
    context = {
        'user': user,
        "user_orders": user_orders,
        "other_orders": other_orders,
        "all_orders": Order.objects.all()
    }
    return render(request, 'cart.html', context)

def edit_order(request, order_id):
    user = None if 'user_id' not in request.session else User.objects.get(id=request.session['user_id'])
    if not user:
        return redirect('/userLogin')
    context = {
        'order': Order.objects.get(id=order_id)
    }
    return redirect('/editOrder')

def update_order(request, order_id):
    errors = User.objects.update_validate(request.POST)
    if len(errors) > 0:
        for key, value in errors.items():
            messages.error(request, value)
        return redirect('/userLogin')
    else:
        if request.method == "POST":
            update_order = Order.objects.get(id=order_id)
            update_order.ordered_products = request.POST['ordered_products']
            update_order.buyer_name = request.POST['buyer_name']
            update_order.buyer_address = request.POST['buyer_address']
            update_order.buyer_city = request.POST['buyer_city']
            update_order.buyer_state = request.POST['buyer_state']
            update_order.buyer_zip = request.POST['buyer_zip']
            update_order.buyer_CC = request.POST['buyer_CC']
            update_order.buyer_security = request.POST['buyer_security']
            update_order.buyer_exp = request.POST['buyer_exp']
            update_order.recipient_name = request.POST['recipient_name']
            update_order.recipient_address = request.POST['recipient_address']
            update_order.recipient_city = request.POST['recipient_city']
            update_order.recipient_state = request.POST['recipient_state']
            update_order.recipient_zip = request.POST['recipient_zip']
            update_order.save()
            return redirect('/cart')
        return redirect('/cart')

def delete_order(request, order_id):
    user = None if 'user_id' not in request.session else User.objects.get(id=request.session['user_id'])
    if not user:
        return redirect('/userLogin')

    order = Order.objects.get(id=order_id)
    if order.ordered_by == user:
        order.delete()
    return redirect('/profile')
