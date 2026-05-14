#!/bin/bash
source ./de_global.sh
source ./de_global.sh
DERBY_HOME=$ROOT/derby
#source bin/setNetworkClientCP
MAINCP=".:${subjectloc}/DT2BrPre:${DERBY_HOME}/lib/derbynet.jar:${DERBY_HOME}/lib/derbytools.jar:${DERBY_HOME}/lib/derbyoptionaltools.jar:${CLASSPATH}:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
$DERBY_HOME/bin/setNetworkClientCP
java -cp ${MAINCP} org.apache.derby.tools.ij
#java org.apache.derby.drda.NetworkServerControl start
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 
