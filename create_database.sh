#!/usr/bin/env sh
# Create the database lmdb inputs and mean images
# N.B. set the path to the training images + val data dirs
set -e

FOLDER_CAFFE=../caffe/build/tools

DATA=data/neuro_iCub
TRAIN_DATA_ROOT=$DATA/train
TRAIN_FILE=$DATA/train/train_list.txt
TRAINDB_NAME=$DATA/train/train_database

TEST_DATA_ROOT=$DATA/test
TEST_FILE=$DATA/test/test_list.txt
TESTDB_NAME=$DATA/test/test_database

BACKEND="lmdb"
ENCODE_TYPE='jpg'
RESIZE_WIDTH=100
RESIZE_HEIGHT=100


if [ ! -d "$TRAIN_DATA_ROOT" ]; then
  echo "Error: TRAIN_DATA_ROOT is not a path to a directory: $TRAIN_DATA_ROOT"
  echo "Set the TRAIN_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the training data is stored."
  exit 1
fi

if [ ! -d "$TEST_DATA_ROOT" ]; then
  echo "Error: TEST_DATA_ROOT is not a path to a directory: $TEST_DATA_ROOT"
  echo "Set the TEST_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the validation data is stored."
  exit 1
fi

echo "Creating train lmdb..."
rm -rf $TRAINDB_NAME

echo "RESIZING IMAGES TO $RESIZE_WIDTH x $RESIZE_HEIGHT"

GLOG_logtostderr=1 $FOLDER_CAFFE/convert_imageset \
    --backend=$BACKEND \
    --resize_width=$RESIZE_WIDTH \
    --resize_height=$RESIZE_HEIGHT \
    --encode_type=$ENCODE_TYPE \
    --shuffle \
    $TRAIN_DATA_ROOT \
    $TRAIN_FILE \
    $TRAINDB_NAME

echo "Creating mean images for train lmdb..."
$FOLDER_CAFFE/compute_image_mean $TRAINDB_NAME \
  $TRAIN_DATA_ROOT/train_mean.binaryproto

echo "Creating test lmdb..."
rm -rf $TESTDB_NAME

GLOG_logtostderr=1 $FOLDER_CAFFE/convert_imageset \
    --backend=$BACKEND \
    --resize_width=$RESIZE_WIDTH \
    --resize_height=$RESIZE_HEIGHT \
    --encode_type=$ENCODE_TYPE \
    --shuffle \
    $TEST_DATA_ROOT \
    $TEST_FILE \
    $TESTDB_NAME

echo "Creating mean images for test lmdb..."
$FOLDER_CAFFE/compute_image_mean $TESTDB_NAME \
  $TEST_DATA_ROOT/test_mean.binaryproto

echo "Done."
