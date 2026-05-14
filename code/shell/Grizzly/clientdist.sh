#!/bin/bash
source ../ne_global.sh
source ./gl_global.sh
MAINCP=".:$ROOT/netty/distEAInstrumented:$ROOT/DUA1.jar:$ROOT/distEA.jar:$ROOT/libs/soot-trunk.jar:"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} Client
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



