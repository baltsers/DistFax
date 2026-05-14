outs=10

source ./qs_global.sh
#MAINCP=".:$ROOT/xSocket/bin"
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 $ROOT/fuzz/Messages/Message$i.txt
	timeout $outs ./serverDT2BrPre.sh  1>timecostServerDT2BrPre_$i.log  2>&1  &
	sleep 6 
    timeout $outs ./client2DT2BrPre.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient2DT2BrPre_$i.log
	sleep 4 
    #rm $ROOT/quickserver/test1/*.em
    mv $ROOT/quickserver/test1/branches*.* $ROOT/quickserver/test1/clientlog/$i
    stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostDT2BrPre_$i.log
done  
