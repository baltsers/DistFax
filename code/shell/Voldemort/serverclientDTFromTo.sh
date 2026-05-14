out1=24
out2=20

source ./vd_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./vdServer_DT.sh  1>timecostServer_$i.log 2>&1 &
	sleep 1 
	timeout $out2 ./clientDT_expect.sh $ROOT/fuzz/VDs/VD$i.txt  1>timecostClient_$i.log 2>&1 
    sleep 18	
	mv $ROOT/voldemort/test1/R*.*  $ROOT/voldemort/test1/clientlog/$i
	#mv $ROOT/voldemort/test1/*.em  $ROOT/voldemort/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "Zookeeper time:" `expr $stoptime - $starttime` >> timecostDT_$i.log
done  
