MODEL=cfg/voc.data
CFG=cfg/yolo-voc.cfg
WEIGHTS=cfg/yolo-voc.weights
OUTPUT="output/darknet/darknet_voc2007.txt"
DATA="../../data/VOC2007/Images"
IMAGES="../../data/VOC2007/Txt/images.txt"
thresh=0.8

#start
start=$(date)
start_seconds=$(date +%s)

#darknet path
cd ../nets/darknet

#clean files
if [ -f $IMAGES ]
then rm $IMAGES
fi

if [ -f ../../$OUTPUT ]
then rm ../../$OUTPUT
fi

if [ -f ../../$OUTPUT_CHECK ]
then rm ../../$OUTPUT_CHECK
fi

#create images.txt
ls $DATA | while read imgname
do
echo "$DATA/$imgname" >> $IMAGES
done

#detect images
./darknet detector test $MODEL $CFG $WEIGHTS -dont_show < $IMAGES > ../../$OUTPUT -thresh $thresh

#project path
cd ../..

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

echo "Total Time: $total_time seconds (${total_time_hours}h:${remaining_minutes}m:${remaining_seconds}s)." >> $OUTPUT

#check
python3 check_output_voc.py $OUTPUT

#return in project's folder
cd ..
