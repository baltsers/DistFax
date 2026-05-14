#!/bin/bash
source ./qs_global.sh
MAINCP="."
# for i in $subjectloc/lib/*.jar;
#do
#	MAINCP=$MAINCP:$i
#done

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} HelloWorldClient 127.0.0.1 2000
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



