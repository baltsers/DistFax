outs=3

source ./ne_global.sh
#MAINCP=".:$ROOT/xSocket/bin"
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 $ROOT/fuzz/Messages/Message$i.txt
	timeout $outs ./client2_expect.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient2_$i.log
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclient2_$i.log
done  
