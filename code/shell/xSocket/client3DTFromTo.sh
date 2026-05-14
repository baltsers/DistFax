outs=6

source ./xs_global.sh
#MAINCP=".:$ROOT/xSocket/bin"
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 $ROOT/fuzz/Messages/Message$i.txt
	timeout $outs ./client3DT.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclientDT3_$i.log
	sleep 2
	mv $ROOT/xSocket/test1/*.*  $ROOT/xSocket/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclientDT3_$i.log
done  