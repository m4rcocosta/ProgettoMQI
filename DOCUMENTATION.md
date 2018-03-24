# **DOCUMENTATION-ProgettoMQI**

## **Author**
* [**_Marco Costa_**](https://github.com/marco-96)

## **Languages used for the project**
* [**C**](https://en.wikipedia.org/wiki/C_(programming_language))
* [**Python**](https://en.wikipedia.org/wiki/Python_(programming_language)) - Both 2.7 and 3.6 versions
* [**Bash**](https://en.wikipedia.org/wiki/Bash_(Unix_shell))

## **Analyzed Networks**
* [**Darknet Yolo**](https://pjreddie.com/darknet/yolo/) - YOLO: Real-Time Object Detection
* [**Faster-RCNN**](https://github.com/rbgirshick/py-faster-rcnn) - ZF model

## **Purpose**
Compare two different types of Neural Networks on image detection.
Both the networks are trained on Pascal VOC set and runs on the same hardware.
They can identify 20 different categories:
* Person
* Animals:
    * Bird
    * Cat
    * Cow
    * Dog
    * Horse
    * Sheep
* Vehicles:
    * Aeroplane
    * Bicycle
    * Boat
    * Bus
    * Car
    * Motorbike
    * Train
* Home Objects:
    * Bottle
    * Chair
    * Dining Table
    * Potted Plant
    * Sofa
    * Tv/Monitor

## **Features**
### **Darknet**
* Written in C;
* How it works:
    * It applies a single neural network to the full image;
    * This network divides the image into regions and predicts bounding boxes and probabilities for each region;
    * These bounding boxes are weighted by the predicted probabilities;
* Advantages: 
    * It looks at the whole image at test time so its predictions are informed by global context in the image;
    * It also makes predictions with a single network evaluation unlike systems like R-CNN which require thousands for a single image;
    * This makes it extremely fast, more than 1000x faster than [R-CNN](https://github.com/rbgirshick/rcnn) and 100x faster than [Fast R-CNN](https://github.com/rbgirshick/fast-rcnn);

### **Faster-RCNN**
* Written in Python and Caffe;
* Some operations execute on the CPU in Python layers;
* Faster R-CNN has two networks:
    * Region proposal network (RPN) for generating region proposals;
    * A network using these proposals to detect objects;