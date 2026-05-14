out1=14
out2=8

source ./xn_global.sh
input="./diff0Available.txt"

while read -r line
do  
  if [ "$line" -ge "$1" ] && [  "$line" -le "$2" ] 
  then 
  	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT2BrPre.sh  1>timecostserver2DT2BrPre_$line.log 2>&1 &
	sleep 2 	
	timeout $out2 ./client2DT2BrPre.sh $ROOT/fuzz/Messages/Message$line.txt > timecostclient2DT2BrPre_$line.log
	sleep 12  
	#rm $ROOT/XNIO/test1/*.em
	mv $ROOT/XNIO/test1/branch*.*  $ROOT/XNIO/test1/clientlog/$line
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclient2DT_$line.log
  fi
done < "$input"


