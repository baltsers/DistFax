out1=14
out2=8

source ./xn_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT.sh  1>timecostserver2DT_$i.log 2>&1 &
	sleep 2 	
	timeout $out2 ./client2DT.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient2DT_$i.log
	sleep 12  
	mv $ROOT/XNIO/test1/R*.*  $ROOT/XNIO/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclient2DT_$i.log
done  
