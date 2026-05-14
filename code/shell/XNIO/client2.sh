#!/bin/bash
source ./gl_global.sh
MAINCP=".:$ROOT/XNIO/jar/xnio-api-2.0.0.GA.jar"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} Client
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



