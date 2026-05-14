source ./gl_global.sh
input="./diff0Available.txt"

starttime=`date +%s%N | cut -b1-13`
while read -r line
do  
  if [ "$line" -ge "$1" ] && [  "$line" -le "$2" ] 
  then   	
	echo "$line"
	echo " "
	java CountAttackSurfaceFromFiles  sourceSinkMethods2_1.txt  $ROOT/XNIO/test1/clientlog/$line/FL.txt
	#echo "\n"
  fi
done < "$input"

	stoptime=`date +%s%N | cut -b1-13`
	echo "client2 time:" `expr $stoptime - $starttime` >> timecostclient2DT_$line.log

