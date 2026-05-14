out1=14
out2=8

source ./xn_global.sh
input="./diff0Available.txt"

while read -r line
do  
  if [ "$line" -ge "$1" ] && [  "$line" -le "$2" ] 
  then 
  	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT.sh  1>timecostserver2DT_$line.log 2>&1 &
	sleep 2 	
	timeout $out2 ./client2DT.sh $ROOT/fuzz/Messages/Message$line.txt > timecostclient2DT_$line.log
	sleep 12  
	mv $ROOT/XNIO/test1/*.em  $ROOT/XNIO/test1/clientlog/$line
	mv $ROOT/XNIO/test1/R*.*  $ROOT/XNIO/test1/clientlog/$line
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclient2DT_$line.log
  fi
done < "$input"


