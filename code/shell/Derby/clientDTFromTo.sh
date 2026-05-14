outs=10

source ./de_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./clientDT_expect.sh $ROOT/fuzz/SQLs/SQL$i.txt > timecostclient2DT_$i.log
	sleep 3 
	mv ${subjectloc}/test1/*.*  ${subjectloc}/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclient2DT_$i.log
done  
