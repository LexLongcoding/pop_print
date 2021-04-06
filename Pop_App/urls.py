from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('userAccess', views.userAccess),
    path('userRegister', views.user_register),
    path('userLogin', views.user_login),
    path('profile', views.profile),
    path('admin_register', views.admin_register),
    path('admin_LogReg', views.admin_LogReg),
    path('logout', views.logout),
    path('adminDash', views.adminDash),
    path('addProduct', views.add_product),
    path('createProduct', views.create_product),
    path('bookDetails/<int:bookId>', views.view_products),
    path('editProduct', views.edit_product),
    path('updateProduct', views.update_product),
    path('category/<str:category>', views.categoryPage),
    path('catalogue', views.catalogue),
    path('createOrder', views.create_order),
    #path('placeOrder', views.place_order),
    path('cart', views.cart),
    path('editOrder', views.edit_order),
    path('updateOrder', views.update_order),
    path('deleteOrder', views.delete_order),
]