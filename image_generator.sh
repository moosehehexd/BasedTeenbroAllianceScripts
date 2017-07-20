while true
do
	mx=10;my=10;head -c "$((3*mx*my))" /dev/urandom | convert -depth 8 -size "${mx}x${my}" RGB:- /home/user_name/Desktop/image.jpg
	sleep 2.5
done
