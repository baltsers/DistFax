outs=26

ROOT=/home/username
input="./diff0Available.txt"
while read -r i
do  
  if [ "$i" -ge "$1" ] && [  "$i" -le "$2" ] 
  then 
	starttime=`date +%s%N | cut -b1-13`
	timeout $outs ./serverDT2BrPre.sh  1>timecostserverDT2BrPre_$i.log 2>&1 &
    sleep 6
	timeout $outs ./clientDT2BrPre_expect.sh $ROOT/fuzz/SQLs/SQL$i.txt > timecostclientDT2BrPre_$i.log
	sleep 5 
    rm ${subjectloc}/test1/R*.*
	mv ${subjectloc}/test1/branches*.*  ${subjectloc}/test1/clientlog/$i
	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclientDT_$i.log
  fi
done < "$input"

