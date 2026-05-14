#!/bin/bash
source ${subjectloc}/de_global.sh
ROOT=/home/username
DERBY_HOME=$ROOT/derby
#source bin/setNetworkServerCP
#export CLASSPATH="${DERBY_HOME}/lib/derbynet.jar:${DERBY_HOME}/lib/derbytools.jar:${DERBY_HOME}/lib/derbyoptionaltools.jar:${CLASSPATH}"
MAINCP=".:${subjectloc}/DT2Instrumented:${CLASSPATH}:$ROOT/DUA1.jar:$ROOT/DistTaint2.jar:$ROOT/libs/soot-trunk.jar"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
$DERBY_HOME/bin/setNetworkServerCP
java -cp ${MAINCP} org.apache.derby.drda.NetworkServerControl start
#java org.apache.derby.drda.NetworkServerControl start
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 


