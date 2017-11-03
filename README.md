# Prepare data

1. Run matlab script: *create_labels.m* .
[OUTPUT = *train_list.txt* or *test_list.txt*] 
This script creates a file *train_list.txt* that associates to each image its label.
It assumes that images are saved in a folder named as the object label.
The script also converts the images from .ppm (output of yarpdatadumper) into .jpg.

2. Open bash script *create_database.sh*, change path in DATA and run it
[OUTPUT = train_database or test_database]
[OUTPUT = train_mean.binaryproto or test_mean.binaryproto]
This script creates a database starting from the images and the *train_list.txt* file and the mean images.


# Train the network

1. From *dev/object_reco*, run 

./../caffe/build/tools/caffe train --solver=models/icub_alexnet/solver.prototxt 
