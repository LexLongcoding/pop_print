from django.db import models
from datetime import datetime
import re, bcrypt

EMAIL_REGEX = re.compile('^[_a-z0-9-]+(.[_a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)(.[a-z]{2,4})$')

class UserManager(models.Manager):
    def validate_user(self, form):
        errors = {}
        if len(form['username']) < 2:
            errors['username'] = 'First Name must be at least 2 characters'
        
        username_check = self.filter(username=form['username'])
        if username_check:
            errors['username'] = "Username already in use"

        if not EMAIL_REGEX.match(form['email']):
            errors['email'] = 'Invalid Email Address'
        
        email_check = self.filter(email=form['email'])
        if email_check:
            errors['email'] = "Email already in use"

        if len(form['password']) < 8:
            errors['password'] = 'Password must be at least 8 characters'
        
        if form['password'] != form['confirm']:
            errors['password'] = 'Passwords do not match'
        
        return errors
    
    def authenticate_user(self, email, password):
        users = self.filter(email=email)
        if not users:
            return False

        user = users[0]
        return bcrypt.checkpw(password.encode(), user.password.encode())

    def register(self, form):
        pw = bcrypt.hashpw(form['password'].encode(), bcrypt.gensalt()).decode()
        return self.create(
            first_name = form['first_name'],
            last_name = form['last_name'],
            email = form['email'],
            password = pw,
        )

class User(models.Model):
    first_name = models.CharField(max_length=45)
    last_name = models.CharField(max_length=45)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)
    #user_orders
    #favorited_products 

    objects = UserManager()

class AdminManager(models.Manager):
    def validate_admin(self, form):
        errors = {}
        if not EMAIL_REGEX.match(form['email']):
            errors['email'] = 'Invalid Email Address'
        
        email_check = self.filter(email=form['email'])
        if email_check:
            errors['email'] = "Email already in use"

        if len(form['password']) < 8:
            errors['password'] = 'Password must be at least 8 characters'
        
        if form['password'] != form['confirm']:
            errors['password'] = 'Passwords do not match'
        
        return errors
    
    def authenticate_admin(self, email, password):
        admins = self.filter(email=email)
        if not admins:
            return False

        admin = admins[0]
        return bcrypt.checkpw(password.encode(), user.password.encode())

        def register(self, form):
            pw = bcrypt.hashpw(form['password'].encode(), bcrypt.gensalt()).decode()
            return self.create(
                email = form['email'],
                password = pw,
            )

class Admin(models.Model):
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)
    #products_added

    objects = AdminManager()

class ProductManager(models.Manager):
    def validate(self, form):
        errors = {}
        if len(form['title']) < 2:
            errors['title'] = 'Destination field should be at least 2 characters'
        if len(form['description']) < 10:
            errors['description'] = 'Description field should be at least 10 characters'
            
            return self.create(
                title = form['title'],
                category = form['category'],
                description = form['description'],
                price = form ['price'],
            )
        

class Product(models.Model):
    title = models.CharField(max_length=255)
    category = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    price = models.DecimalField(decimal_places=2, max_digits=6)
    created_at = models.DateTimeField(auto_now_add=True)
    product_added_by = models.ForeignKey(Admin, related_name='products_added', on_delete=models.CASCADE)
    updated_at = models.DateTimeField(auto_now=True)
    favorited_by = models.ManyToManyField(User, related_name='favorited_products')
    #included_in   <= Product is included in orders.   
    objects = ProductManager()

class Order(models.Model):
    ordered_products = models.ManyToManyField(Product, related_name='included_in')
    total_price = models.DecimalField(decimal_places=2, max_digits=6)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    ordered_by = models.ForeignKey(User, related_name='user_orders', on_delete=models.CASCADE)
    buyer_name = models.CharField(max_length=255)
    buyer_address = models.CharField(max_length=255)
    buyer_city = models.CharField(max_length=255)
    buyer_state = models.CharField(max_length=255)
    buyer_zip = models.IntegerField()
    buyer_CC = models.IntegerField()
    buyer_securtiy = models.IntegerField()
    buyer_exp = models.DateField()
    recipiant_name = models.CharField(max_length=255)
    recipiant_address = models.CharField(max_length=255)
    recipiant_city = models.CharField(max_length=255)
    recipiant_state = models.CharField(max_length=255)
    recipiant_zip = models.IntegerField()
# Create your models here.
