outs=3

source ./th_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./client2DT.sh  > timecostclientDT2_$i.log
	sleep 1
	mv $subjectloc/test1/*.*  $subjectloc/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client3 time:" `expr $stoptime - $starttime` >> timecostclientDT2_$i.log
done  
