outs=20

source ./gl_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./client2DT2BrPre.sh $ROOT/fuzz/Messages/Message$i.txt > timecostclient2DT2BrPre_$i.log
	sleep 3 
    rm $subjectloc/test1/R*.*
	mv $subjectloc/test1/branches*.*  $subjectloc/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 DT2BrPre time:" `expr $stoptime - $starttime` >> timecostclient2DT2BrPre_$i.log
done  
