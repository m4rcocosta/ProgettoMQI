#Move to scripts directory
cd scripts

#Run Darknet Yolo on Pascal VOC 2007 set
bash launch_darknet_voc.sh

#Run Faster-RCNN on Pascal VOC 2007 set
bash launch_faster_voc.sh

#Run Darknet Yolo COCO set
bash launch_darknet_coco.sh

#Run Faster-RCNN COCO set
bash launch_faster_coco.sh

#Return to project's directory
cd ..