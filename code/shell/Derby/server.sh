#!/bin/bash
source ./de_global.sh
ROOT=/home/username
export DERBY_HOME=$ROOT/derby
# export $DERBY_HOME
#source bin/setNetworkServerCP
#export CLASSPATH="${DERBY_HOME}/lib/derbynet.jar:${DERBY_HOME}/lib/derbytools.jar:${DERBY_HOME}/lib/derbyoptionaltools.jar:${CLASSPATH}"
MAINCP=".:${subjectloc}/lib:${DERBY_HOME}/lib/derbynet.jar:${DERBY_HOME}/lib/derbytools.jar:${DERBY_HOME}/lib/derbyoptionaltools.jar:${CLASSPATH}"

echo $MAINCP
starttime=`date +%s%N | cut -b1-13`
#java -cp ${MAINCP} org.apache.derby.drda.NetworkServerControl start
$DERBY_HOME/bin/setNetworkServerCP
#java org.apache.derby.drda.NetworkServerControl start
java -cp ${MAINCP} org.apache.derby.drda.NetworkServerControl start
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds 


