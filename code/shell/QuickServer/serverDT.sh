#!/bin/bash
source ./qs_global.sh
#MAINCP=".:$ROOT/quickserver/java/helloworld.jar"
MAINCP="$ROOT/quickserver/DTInstrumented:.:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
for i in $subjectloc/lib/*.jar;
do
	MAINCP=$MAINCP:$i
done

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} org.quickserver.net.server.QuickServer -load HelloWorld.xml -cp ${MAINCP}
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



