from django.contrib import admin



from .models import *
# Register your models here.
class RegisterAdmin(admin.ModelAdmin):
    list_display=('fname','lname','username','password','height','weight')
admin.site.register(Register,RegisterAdmin)

admin.site.register(CalculatedData)
admin.site.register(Dietitians)
admin.site.register(Dietitianlogin)
admin.site.register(Membershipplans)
admin.site.register(Bookappointment)
