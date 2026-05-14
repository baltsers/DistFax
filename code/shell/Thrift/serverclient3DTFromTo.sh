out1=17
out2=16

source ./th_global.sh
#MAINCP=".:$subjectloc/bin"
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	#timeout $outs java -cp ${MAINCP} XSocketClient3 /home/usernameMessages/Message$i.txt
	timeout $out1 ./serverDT.sh  1>timecostServer_$i.log 2>&1 &
	sleep 1 
	timeout $out2 ./client3DT.sh $ROOT/fuzz/Equations/Equation$i.txt > timecostclientDT3_$i.log
	sleep 16
	rm $subjectloc/test1/*.em
	mv $subjectloc/test1/R*.*  $subjectloc/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclientDT3_$i.log
done  
