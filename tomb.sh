#!/bin/bash



echo "Create Tomb? (y/n) "
read dig

echo "Open Tomb? (y/n) "
read open

echo "Change password of a key? (y/n)"
read password_change

echo "Change tomb key? (y/n)"
read change_key


###
##Tomb Creation
###

if [ "dig" == "y" ]; then
echo "Tomb name?"
read tomb_name
echo "Tomb size? (Will be in MiB)"
read tomb_size
echo "Key name?"
read key_name

tomb dig -s $tomb_size $tomb_name.tomb
tomb forge $key_name.key
tomb lock $tomb_name.tomb -k $key_name.key

fi 

###
##Tomb creation
###

###
##Open Tomb
###
if [ "open" == "y" ]; then
echo "Tomb name?"
read tomb_name
echo "Key name?"
read key_name
tomb open $tomb_name.tomb -k $key_name.key
echo "to close, type 'tomb close' or if youre in a hurry, 'tomb slam all' which kills all programs using it"

fi

###
##Open Tomb
###

###
##Change Key Pass
###

if [ "password_change" == "y" ]; then
echo "Name of Key?"
read key_name
tomb passwd $key_name.key


fi
###
##Change Key Pass
###

###
##Change Tomb Key
###

if [ "change_key" == "y" ]; then
echo "Old tomb key:"
read old_key
echo "New key:"
read new_key
echo "Tomb name:"
read tomb_name

tomb -k $new_key.key $old_key.key $tomb_name.tomb

fi
