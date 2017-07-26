#Copyright (c) 2017 Based Teenbro inc. All rights reserved
IPTXT="proxies.txt"			#Proxy list document ie IP.txt - one IP per line
directory=$(pwd)

echo "Name to use: (if you enter nothing, it will default to the boards anonymous name)"
read name

echo "Email to use:"
read email

echo "Subject:"
read subject

echo "Domain:"
read site

echo "Board URI:"
read uri

echo "Flood timeout: (in seconds)"
read timeout

echo "Whats the sites software based on? (lynxchan, vichan)"
read software

if [ "$software" == "lynxchan" ]; then


IPN=$(wc -l < $IPTXT)
arr_proxy=($(cat $IPTXT))

if [ $IPN -gt 0 ]
	then
	function func_prox {
			VAL="$(( A - $(( IPN * $(( A / $IPN )) )) ))"
		    	export http_proxy="http://${arr_proxy[$VAL]}" 
		   	export https_proxy="$http_proxy"
	}

	else
	function func_prox {
			echo "WARNING: NO PROXIES" & echo
}
fi
	function post {
	curl -X POST --form 'subject='$subject \
			--form 'email='$email \
			--form 'name='$name \
			--form 'message='$rand_text \
			--form 'boardUri='$uri \
			--form 'files='@$rand_text.jpg \
			--referer http://$site/$uri/ http://$site/newThread.js
	}
	function txt_img {
			rand_text=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
			mx=10;my=10;head -c "$((3*mx*my))" /dev/urandom | convert -depth 8 -size "${mx}x${my}" RGB:- $rand_text.jpg
	}
	function end {
			rm $rand_text.jpg
			date
		}
while true
do
	func_prox
	txt_img
	post
	end
	sleep $timeout
done

fi

if [ "$software" == "vichan" ]; then


#Script Settings
THREAD="threads.txt"			#List of thread numbers - one number per line
#################

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


IPN=$(wc -l < $IPTXT)					
arr_proxy=($(cat $IPTXT))

if [ $IPN -gt 0 ]
	then
	function func_prox {
			VAL="$(( A - $(( IPN * $(( A / $IPN )) )) ))"
		    	export http_proxy="http://${arr_proxy[$VAL]}" 
		   	export https_proxy="$http_proxy"
	}

	else
	function func_prox {
			echo "Youve got heart ill give you that.." & echo
			
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

function func_curl {
     
		     curl --connect-timeout 10 \
			 --form "board="$uri  \
			 --form "message="$ \
			 --form "thread=$THREADO" \
			 --form "name=$name" \
			 --form "email=$email" \
			 --form "subject=$subject" \
			 --form "body=$BODY" \
			 --form "embed=" \
			 --form "dx=" \
			 --form "dy=" \
			 --form "dz=" \
			 --form "password=0" \
			 --form "json_response=1"  \
			 --form "post=New Reply"  \
			 --referer https://$site/$uri/  \
		 https://$site/post.php
}

while true
	do
	func_prox
	func_thread
	func_curl &
	func_rev
	echo
	sleep $timeout
done

fi
