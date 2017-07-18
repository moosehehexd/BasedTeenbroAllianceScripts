#!/bin/bash

##File Extraction
echo "Are you extracting a message from an image? (y/n) "
read extract
if [ "$extract" == "y" ]; then
echo "Image name:"
read image
steghide extract -sf $image.jpg
##File Extraction

else

##Text Editor
echo "Which text editor will you be using? (vim, nano, ect...) "
read editor
##Text Editor


##Image Name
echo "Name of image: "
read image
##Image Name


##File Name
echo "File name: "
read txt
##File Name


##For Generating The Image
echo "Generating Image"
mx=1500;my=1500;head -c "$((3*mx*my))" /dev/urandom | convert -depth 8 -size "${mx}x${my}" RGB:- $image.jpg
##For Generating The Image


##File Creation
echo "Creating File"
$editor /tmp/$txt.txt
##File Creation


##File Embedding
echo "Embedding File"
steghide embed -cf $image.jpg -ef /tmp/$txt.txt
##File Embedding

##Removing File After Being Embedded
shred -z -n 5 -u /tmp/$txt.txt
##Removing File After Being Embedded


fi
