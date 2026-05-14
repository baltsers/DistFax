outs=6

source ./th_global.sh
#MAINCP=".:$subjectloc/bin"
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 $ROOT/fuzz/Messages/Message$i.txt
	timeout $outs ./client3DT.sh $ROOT/fuzz/Equations/Equation$i.txt > timecostclientDT3_$i.log
	sleep 2
	mv $subjectloc/test1/*.*  $subjectloc/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclientDT3_$i.log
done  
