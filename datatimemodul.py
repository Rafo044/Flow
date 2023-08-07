from datetime import date

# date obyekti hər hansı zamanı əllə daxil etməyimizə, onu datetime tipinə çevirməyimizə kömək edir.
kechmish_zaman = date(2015,12,23)

print(kechmish_zaman)
print(kechmish_zaman.weekday()) #0 başlanğıcından həftələri hesablıyır.
print(kechmish_zaman.isoweekday()) #1 başlanğıcından həftələri hesablıyır.


#Tarixdə olan ardıcıllığın dəyişdirilməsi 
indi = date.today()

print(indi.strftime("%d.%m.%Y"))
