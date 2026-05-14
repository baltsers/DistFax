#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<voldemort.store.socket.clientrequest.ClientRequestExecutorFactory$ClientRequestSelectorManager: void processEvents()> - \$r6 = virtualinvoke r58.<java.nio.channels.SelectionKey: java.lang.Object attachment()>(); <voldemort.VoldemortClientShell: void printObject(java.lang.Object)> - virtualinvoke \$r3.<java.io.PrintStream: void print(java.lang.String)>(\$r5)"}

source ./vd_global.sh


INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DT2Instrumented
echo $BINDIR

#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint/bin:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx10g -ea -cp ${MAINCP} disttaint.dt2Analysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"" \
	"" \
    "" \
	"" \
    "" \ 
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0




