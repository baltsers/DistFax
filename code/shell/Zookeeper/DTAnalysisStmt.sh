#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<ChatServer.core.MainServer: void main(java.lang.String[])> - \$r4 = new java.net.ServerSocket; <ChatClient.core.Sender: void run()> - \$r2 = new java.io.BufferedReader"}

source ./mc_global.sh

INDIR=$ROOT/multichat
#INDIR=$ROOT/TEST
echo $INDIR
BINDIR=$ROOT/multichat/DTInstrumented
echo $BINDIR

#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint/bin:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx900m -ea -cp ${MAINCP} disttaint.dtAnalysisStmt \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"-debug" \
	"" \
        ""
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

