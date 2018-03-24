OUTPUT="output/faster/faster-rcnn_coco2017.txt"

#start
start=$(date)
start_seconds=$(date +%s)

#clean files
if [ -f ../$OUTPUT ]
then rm ../$OUTPUT
fi

#move in faster-rcnn folder
cd ../nets/py-faster-rcnn/tools

#start image detection on Pascal Voc 2007
python faster-rcnn_coco.py

#return in project's folder
cd ../../..

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

#scripts directory
cd scripts

#calculate time in image detection
python3 totalTime_detection.py  $OUTPUT

echo "Total Time: $total_time seconds (${total_time_hours}h:${remaining_minutes}m:${remaining_seconds}s)." >> ../$OUTPUT

#return in project's folder
cd ..