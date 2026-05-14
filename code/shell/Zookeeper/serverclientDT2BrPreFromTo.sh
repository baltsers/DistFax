out1=24
out2=20

source ./zs_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./zkServer_DT2BrPre.sh  1>timecostServerDT2BrPre_$i.log 2>&1 &
	sleep 6 
	timeout $out2 ./clientDT2BrPre_expect.sh $ROOT/fuzz/ZKs/ZK$i.txt  1>timecostClientDT2Brpre_$i.log 2>&1 
    sleep 8 	
	rm $ROOT/zookeeper/test1/R*.*
    mv $ROOT/zookeeper/test1/branches*.*  $ROOT/zookeeper/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "Zookeeper time:" `expr $stoptime - $starttime` >> timecostDT_$i.log
done  
