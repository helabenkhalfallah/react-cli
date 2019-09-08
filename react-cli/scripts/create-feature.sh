#!/bin/bash
# create-feature feature-name
# script creation : 
# 1/ go to project folder
# 2/ touch create-feature.sh
# 3/ chmod +x create-feature.sh
# 4/ alias create-feature='./create-feature.sh'

if [ "$1" = "" ] 
then 
  echo "Feature name is mandatory (example : create-feature your-feature-name)"
  exit -1;
fi

srcPath="./front-js/js/features"
mkdir -p ${srcPath}/$1 
mkdir -p ${srcPath}/$1/pages ${srcPath}/$1/components ${srcPath}/$1/services ${srcPath}/$1/commons
echo "Feature $1 Created Successfully"