#!/bin/bash
source ./gl_global.sh
MAINCP=".:$subjectloc/grizzly-framework-2.4.0.jar"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} EchoClient
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



