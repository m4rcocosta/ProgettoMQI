#def dictionaries for classes
aeroplane = {}
bicycle = {}
bird = {}
boat = {}
bottle = {}
bus = {}
car = {}
cat = {}
chair = {}
cow = {}
diningtable = {}
dog = {}
horse = {}
motorbike = {}
person = {}
pottedplant = {}
sheep = {}
sofa = {}
train = {}
tvmonitor = {}

#load values
classes = ["aeroplane", "bicycle", "bird", "boat", "bottle", "bus", "car", "cat", "chair", "cow", "diningtable", "dog", "horse", "motorbike", "person", "pottedplant", "sheep", "sofa", "train", "tvmonitor"]
for elem in classes:
    f = open("../data/VOC2007/Txt/"+elem+"_test.txt",'r',encoding="utf-8")
    for row in f:
        img_value = row.strip().split()
        eval(elem)[img_value[0]] = int(img_value[1])
    f.close()

#check
f = open("../output/darknet/darknet_voc2007.txt","r",encoding="utf-8")
f.readline()
f.readline() #First and second lines are not important
out = open("../output/darknet/darknet_voc2007_check.txt","w",encoding="utf-8")

images = {}
result = ""
correct = 0
wrong = 0

for row in f:
    if "/" in row:
        image = ((row.strip().split("/"))[5])[:6]   #image number
        images[image] = 1
        
    if "%" in row:
        obj = ((row.strip().split())[0])[:-1]       #class
        if obj in classes:
            if images.get(image) == 1:
               images[image] = (eval(obj)).get(image)

#sorting images
res = []
for key in images:
    if images.get(key) == 1:
        correct += 1
        result = "correct"
    else:
        wrong += 1
        result = "wrong"
    #print(key+" "+result+"\n", end="", file=out)
    res.append([key, result])

res.sort()
for elem in res:
    print(elem[0]+" "+elem[1]+"\n", end="", file=out)

print("\n\n", end="", file=out)
print("Correct = "+str(correct)+"\n", end="", file=out)
print("Wrong = "+str(wrong)+"\n", end="", file=out)

f.close()
out.close()