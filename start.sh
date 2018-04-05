args=("$@")
if [ $# -ne 1 ]
then {
    echo "Error: Please insert correct parameters (TRESHOLD[0.0-1.0])"
    exit 1
}  
fi

TRESHOLD=${args[0]}

#Move to scripts directory
cd scripts

#Run Darknet Yolo on Pascal VOC 2007 set
bash launch_net.sh darknet voc2007 $TRESHOLD

#Run Faster-RCNN on Pascal VOC 2007 set
bash launch_net.sh faster-rcnn voc2007 $TRESHOLD

#Run Darknet Yolo COCO set
bash launch_net.sh darknet coco2017 $TRESHOLD

#Run Faster-RCNN COCO set
bash launch_net.sh faster-rcnn coco2017 $TRESHOLD

#Return to project's directory
cd ..