#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<ChatServer.core.MainServer: void main(java.lang.String[])>;<ChatServer.handler.ClientInfo: void setSocket(java.net.Socket)>"}

source ./mc_global.sh

#INDIR=$ROOT/multichat
INDIR=$ROOT/multichat
echo $INDIR
BINDIR=$ROOT/multichat/DTInstrumented
echo $BINDIR

#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$subjectloc/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint.jar:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx900m -ea -cp ${MAINCP} disttaint.dtAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"" \
	"-prec" \
	""
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

