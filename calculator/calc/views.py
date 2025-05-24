from ast import Pass
import json
import time
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render,redirect
from django.contrib.auth import authenticate, login,logout
from django.contrib.auth.models import User
from pytz import timezone
from.models import *
from django.contrib import messages
import razorpay
from django.views.decorators.csrf import csrf_exempt
from calculator.settings import EMAIL_HOST_USER
from django.core.mail import send_mail
from django.conf import settings
from django.utils import timezone

# Create your views here.
client = razorpay.Client(auth=("rzp_test_fCVgGqgcfDm0Lh", "oRfjzp64mC7AOuS2XRL5VeaT"))

def home(request):
    plans = Membershipplans.objects.all()
    return render(request,'home.html',{'plans':plans})

def about(request):
    return render(request,'about.html',{})

def classes(request):
    return render(request,'classes.html',{})

def gallery(request):
    return render(request,'gallery.html',{})

def contact(request):
    return render(request,'contact.html',{})

def register(request):
    if request.method =="POST":
        fname = request.POST.get('fname')
        lname = request.POST.get('lname')
        mail = request.POST.get('email')
        mobile = request.POST.get('mobile')
        height = request.POST.get('height')
        weight = request.POST.get('weight')
        password = request.POST.get('password')
        repassword = request.POST.get('repassword')
        if User.objects.filter(username=mail):
            return HttpResponse('<script>alert("User Already Exists!");window.location="/register";</script>')
        if password == repassword:
            user=User.objects.create_user(username=mail,first_name=fname,last_name=lname,email=mail,password=password)
            user.save()
            reg = Register.objects.create(user=user,fname=fname,lname=lname,username=mail,mail=mail,mobile=mobile,height=height,weight=weight,password=password)
            reg.save()
            return render(request,'loginn.html',{})
        return HttpResponse('<script>alert("Password Mismatch");window.location="/register";</script>')
    return render(request,'register.html',{})

def loginn(request):
    if request.method == "POST":
        email = request.POST.get('email')
        password = request.POST.get('password')
        user=authenticate(request,username=email,password=password)
        if user is not None:
            login(request,user)
            messages.success(request,'welcome')
            return redirect('home')
        else:
            messages.warning(request,'invalid')
            return redirect('loginn')
    return render(request,'loginn.html',{})

def logoutt(request):
    logout(request)
    return redirect('home')   

def bmr(request):
    if request.user.is_authenticated:
        reguser = Register.objects.get(user=request.user)
        if CalculatedData.objects.filter(person=reguser):
            last_bmr = CalculatedData.objects.get(person=reguser).bmr
        else:
            last_bmr=None
        return render(request,'bmr.html',{'last_bmr':last_bmr})
    return render(request,'bmr.html',{})

def bmi(request):
    if request.user.is_authenticated:
        reguser = Register.objects.get(user=request.user)
        if CalculatedData.objects.filter(person=reguser):
            last_bmi = CalculatedData.objects.get(person=reguser).bmi
        else:
            last_bmi=None
        return render(request,'bmi.html',{'last_bmi':last_bmi})
    return render(request,'bmi.html',{})

def pal(request):
    return render(request,'pal.html',{})

def checking_bmi_category(bmi):

    bmi_categories = {
        'severe thinnes':
            'Your weight is too low and your life may be at risk.'
            ' Try to gain weight but if you may have problems with'
            ' an eating disorder, please contant an experienced specialist.',
        'underweight':
            'Your weight is too low. You may be suffering from deficiency of'
            ' multiple nutrient elements. Try to gain weight or meet with a'
            ' dietitian to receive a specific menu included your calorie needs.',
        'normal weight':
            'Your weight is perfect! Congratulations and keep going. Still try to'
            ' eat healthy and exercise at least three times a week for maintaining'
            ' your weight and good health.',
        'overweight':
            'Your weight is slightly too high and indicates a risk of obese. For'
            ' improving your body appearance and health you should lose a few'
            ' kilograms by changing a diet and trying to exercises more than before.'
            ' Simple things can make a huge difference.',
        'obese':
            'You have first degree obesity. It is a diseases that should be treated.'
            ' At first you can try to do it on your own by changing diet, eating less'
            ' calories and exercising more but if you notices that your efforts do'
            ' not yield expected results, contact with an experienced specialist like'
            ' a dietitian or personal trainer.',
        'severely obese':
            'You have second degree obesity. It is a serious danger for your health.'
            ' Start treating as soon as it is possible. Contact with a dietitian who'
            ' has an experience in working with patients with obese and changed your'
            ' whole lifestyle.',
        'morbidly obese':
            'You have third degree obesity. This is a really danger diseases that'
            ' threatens your health and even your life. You should meet an experienced'
            ' specialist immediately. Sometimes in the treatment it becomes necessary'
            ' to involve psychologists, especially eating disorder therapists.'
    }

    if bmi < 16:
        category = 'severe thinnes'
    elif bmi < 18.5:
        category = 'underweight'
    elif 18.5 <= bmi < 25:
        category = 'normal weight'
    elif 25 <= bmi < 30:
        category = 'overweight'
    elif 30 <= bmi < 35:
        category = 'obese'
    elif 35 <= bmi < 40:
        category = 'severely obese'
    else:
        category = 'morbidly obese'

    return {
        'calculated_bmi': bmi,

        'category': category,
        'description': bmi_categories[category]
    }


def bmi_calculator_filled_out(request):
    if request.method == "POST":
        height = request.POST.get('height')
        weight = request.POST.get('weight')
        gender  = request.POST.get('gender')
        height = float(height)
        weight = float(weight)
        if request.user.is_authenticated:
            reguser = Register.objects.get(user=request.user)
            if CalculatedData.objects.filter(person=reguser):
                last_bmi = CalculatedData.objects.get(person=reguser).bmi
            else:
                last_bmi=None                
            if CalculatedData.objects.filter(person=reguser):
                data = CalculatedData.objects.get(person=reguser)
                data.gender=gender
                data.bmi= round(weight/ (height * 0.01) ** 2, 2)
                a=checking_bmi_category(data.bmi)
                data.bmi_category=a['category']
                data.save()
            else:
                bmi=round(weight / (height * 0.01) ** 2, 2)
                a=checking_bmi_category(bmi)
                c=CalculatedData.objects.create(person=reguser,gender=gender,bmi=bmi,bmi_category=a['category'])
                c.save()
        else:
            bmi=round(weight / (height * 0.01) ** 2, 2)
            a=checking_bmi_category(bmi)
        return render(request,'bmiresult.html',{"calculated_bmi":a['calculated_bmi'],"category":a['category'],'description':a['description']})
    return render(request, 'bmi.html', { 'last_bmi': last_bmi})

def calculate_bmr(age, gender, height, weight):
    """
    Calculate BMR (Basal Metabolic Rate) based on age, gender ('female' or 'male'),
    height (in centimeters) and weight (in kilograms).
    """
    if gender == 'male':
        bmr_result = (10 * weight) + (6.25 * height) - (5 * age) + 5
    elif gender == 'female':
        bmr_result = (10 * weight) + (6.25 * height) - (5 * age) - 161
    else:
        raise ValueError(
            "Gender is required to calculate BMR. "
            "Please provide 'male' or 'female' value."
        )
    return bmr_result
        
def bmr_calculator_filled_out(request):
    if request.method == "POST":
        age = request.POST.get('age')
        gender = request.POST.get('gender')
        height = request.POST.get('height')
        weight = request.POST.get('weight')
        height = float(height)
        weight = float(weight)
        age = float(age)
        if request.user.is_authenticated:
            reguser = Register.objects.get(user=request.user)
            if CalculatedData.objects.filter(person=reguser):
                last_bmr = CalculatedData.objects.get(person=reguser).bmr
            else:
                last_bmr=None
            if CalculatedData.objects.filter(person=reguser):
                data = CalculatedData.objects.get(person=reguser)
                data.gender=gender
                data.bmr=calculate_bmr(age,gender,height,weight)
                data.save()
                bmr=data.bmr
            else:
                bmr=calculate_bmr(age,gender,height,weight)
                c=CalculatedData.objects.create(person=reguser,gender=gender,bmr=bmr)
                c.save()
        else:
            bmr=calculate_bmr(age,gender,height,weight)
        return render(request,'bmrresult.html',{"calculated_bmr":bmr})
    return render(request, 'bmr.html', { 'last_bmr': last_bmr})


def tmr(request):
    if request.user.is_authenticated:
        reguser = Register.objects.get(user=request.user)
        if CalculatedData.objects.filter(person=reguser):
            last_tmr = CalculatedData.objects.get(person=reguser).tmr
        else:
            last_tmr=None
        return render(request,'tmr.html',{'last_tmr':last_tmr})
    return render(request,'tmr.html',{})

def calculate_tmr(age, gender, height, weight,pal):
    """
    Calculate TMR (Total Metabolic Rate) based on age, gender ('female' or 'male'),
    height (in centimeters), weight (in kilograms) and PAL.
    """
    if gender == 'male':
        tmr_result = round(((10 * weight) + (6.25 * height) -
                           (5 * age) + 5) * float(pal), 2)
    elif gender == 'female':
        tmr_result = round(((10 * weight) + (6.25 * height) -
                            (5 * age) - 161) * float(pal), 2)
    else:
        raise ValueError(
            "Gender is required to calculate TMR. "
            "Please provie 'male' or 'female' value."
        )
    return tmr_result


def tmr_calculator_filled_out(request):
    if request.method == "POST":
        age = request.POST.get('age')
        gender = request.POST.get('gender')
        height = request.POST.get('height')
        weight = request.POST.get('weight')
        pal = request.POST.get('pal')
        height = float(height)
        weight = float(weight)
        age = float(age)
        if request.user.is_authenticated:
            reguser = Register.objects.get(user=request.user)
            if CalculatedData.objects.filter(person=reguser):
                last_tmr = CalculatedData.objects.get(person=reguser).tmr
            else:
                last_tmr=None
            if CalculatedData.objects.filter(person=reguser):
                data = CalculatedData.objects.get(person=reguser)
                data.gender=gender
                data.tmr=calculate_tmr(age,gender,height,weight,pal)
                data.pal=pal
                data.save()
               
                tmr=data.tmr
            else:
                tmr=calculate_tmr(age,gender,height,weight,pal)
                c=CalculatedData.objects.create(person=reguser,gender=gender,pal=pal,tmr=tmr)
                c.save()
        else:
            tmr=calculate_tmr(age,gender,height,weight,pal)
        return render(request,'tmrresult.html',{"calculated_tmr":tmr})
    return render(request, 'tmr.html', { 'last_tmr': last_tmr})

def consult_dietitian(request):
    # user=Register.objects.get(user=request.user)
    dietitian = Dietitians.objects.all()
    return render(request,'consult.html',{'dietitians':dietitian})

def dietitian(request):
    if request.method=="POST":
        name=request.POST.get('name')
        qualification = request.POST.get('qualification')
        email = request.POST.get('email')
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        repassword = request.POST.get('repassword')
        image = request.FILES.get('pic')
        if Dietitians.objects.filter(email=email):
            return HttpResponse('<script>alert("Email Already Exists!");window.location="/dietitian";</script>')
        if password==repassword:
            d=Dietitians.objects.create(name=name,Qualification=qualification,email=email,phone=mobile,password=password,profile=image)
            d.save()
            l=Dietitianlogin.objects.create(name=d,username=email,password=password)
            l.save()
            # request.session['username']=email
            # request.session['password']=password
            return render(request,'dietitianlogin.html',{})
        return HttpResponse('<script>alert("password mismatches");window.location="/dietitian";</script>')
    return render(request,'dietitianregister.html',{})

def dietitianlogin(request):
    print("qwerty")
    try:
        if request.method=="POST":
            username = request.POST.get('email')
            password = request.POST.get('password')
            print("hii")
            if Dietitianlogin.objects.filter(username=username,password=password):
                d=Dietitianlogin.objects.get(username=username,password=password)
                request.session['username']=username
                request.session['name']=d.name.name
                print("hello")
                return redirect('home')
            return render(request,'consult.html',{})
        return render(request,'dietitianlogin.html',{})
    except Exception as e:
        print("errorrrrrr",e)
        
def fillform(request,id):
    reguser = Register.objects.get(user=request.user)
    print("reguser",reguser)
    if CalculatedData.objects.filter(person=reguser).exists():
        data = CalculatedData.objects.get(person=reguser)
        print("data",data)
    else:
        messages.add_message(request,messages.WARNING,'Please do the BMI, BMR, TMR and PAL calculator first')   
        return redirect('home')
    dietitian = Dietitians.objects.get(id=id)
    # if Bookappointment.objects.filter(fname=reguser.fname,lname=reguser.lname).exists:
        
    if request.method=="POST":
        dname = request.POST.get('dname')
        fname = request.POST.get('fname')
        lname = request.POST.get('lname')
        email = request.POST.get('email')
        mobile = request.POST.get('mobile')
        height = request.POST.get('height')
        weight = request.POST.get('weight')
        gender = request.POST.get('gender')
        bmi = request.POST.get('bmi')
        bmi_category = request.POST.get('bmi_category')
        pal = request.POST.get('pal')
        bmr = request.POST.get('bmr')
        tmr = request.POST.get('tmr')
        if Bookappointment.objects.filter(fname=reguser.fname,lname=reguser.lname).exists():
            d = Bookappointment.objects.get(fname=reguser.fname,lname=reguser.lname)
            d.dname=dietitian
            d.fname=fname
            d.lname=lname
            d.email=email
            d.mobile=mobile
            d.height=height
            d.weight=weight
            d.gender=gender
            d.bmi=bmi
            d.bmi_category=bmi_category
            d.bmr=bmr
            d.pal=pal
            d.tmr=tmr
            d.save()
        else:
            d = Bookappointment.objects.create(dname=dietitian,fname=fname,lname=lname,email=email,mobile=mobile,height=height,weight=weight,gender=gender,bmi=bmi,bmi_category=bmi_category,bmr=bmr,pal=pal,tmr=tmr)
            d.save()
        return redirect('consult_dietitian')
    return render(request,'fillform.html',{'data':data,'dietitian':dietitian})

def viewprofile(request):
    if request.session.has_key('username'):
        username = request.session['username']
        d=Dietitianlogin.objects.get(username=username)
        b=Beforeconfirmation.objects.filter(appointment__dname=d.name,status='Paid')
        print("b",b)
        return render(request,'viewprofile.html',{'d':d,'b':b})
    else:
        return redirect('dietitianlogin')
    
def bookappointment(request,id):
    reguser = Register.objects.get(user=request.user)
    print("reguser",reguser)
    if CalculatedData.objects.filter(person=reguser).exists():
        data = CalculatedData.objects.get(person=reguser)
        print("data",data)
    else:
        messages.add_message(request,messages.WARNING,'Please do the BMI, BMR, TMR and PAL calculator first')   
        return redirect('home')
    dietitian = Dietitians.objects.get(id=id)
    # d = Bookappointment.objects.filter(fname=reguser.fname,lname=reguser.lname)
    if Bookappointment.objects.filter(fname=reguser.fname,lname=reguser.lname).exists():
        d= Bookappointment.objects.get(fname=reguser.fname,lname=reguser.lname)
    else:
        d = Bookappointment.objects.create(dname=dietitian,fname=reguser.fname,lname=reguser.lname,email=reguser.mail,mobile=reguser.mobile,height=reguser.height,weight=reguser.weight,gender=data.gender,bmi=data.bmi,bmi_category=data.bmi_category,bmr=data.bmr,pal=data.pal,tmr=data.tmr)
        d.save()
    if Beforeconfirmation.objects.filter(appointment=d).exists():
        messages.add_message(request,messages.WARNING,'Already booked an appointment please check your mail or contact us')
        return redirect('consult_dietitian')
    return render(request,'bookappointment.html',{'data':d})

def checkout(request,id):
    if request.method=="POST":
        b=Bookappointment.objects.get(id=id)
        bdate = request.POST.get('bookdate')
        btime = request.POST.get('booktime')
        fee = request.POST.get('fee')
        bc = Beforeconfirmation.objects.create(appointment=b,bdate=bdate,btime=btime,fee=fee)
        bc.save()
        DATA = {
            'amount': int(bc.fee) * 100,  # amount in the smallest currency unit
            'currency': 'INR',
            'receipt': str(bc.id),
        }
        razorpay_order = client.order.create(data=DATA)
        order_id = razorpay_order['id']
        return JsonResponse({'order_id': order_id,'status': 'order created successfully','fee':bc.fee})
    return redirect('bookappointment',id=id)

@csrf_exempt
def payment_success(request,id):
    try:
        b=Bookappointment.objects.get(id=id)
        bc = Beforeconfirmation.objects.get(appointment=b)
        bc.status='Paid'
        bc.save()
        html_message=f"""
        <body style="background-color:#bad3ed">
        <h1>Dear {bc.appointment.fname} {bc.appointment.lname}, </h1>
        <p>Thank you for your Appointment with<b><i>eHealth</i></b></p>
        <p>Dietitan Name: {bc.appointment.dname}</p>
        <p>Date: {bc.bdate}</p>
        <p>Time: {bc.btime}</p>
        <p>Amount: {bc.fee}</p>
        </hr>
        <h2>Questions?</h2>
        <p>Contact us at gouridemo@gmail.com</p>
        <p>Visit site: <a href="http://127.0.0.1:8000/">http://127.0.0.1:8000/</a></p>
        <p>We appreciate your interest in our classes and look forward to book with our dieitian!</p>
        <p>Sincerely,</p>
        <p><b>eHealth</b></p>
        </body>
        """
        send_mail(
            subject='eHealth Payment Confirmation',
            message='This is plain text message',
            from_email=settings.EMAIL_HOST_USER,
            recipient_list=[request.user.email],
            fail_silently=False,
            html_message=html_message
        )
        return JsonResponse({'status': 'success'})
    except Exception as e:
        print("error",e)
        return JsonResponse({'status': 'error', 'message': str(e)})
    
def checkoutplan(request,id):
    if request.method=="POST":
        user=Register.objects.get(user=request.user)
        print("qwertyuuuu")
        if Beforeplanconfirmation.objects.filter(user=user).exists():
            print("dfgdgdgnfgjngf")
            # messages.add_message(request,messages.WARNING,'Already booked a plan please check your mail or contact us')
            messages.warning(request,'Already booked a plan please check your mail or contact us')

            return redirect('home')
        b=Membershipplans.objects.get(id=id)
        bdate = timezone.now()
        print("bdate",bdate)
        # fee = request.POST.get('fee')
        bc = Beforeplanconfirmation.objects.create(user=user,plan=b,bdate=bdate)
        bc.save()
        DATA = {
            'amount': int(bc.plan.price_per_month) * 100,  # amount in the smallest currency unit
            'currency': 'INR',
            'receipt': str(bc.id),
        }
        razorpay_order = client.order.create(data=DATA)
        order_id = razorpay_order['id']
        return JsonResponse({'order_id': order_id,'status': 'order created successfully','fee':bc.plan.price_per_month})
    return redirect('home')

@csrf_exempt
def plan_payment_success(request,id):
    try:
        b=Membershipplans.objects.get(id=id)
        bc = Beforeplanconfirmation.objects.get(plan=b)
        bc.status='Paid'
        bc.save()
        html_message=f"""
        <body style="background-color:#bad3ed">
        <h1>Dear {bc.user.fname} {bc.user.lname}, </h1>
        <p>Thank you for choosing Membership plan with<b><i>eHealth</i></b></p>
        <p>Membership Plan: {bc.plan.plan_name}</p>
        <p>Date: {bc.bdate}</p>
        <p>Amount: {bc.plan.price_per_month}</p>
        </hr>
        <h2>Questions?</h2>
        <p>Contact us at gouridemo@gmail.com</p>
        <p>Visit site: <a href="http://127.0.0.1:8000/">http://127.0.0.1:8000/</a></p>
        <p>We appreciate your interest in our classes,membersehip plans and look forward to book with our dieitian!</p>
        <p>Sincerely,</p>
        <p><b>eHealth</b></p>
        </body>
        """
        send_mail(
            subject='eHealth Payment Confirmation',
            message='This is plain text message',
            from_email=settings.EMAIL_HOST_USER,
            recipient_list=[request.user.email],
            fail_silently=False,
            html_message=html_message
        )
        return JsonResponse({'status': 'success'})
    except Exception as e:
        print("error",e)
        return JsonResponse({'status': 'error', 'message': str(e)})