#Copyright (c) 2017 Based Teenbro inc. All rights reserved
#Script Settings
THREAD="threads.txt"			#List of thread numbers - one number per line
IPTXT="proxies.txt"			#Proxy list document ie IP.txt - one IP per line
#################
directory=$(pwd)			#Directory used

IPN=$(wc -l < $IPTXT)
arr_proxy=($(cat $IPTXT))

if [ $IPN -gt 0 ]
	then
	function proxy {	#Function used for proxies
			VAL="$(( A - $(( IPN * $(( A / $IPN )) )) ))"
		    	export http_proxy="http://${arr_proxy[$VAL]}" 
		   	export https_proxy="$http_proxy"
	}

	else
	function proxy {	#Output if no proxies are in 'proxies.txt'
			echo "no proxies... have fun getting banned retard." & echo
}
fi

TN=$(wc -l < $THREAD)					
arr_thread=($(cat $THREAD))

if [ $TN -gt 0 ]
	then
	function func_thread {
		   
			TVAL="$(( A - $(( TN * $(( A / $TN)) )) ))"
		    	THREADO="${arr_thread[$TVAL]}" 

	}
	
	else
	echo "Error..."
	sleep 5
	exit
fi

function txt_img {	#Random text and images
		rand_text=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
		mx=10;my=10;head -c "$((3*mx*my))" /dev/urandom | convert -depth 8 -size "${mx}x${my}" RGB:- $rand_text.jpg
}
function lynx_post {		#Posting on lynxchan and its forks
		curl --connect-timeout 15 -X POST -F 'subject='$subject -F 'email='$email -F 'name='$name -F 'password'=$pass -F 'message='$rand_text -F 'boardUri='$uri -F 'files='@$rand_text.jpg --referer http://$site/$uri/ http://$site/newThread.js
	rm $rand_text.jpg
	date
}
function vi_post {		#Posting on vichan and its forks
     
		     curl --connect-timeout 15 \
			 --form "board="$uri  \
			 --form "message="$BODY \
			 --form "thread=$THREADO" \
			 --form "name=$name" \
			 --form "email=$email" \
			 --form "subject=$subject" \
			 --form "body=$BODY" \
			 --form "embed=" \
			 --form "dx=" \
			 --form "dy=" \
			 --form "dz=" \
			 --form "password="$pass \
			 --form "json_response=1"  \
			 --form "post=New Reply"  \
			 --referer https://$site/$uri/  \
		 https://$site/post.php
}

echo "Name to use: (if you enter nothing, it will default to the boards anonymous name)"
read name	#Name used on your post

echo "Email to use:"
read email	#Email used on your post

echo "Subject:"
read subject	#Subject used on your post

echo "Deletion pass:" #Used incase you want to delete your posts
read pass

echo "Domain:"
read site	#Website's domain, used for URLs. IP addresses may also be used

echo "Board URI:"
read uri	#Board's URI, example: b, am, pol, ect...

echo "Flood timeout: (in seconds)"
read timeout	#How long you have to wait inbetween posts

echo "Whats the sites software based on? (1 = lynxchan, 2 = vichan)"
read software	#Ask's what the the IB's software is based on, currently works with lynxchan, vichan, and their forks.

if [ "$software" == "1" ]; then

while true	#Repeats
do
	proxy
	txt_img
	lynx_post
	sleep $timeout
done

fi

if [ "$software" == "2" ]; then

A=0
RAND="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)"
RBODY="$BODY $RAND"

function func_rev {
		
		A=$(( A + 1 ))
		RAND="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)"
		
		RBODY="$BODY $RAND"
}
#Post Settings
BODY=$RAND

while true
	do
	proxy
	func_thread
	vi_post &
	func_rev
	echo
	sleep $timeout
done

fi
