outs=20

source ./gl_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./client2DT.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient2DT_$i.log
	sleep 3 
	mv $subjectloc/test1/*.*  $subjectloc/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclient2DT_$i.log
done  
