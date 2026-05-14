#!/bin/bash
source ${subjectloc}/de_global.sh
source ./de_global.sh
DERBY_HOME=$ROOT/derby
$DERBY_HOME/bin/setNetworkClientCP
MAINCP=".:${subjectloc}/distEAInstrumented:${DERBY_HOME}/lib/derbynet.jar:${DERBY_HOME}/lib/derbytools.jar:${DERBY_HOME}/lib/derbyoptionaltools.jar:${CLASSPATH}:$ROOT/DUA1.jar:$ROOT/distEA.jar:$ROOT/libs/soot-trunk.jar"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} DerbyTest 
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 



