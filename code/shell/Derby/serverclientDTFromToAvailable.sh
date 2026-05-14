outs=26

ROOT=/home/username
input="./diff0Available.txt"
while read -r i
do  
  if [ "$i" -ge "$1" ] && [  "$i" -le "$2" ] 
  then 
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./serverDT.sh  1>timecostserverDT_$i.log 2>&1 &
    sleep 6
	timeout $outs ./clientDT_expect.sh $ROOT/fuzz/SQLs/SQL$i.txt > timecostclientDT_$i.log
	sleep 5 
    #rm ${subjectloc}/test1/R*.*
	mv ${subjectloc}/test1/*.em  ${subjectloc}/test1/clientlog/$i
	mv ${subjectloc}/test1/R*.em  ${subjectloc}/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclientDT_$i.log
  fi
done < "$input"

