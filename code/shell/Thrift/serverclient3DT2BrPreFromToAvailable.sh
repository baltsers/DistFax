out1=14
out2=8

source ./th_global.sh
input="./diff0Available.txt"

while read -r line
do  
  if [ "$line" -ge "$1" ] && [  "$line" -le "$2" ] 
  then 
  	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT2BrPre.sh  1>timecostserverDT2BrPre_$line.log 2>&1 &
	sleep 2 	
	timeout $out2 ./client3DT2BrPre.sh $ROOT/fuzz/Messages/Message$line.txt > timecostclient3DT2BrPre_$line.log
	sleep 12  
	#rm $subjectloc/test1/*.em
	mv $subjectloc/test1/branch*.*  $subjectloc/test1/clientlog/$line
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostDT2BrPre_$line.log
  fi
done < "$input"


