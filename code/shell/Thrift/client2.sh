#!/bin/bash
source ./th_global.sh
MAINCP=".:$subjectloc/0110/lib/java/build/libthrift-0.11.0.jar:$subjectloc/java/bin"
for i in $subjectloc/0110/lib/java/build/lib/*.jar;
do
	MAINCP=$MAINCP:$i
done
echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP}  CalculatorClient2
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds



