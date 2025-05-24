import email
from operator import ge
from os import name
from django.db import models
from django.contrib.auth.models import User
from datetime import date


# Create your models here.
class Register(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    fname= models.CharField(max_length=100,null=True,blank=True)
    lname = models.CharField(max_length=100,null=True,blank=True)
    username=models.EmailField(null=True,blank=True)
    mail = models.EmailField(null=True,blank=True)
    mobile = models.CharField(max_length=12,null=True,blank=True)
    height = models.CharField(max_length=4,null=True,blank=True)
    weight = models.CharField(max_length=3,null=True,blank=True)
    password = models.CharField(max_length=100,null=True,blank=True)
    
    def __str__(self):
        return self.user.first_name 
    
    
GENDER_CHOICES = (
    ('male', 'Male'),
    ('female', 'Female'),
)

PAL_CHOICES = (
    ('1.2', '1.2'),
    ('1.3', '1.3'),
    ('1.4', '1.4'),
    ('1.5', '1.5'),
    ('1.6', '1.6'),
    ('1.7', '1.7'),
    ('1.8', '1.8'),
    ('1.9', '1.9'),
    ('2.0', '2.0'),
    ('2.2', '2.2'),
)
class CalculatedData(models.Model):
    person = models.ForeignKey(Register, on_delete=models.CASCADE)
    gender = models.CharField(choices=GENDER_CHOICES, max_length=8, null=True, blank=True)
    bmi = models.FloatField(null=True)
    bmi_category = models.CharField(null=True, max_length=100)
    pal = models.CharField(choices=PAL_CHOICES, default='1.2', max_length=3, blank=True, null=True)
    bmr = models.FloatField(null=True)
    tmr = models.FloatField(null=True)

    def __str__(self):
        return self.person.user.first_name
    
class Dietitians(models.Model):
    name = models.CharField(max_length=100,null=True)
    Qualification =  models.CharField(max_length=100,null=True)
    email = models.EmailField(null=True)
    phone = models.CharField(max_length=100,null=True)
    password = models.CharField(max_length=100,null=True)
    profile = models.ImageField(upload_to='profile/',null=True)
    
    def __str__(self):
        return self.name
    
    
class Dietitianlogin(models.Model):
    name=models.ForeignKey(Dietitians,on_delete=models.CASCADE)
    username=models.EmailField(null=True)
    password = models.CharField(max_length=100,null=True)
    
    def __str__(self):
        return self.name.name
    
class Membershipplans(models.Model):
    plan_name=models.CharField(max_length=100,null=True)
    price_per_month=models.FloatField(null=True)
    duration_in_months=models.FloatField(null=True)
    personal_trainer=models.BooleanField(default=False)
    Amount_of_people = models.FloatField(null=True)
    number_of_visits = models.CharField(max_length=100,null=True)
    
    def __str__(self):
        return self.plan_name
    
class Bookappointment(models.Model):
    dname = models.ForeignKey(Dietitians,on_delete=models.CASCADE)
    fname= models.CharField(max_length=100,null=True)
    lname = models.CharField(max_length=100,null=True)
    email = models.EmailField(null=True)
    mobile = models.CharField(max_length=12,null=True)
    height = models.CharField(max_length=4,null=True)
    weight = models.CharField(max_length=3,null=True)
    gender = models.CharField(max_length=10,null=True)
    bmi = models.FloatField(null=True)
    bmi_category = models.CharField(max_length=100,null=True)
    bmr = models.FloatField(null=True)
    pal = models.CharField(max_length=3,null=True)
    tmr = models.FloatField(null=True)
    date = models.DateField(auto_now_add=True)
    
    def __str__(self):
        return self.fname
    
class Beforeconfirmation(models.Model):
    STATUS_CHOICES=[
        ('Pending','Pending'),
        ('Paid','Paid')
      
    ] 
    appointment = models.ForeignKey(Bookappointment, on_delete=models.CASCADE)
    bdate = models.DateField()
    btime = models.TimeField()
    fee = models.FloatField()
    status=models.CharField(max_length=50,choices=STATUS_CHOICES,default='Pending')

    def __str__(self):
        return self.appointment.fname
    
class Beforeplanconfirmation(models.Model):
    STATUS_CHOICES=[
        ('Pending','Pending'),
        ('Paid','Paid')
      
    ] 
    user = models.ForeignKey(Register, on_delete=models.CASCADE)
    plan = models.ForeignKey(Membershipplans, on_delete=models.CASCADE)
    bdate = models.DateField()
    status=models.CharField(max_length=50,choices=STATUS_CHOICES,default='Pending')

    def __str__(self):
        return self.plan.plan_name