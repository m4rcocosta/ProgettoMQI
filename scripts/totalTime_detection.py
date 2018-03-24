import sys

def isfloat(value):
    try:
        float(value)
        return True
    except ValueError:
        return False

totalTime = 0
output_name = str(sys.argv[1])

#calculate total time        
output = open("../"+output_name,"r",encoding="utf-8")
for riga in output:
    if '/' in riga:
        words=riga.strip().split()
        for word in words:
            if isfloat(word):
                time = float(word)
                totalTime += time
output.close()

#write total time on output file
output = open("../"+output_name,"a",encoding="utf-8")
result = "\nTime(Image detection): "+str(totalTime)+" seconds ("+str(totalTime/60)+" minutes).\n"
output.write(result)
output.close()