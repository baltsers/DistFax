#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<voldemort.server.VoldemortServer: void main(java.lang.String[])>"}


source ./vd_global.sh

#INDIR=$ROOT/multichat
INDIR=$ROOT/voldemort/Diveroutdyn
echo $INDIR
BINDIR=$ROOT/voldemort/DiverInstrumented
echo $BINDIR

#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/soot-trunk.jar:$ROOT/libs/DUA1.jar:$ROOT/libs/distDIVER.jar:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx9200m -ea -cp ${MAINCP} Diver.DiverAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	4

stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0




