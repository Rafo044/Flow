#random , uniform
#randint, randrange
#choice, sample, shuffle
import random
#random funksiyası

#random funsiyası 0 ilə 1 arasında ədədlər döndürür.
for i in range(10):
    print(random.random())

#uniform funsiyası 2 ədəd arasında təsadüfi ədələr döndürür.
for x in range(10):
    print(random.uniform(10,50))

#randrange funksiyası iki ədəd aralıgında istədiyimiz silsilədə artırmağımıza imkan verir.

for m in range(10):
    print(random.randrange(10,50,5))

list = ["mavi","qırmızı","yaşıl"]
#choice listdən hər hansı bir dəyər seçir.
for choice in range(10):
    print(random.choice(list))


#sample listən dəyərlər seçir.(bir neçə)
for sample in range(20):
    print(random.sample(list,2))


#shuffle listi qarı.dırmaq üçündür.(yerdəyişmə edir)
for shuffle in range(10):
    y = random.shuffle(list)