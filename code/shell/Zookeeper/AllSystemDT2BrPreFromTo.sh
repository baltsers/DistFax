out1=30
out2=24
out3=20

source ./zs_global.sh
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./zkServer_DT2BrPre.sh  $ROOT/fuzz/ZKConfs/ZKConf$i.txt 1>timecostServerDT2BrPre_${i}.log 2>&1 &
	sleep 3
	timeout $out2 ./zkContainerLoad_DT2BrPre.sh  1>timecostContainerDT2Brpre_${i}.log 2>&1 &
	sleep 3 
	timeout $out3 ./zkSystest_DT2BrPre.sh  1>timecostSystestDT2BrPre_${i}.log 2>&1 
	sleep 24 	
	mv $ROOT/zookeeper/test1/branches*.*  $ROOT/zookeeper/test1/clientlog/${i}
	stoptime=`date +%s%N | cut -b1-13`
	echo "zookeeper time:" `expr $stoptime - $starttime` >> timecostDT_$i.log

done  
