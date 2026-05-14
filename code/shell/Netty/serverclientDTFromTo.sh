out1=24
out2=20

ROOT=/home/username
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT.sh  1>timecostServer_$i.log 2>&1 &
	sleep 1 
	timeout $out2 ./client2DT_expect.sh $ROOT/fuzz/Messages/Message$i.txt > timecostClient_$i.log
    sleep 6
	#rm $ROOT/netty/test1/*.em
	mv $ROOT/netty/test1/R*.*  $ROOT/netty/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "netty time:" `expr $stoptime - $starttime` >> timecostDT_$i.log
done  
