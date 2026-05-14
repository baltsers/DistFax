outs=16

source ./qs_global.sh
#MAINCP=".:$ROOT/xSocket/bin"
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 $ROOT/fuzz/Messages/Message$i.txt
	timeout $outs ./serverDT.sh  1>timecostServerDT_$i.log  2>&1  &
	sleep 6 
    timeout $outs ./client2DT.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient2DT_$i.log
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclient2_$i.log
done  
