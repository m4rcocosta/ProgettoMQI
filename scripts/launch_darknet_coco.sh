MODEL=cfg/voc.data
CFG=cfg/yolo-voc.cfg
WEIGHTS=cfg/yolo-voc.weights
OUTPUT="output/darknet/darknet_coco2017.txt"
DATA="../../data/COCO2017/Images"
IMAGES="../../data/COCO2017/images.txt"
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
python3 totalTime_darknet_coco.py 

echo "Total Time: $total_time seconds (${total_time_hours}h:${remaining_minutes}m:${remaining_seconds}s)." >> $OUTPUT

#return in project's folder
cd ..