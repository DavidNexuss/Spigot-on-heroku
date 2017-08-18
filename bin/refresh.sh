while :
do
	echo "Refreshing dyno"
  wget $HEROKU_URL
	sleep 60
done
