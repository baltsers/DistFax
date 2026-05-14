out1=30
out2=25
out3=20

source ./zs_global.sh
for((i=$1;i<=$2;i++)); 
do   
	for((j=$3;j<=$4;j++)); 
	do  		
		for((k=$5;k<=$6;k++)); 
		do  
			starttime=`date +%s%N | cut -b1-13`
			timeout $out1 ./zkServer_DT.sh   1>timecostServerDT_${i}_${j}_${k}.log 2>&1 &
			sleep 3
			timeout $out2 ./zkContainerLoad_DT.sh  1>timecostContainerDT_${i}_${j}_${k}.log 2>&1 &
			sleep 3 
			timeout $out3 ./zkGenerateLoad123_DT.sh $i $j $k  1>timecostLoadDT_${i}_${j}_${k}.log 2>&1 
			sleep 24 	
			mv $ROOT/zookeeper/test1/R*.*  $ROOT/zookeeper/test1/clientlog/${i}_${j}_${k}
			stoptime=`date +%s%N | cut -b1-13`
			echo "zookeeper time:" `expr $stoptime - $starttime` >> timecostDT_$i.log
		done
	done
done  
