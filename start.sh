#Move to scripts directory
cd scripts

#Run Darknet Yolo on Pascal VOC 2007 set
bash launch_net.sh darknet voc2007 0.8

#Run Faster-RCNN on Pascal VOC 2007 set
bash launch_net.sh faster-rcnn voc2007 0.8

#Run Darknet Yolo COCO set
bash launch_net.sh darknet coco2017 0.8

#Run Faster-RCNN COCO set
bash launch_net.sh faster-rcnn coco2017 0.8

#Return to project's directory
cd ..