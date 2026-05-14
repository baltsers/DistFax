out1=14
out2=10
source ./xs_global.sh
input="./diff0Available.txt"

while read -r i
do  
  if [ "$i" -ge "$1" ] && [  "$i" -le "$2" ] 
  then 
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT2BrPre.sh  1>timecostServerDT2BrPre_$i.log 2>&1 &
	sleep 1 
	timeout $out2 ./client3DT2BrPre.sh $ROOT/fuzz/Messages/Message$i.txt > timecostClientDT2BrPre_$i.log
    sleep 6 
	rm $ROOT/xSocket/test1/R*.*
	mv $ROOT/xSocket/test1/branches*.*  $ROOT/xSocket/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "xSocket time:" `expr $stoptime - $starttime` >> timecostDT_$i.log
  fi
done < "$input"

