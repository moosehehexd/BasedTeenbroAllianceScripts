#!/bin/bash


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


##File Extraction
echo "Extract message from image? (y/n) "
read extract
if [ "$extract" == "y" ]; then
steghide extract -sf $image.jpg
else
##File Extraction


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

fi
