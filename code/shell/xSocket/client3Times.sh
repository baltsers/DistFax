outs=2

source ./xs_global.sh
#MAINCP=".:$ROOT/xSocket/bin"
for((i=1;i<=$1;i++)); 
do  	
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 $ROOT/fuzz/Messages/Message$i.txt
	timeout $outs ./client3.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient3_$i.log
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclient3_$i.log
done  
