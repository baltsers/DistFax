#!/bin/bash
source ./gl_global.sh
source ./gl_global.sh
MAINCP=".$subjectloc/distEAInstrumented:$subjectloc/grizzly-framework-2.4.0.jar:$ROOT/distEA11.jar:$ROOT/libs/soot-trunk.jar:"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} EchoServer 
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



