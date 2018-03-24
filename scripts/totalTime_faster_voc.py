totalTime = 0

def isfloat(value):
    try:
        float(value)
        return True
    except ValueError:
        return False

#calculate total time        
output = open("../output/faster/faster-rcnn_voc2007.txt","r",encoding="utf-8")
for riga in output:
    if '/' in riga:
        words=riga.strip().split()
        for word in words:
            if isfloat(word):
                time = float(word)
                totalTime += time
output.close()

#write total time on output file
output = open("../output/faster/faster-rcnn_voc2007.txt","a",encoding="utf-8")
result = "\nTime(Image detection): "+str(totalTime)+" seconds ("+str(totalTime/60)+" minutes).\n"
output.write(result)
output.close()