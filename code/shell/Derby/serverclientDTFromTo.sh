outs=26

ROOT=/home/username
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./serverDT.sh  1>timecostserverDT_$i.log 2>&1 &
    sleep 6
	timeout $outs ./clientDT_expect.sh $ROOT/fuzz/SQLs/SQL$i.txt > timecostclientDT_$i.log
	sleep 5 
	mv ${subjectloc}/test1/R*.*  ${subjectloc}/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclientDT_$i.log
done  
