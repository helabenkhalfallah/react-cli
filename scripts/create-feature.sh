#!/bin/bash
# script launch : 
# create-feature feature-name

if [ "$1" = "" ] 
then 
  echo "Feature name is mandatory (example : create-feature your-feature-name)"
  exit -1;
fi

srcPath="../../js/features"
mkdir -p ${srcPath}/$1 
mkdir -p ${srcPath}/$1/pages ${srcPath}/$1/components ${srcPath}/$1/services ${srcPath}/$1/commons
echo "Feature $1 Created Successfully"