out1=30
out2=24
out3=20

source ./zs_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./zkServer_1_DT.sh  $ROOT/fuzz/ZKConfs/ZKConf$i.txt 1>timecostServerDT_${i}.log 2>&1 &
	sleep 3
	timeout $out2 ./zkContainerLoad_DT.sh  1>timecostContainerDT_${i}.log 2>&1 &
	sleep 3 
	timeout $out3 ./zkSystest_DT.sh  1>timecostSystestDT_${i}.log 2>&1 
	sleep 24 	
	mv $ROOT/zookeeper/test1/*.em  $ROOT/zookeeper/test1/clientlog/${i}
	mv $ROOT/zookeeper/test1/R*.*  $ROOT/zookeeper/test1/clientlog/${i}
	stoptime=`date +%s%N | cut -b1-13`
	echo "zookeeper time:" `expr $stoptime - $starttime` >> timecostDT_$i.log

done  
