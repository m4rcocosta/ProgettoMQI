#!/bin/bash

#Check parameters
args=("$@")
if [ $# -ne 3 ]
then {
    echo "Error: Please insert correct parameters (NET{darknet/faster-rcnn} SET{voc2007/coco2017} TRESHOLD[0.0-1.0])"
    exit 1
}  
fi

NET=${args[0],,} #Convert string to lowercase
SET=${args[1],,} #Convert string to lowercase
TRESHOLD=${args[2]}

##Check network
if [ $NET == "darknet" ]
then {
    echo "darknet"
    MODEL=cfg/voc.data
    CFG=cfg/yolo-voc.cfg
    WEIGHTS=cfg/yolo-voc.weights
}
elif [ $NET == "faster-rcnn" ]
then {
    echo "faster-rcnn"
}
else {
    echo "Error: Please chose correct network (darknet/faster-rcnn)" 
    exit 1
}
fi

##Check set
if [ $SET == "voc2007" ]
then {
    echo "voc2007"
}
elif [ $SET == "coco2017" ]
then {
    echo "coco2017"
}
else {
    echo "Error: Please chose correct set (voc2007/coco2017)"
    exit 1
}
fi

##Check trashold
check=$(awk -v x=$TRESHOLD 'BEGIN {if (x > 0.0 && x < 1.0) {print 1} else {print 0}}')
if [ $check = 1 ]
then echo $TRESHOLD
else {
    echo "Error: Treshold must be in [0.0 - 1.0]"
    exit 1
}
fi

#Move to project path
cd ..

OUTPUT="output/$NET/${NET}_${SET}.txt"
OUTPUT_CHECK="output/$NET/${NET}_${SET}_check.txt"
SET_UPPER=$(echo $SET | tr /a-z/ /A-Z/)
DATA="data/$SET_UPPER/Images"
IMAGES="data/$SET_UPPER/Txt/images.txt"

#start
start=$(date)
start_seconds=$(date +%s)

echo "Running $NET on $SET with treshold $TRESHOLD"
echo $OUTPUT
echo $OUTPUT_CHECK
echo $DATA
echo $IMAGES

#clean files
if [ -f $IMAGES ]
then rm $IMAGES
fi

if [ -f $OUTPUT ]
then rm $OUTPUT
fi

if [ -f $OUTPUT_CHECK ]
then rm $OUTPUT_CHECK
fi

#Net
    #darknet
    if [ $NET == "darknet" ]
    then {
        #darknet path
        cd nets/darknet

        #create images.txt
        ls ../../$DATA | while read imgname
        do
        echo "../../$DATA/$imgname" >> ../../$IMAGES
        done

        #detect images
        ./darknet detector test $MODEL $CFG $WEIGHTS -dont_show < ../../$IMAGES > ../../$OUTPUT -thresh $TRESHOLD

        #project path
        cd ../..
    }

    #faster-rcnn
    else {
        #move in faster-rcnn folder
        cd nets/py-faster-rcnn/tools

        #start image detection on Pascal Voc 2007
        python faster-rcnn_${SET}.py $TRESHOLD

        #return in project's folder
        cd ../../..
    }

    fi

#results
echo "____________________________________RESULTS____________________________________" >> $OUTPUT

#end
end=$(date)
end_seconds=$(date +%s)

total_time=$((end_seconds-start_seconds))

total_time_minutes=$((total_time/60))
remaining_seconds=$((total_time%60))
total_time_hours=$((total_time_minutes/60))
remaining_minutes=$((total_time_minutes%60))

echo Start: $start >> $OUTPUT
echo End: $end >> $OUTPUT

cd scripts

#calculate time in image detection
python3 totalTime_detection.py  $OUTPUT

echo "Total Time: $total_time seconds (${total_time_hours}h:${remaining_minutes}m:${remaining_seconds}s)." >> ../$OUTPUT

#check voc2007
if [ $SET == "voc2007" ]
then python3 check_output_voc.py $OUTPUT
fi

#return in project's folder
cd ..