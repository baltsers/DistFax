outs=31

ROOT=/home/username
for((i=$1;i<=$2;i++)); 
do   
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./serverclientDT_expect.sh $ROOT/fuzz/Karafs/Karaf$i.txt > timecostclientDT_$i.log
	sleep 2 
	mv $ROOT/karaf/test1/R*.*  $ROOT/karaf/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclientDT_$i.log
done  
