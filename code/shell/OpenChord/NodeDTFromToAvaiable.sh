out1=30
out2=20
out3=20

source ./chord_global.sh
input="./diff0Available.txt"

while read -r line
do  
  if [ "$line" -ge "$1" ] && [  "$line" -le "$2" ] 
  then 
	starttime=`date +%s%N | cut -b1-13`
	timeout $out1 ./serverDT_expect_A.sh $ROOT/fuzz/Chords/Chord$line.txt  1>timecostNodeADT_$line.log 2>&1 &
	sleep 1 
	timeout $out2 ./serverDT_expect_B.sh $ROOT/fuzz/Chords/Chord$line.txt  1>timecostNodeBDT_$line.log 2>&1 &
	timeout $out3 ./serverDT_expect_C.sh $ROOT/fuzz/Chords/Chord$line.txt  1>timecostNodeCDT_$line.log 2>&1 
	
	mv $ROOT/openchord/test1/R*.*  $ROOT/openchord/test1/clientlog/$line
	stoptime=`date +%s%N | cut -b1-13`
	echo "OpenChord time:" `expr $stoptime - $starttime` >> timecostDT_$line.log
  fi
done < "$input"
