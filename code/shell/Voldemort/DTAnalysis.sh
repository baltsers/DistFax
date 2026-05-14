#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<NioClient: void read(java.nio.channels.SelectionKey)>; <RspHandler: void waitForResponse()>"}
source ./vd_global.sh

#INDIR=$ROOT/voldemort
INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DTInstrumented
echo $BINDIR
#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint/bin:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx90g -ea -cp ${MAINCP} disttaint.dtAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"-debug" \
	"-prec" \
        ""
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

