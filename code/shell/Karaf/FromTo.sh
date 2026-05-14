outs=31

ROOT=/home/username

input="./diffAvailable.txt"
while read -r line
do  
  if [ "$line" -ge "$1" ] && [  "$line" -le "$2" ] 
  then 
	echo "$line"
  fi
done < "$input"


