from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('userAccess', views.userAccess),
    path('category/<str:category>', views.categoryPage),
    path('bookDetails/<int:bookId>', views.bookDetails),
    path('catalogue', views.catalogue)
]