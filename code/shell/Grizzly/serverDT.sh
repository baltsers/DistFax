#!/bin/bash
source ./gl_global.sh
MAINCP=".:$subjectloc/DTInstrumented:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} EchoServer
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



